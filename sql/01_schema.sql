
-- 1. EXTENDER EL MAESTRO DE PRODUCTO TERMINADO
-- core.product ya contiene el maestro del PT.
-- Estos atributos pertenecen al producto, no a una línea específica.

ALTER TABLE core.product
    ADD COLUMN base_dough_id bigint NOT NULL,
    ADD COLUMN is_default_item boolean NOT NULL DEFAULT false,
    ADD COLUMN is_semi_finished boolean NOT NULL DEFAULT false,
    ADD COLUMN semi_finished_uom varchar(10),
    ADD COLUMN has_lid_design_waste boolean NOT NULL DEFAULT false,
    ADD COLUMN lid_design_waste_weight_kg numeric(18, 6),
    ADD COLUMN has_edge_design_waste boolean NOT NULL DEFAULT false,
    ADD COLUMN edge_design_waste_weight_kg numeric(18, 6);


-- 2. MASA BASE ÚNICA DEL PT
-- La especificación indica:
--   - un PT tiene una sola masa base;
--   - una masa puede tener varios PT.
--
-- base_dough_id queda como la relación oficial PT -> masa.

ALTER TABLE core.product
    ADD CONSTRAINT fk_product_base_dough
    FOREIGN KEY (base_dough_id)
    REFERENCES core.dough(dough_id);


CREATE INDEX idx_product_base_dough
    ON core.product(base_dough_id);


-- Se conserva core.product_dough porque ya forma parte del modelo y también
-- relaciona el PT con las líneas donde aplica.
--
-- Esta restricción evita que el mismo PT termine relacionado con otra masa
-- distinta en product_dough.
--
-- Ejemplo permitido:
--   PT 10 / Línea 1 / Masa 5
--   PT 10 / Línea 2 / Masa 5
--
-- Ejemplo rechazado:
--   PT 10 / Línea 1 / Masa 5
--   PT 10 / Línea 2 / Masa 8

ALTER TABLE core.product
    ADD CONSTRAINT uq_product_id_base_dough
    UNIQUE (product_id, base_dough_id);


ALTER TABLE core.product_dough
    ADD CONSTRAINT fk_product_dough_matches_base
    FOREIGN KEY (product_id, dough_id)
    REFERENCES core.product(product_id, base_dough_id)
    DEFERRABLE INITIALLY DEFERRED;


-- 3. ÚNICO ITEM DEFAULT POR MASA
-- El campo existente:
--   packaging.line_product_configuration.is_default_item
-- está a nivel línea + producto.
--
-- La nueva regla funcional es a nivel masa:
--   una masa puede tener muchos PT,
--   pero sólo uno de ellos puede ser el default.
--
-- Por eso core.product.is_default_item será la fuente de verdad.
-- El campo anterior se conserva por compatibilidad con el modelo actual.

CREATE UNIQUE INDEX uq_product_default_per_dough
    ON core.product(base_dough_id)
    WHERE is_default_item = true
      AND is_active = true;


-- Un PT inactivo no debe seguir funcionando como default de nuevos procesos.
ALTER TABLE core.product
    ADD CONSTRAINT ck_product_inactive_not_default
    CHECK (
        is_active = true
        OR is_default_item = false
    );


-- 4. PT SEMITERMINADO
-- El switch "Semiterminado" pertenece al PT.
-- Cuando está activo, la especificación permite registrar el producto en:
--   - PIECE = piezas
--   - KG    = kilogramos
--
-- core.semi_finished_product NO se reutiliza para esto porque representa
-- otro catálogo funcional del modelo.

ALTER TABLE core.product
    ADD CONSTRAINT ck_product_semi_finished
    CHECK (
        (
            is_semi_finished = false
            AND semi_finished_uom IS NULL
        )
        OR
        (
            is_semi_finished = true
            AND semi_finished_uom IN ('PIECE', 'KG')
        )
    );

-- 5. DESPERDICIO DE DISEÑO: TAPAS
-- Si el PT genera desperdicio de diseño por tapas:
--   - la bandera debe estar activa;
--   - el peso teórico es obligatorio;
--   - el peso debe ser mayor que cero.
--
-- Si la bandera está apagada, el peso debe permanecer NULL.

ALTER TABLE core.product
    ADD CONSTRAINT ck_product_lid_design_waste
    CHECK (
        (
            has_lid_design_waste = false
            AND lid_design_waste_weight_kg IS NULL
        )
        OR
        (
            has_lid_design_waste = true
            AND lid_design_waste_weight_kg IS NOT NULL
            AND lid_design_waste_weight_kg > 0
        )
    );

-- 6. DESPERDICIO DE DISEÑO: ORILLAS
-- Tapas y orillas son configuraciones independientes.

ALTER TABLE core.product
    ADD CONSTRAINT ck_product_edge_design_waste
    CHECK (
        (
            has_edge_design_waste = false
            AND edge_design_waste_weight_kg IS NULL
        )
        OR
        (
            has_edge_design_waste = true
            AND edge_design_waste_weight_kg IS NOT NULL
            AND edge_design_waste_weight_kg > 0
        )
    );

-- 7. CÓDIGO DE INTEGRACIÓN POR LÍNEA
-- core.product.oracle_item_code conserva el código ERP / código principal.
--
-- La pantalla actual muestra casos donde el campo "Código" puede ser:
--   PRIMARY
--   SECONDARY
-- mientras "Código principal" conserva el item ERP real.
--
-- Ese alias puede depender de la línea/integración, por eso se almacena en
-- line_product_configuration y NO directamente en core.product.
--
-- Se deja varchar libre porque futuros valores pueden provenir de Oracle/WMS.

ALTER TABLE packaging.line_product_configuration
    ADD COLUMN integration_item_code varchar(100);

-- 8. AUDITORÍA DEL CATÁLOGO DE PT
-- La especificación pide auditar:
--   - alta;
--   - edición;
--   - estado;
--   - item default;
--   - semiterminado;
--   - desperdicio de diseño;
--   - origen manual / Oracle / carga masiva;
--   - intentos rechazados.
--
-- created_at / updated_at de core.product no contienen suficiente información
-- para cumplir ese requerimiento, por eso se agrega una tabla de auditoría.

CREATE TABLE core.product_audit_log (
    product_audit_log_id bigint
        PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,

    product_id bigint,
    organization_id bigint NOT NULL,
    line_id bigint,

    item_code varchar(100),

    event_type varchar(60) NOT NULL,
    event_status varchar(20) NOT NULL,

    source_type varchar(30) NOT NULL,
    actor varchar(255) NOT NULL DEFAULT 'SYSTEM',
    correlation_id varchar(100),

    old_values jsonb,
    new_values jsonb,
    details jsonb,

    recorded_at timestamp with time zone
        DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT fk_product_audit_product
        FOREIGN KEY (product_id)
        REFERENCES core.product(product_id),

    CONSTRAINT fk_product_audit_organization
        FOREIGN KEY (organization_id)
        REFERENCES core.organization(organization_id),

    CONSTRAINT fk_product_audit_line
        FOREIGN KEY (line_id)
        REFERENCES core.production_line(line_id),

    CONSTRAINT ck_product_audit_status
        CHECK (
            event_status IN ('SUCCESS', 'REJECTED')
        ),

    CONSTRAINT ck_product_audit_source
        CHECK (
            source_type IN (
                'MANUAL',
                'ORACLE',
                'WMS',
                'BULK_LOAD',
                'SYSTEM'
            )
        )
);


CREATE INDEX idx_product_audit_product_time
    ON core.product_audit_log(product_id, recorded_at DESC);

CREATE INDEX idx_product_audit_org_time
    ON core.product_audit_log(organization_id, recorded_at DESC);

CREATE INDEX idx_product_audit_line_time
    ON core.product_audit_log(line_id, recorded_at DESC);

CREATE INDEX idx_product_audit_correlation
    ON core.product_audit_log(correlation_id)
    WHERE correlation_id IS NOT NULL;