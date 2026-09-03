CREATE SCHEMA IF NOT EXISTS app_security;

CREATE SCHEMA IF NOT EXISTS app_api;

CREATE TABLE IF NOT EXISTS app_security.user_plant_access (

    entra_tenant_id UUID NOT NULL,

    entra_object_id UUID NOT NULL,

    plant_id BIGINT NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    created_by VARCHAR(255)
        NOT NULL DEFAULT 'GBC_ACCESS_API',

    updated_at TIMESTAMP WITH TIME ZONE
        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_by VARCHAR(255)
        NOT NULL DEFAULT 'GBC_ACCESS_API',

    CONSTRAINT user_plant_access_pkey
        PRIMARY KEY (
            entra_tenant_id,
            entra_object_id,
            plant_id
        ),

    CONSTRAINT fk_user_plant_access_plant
        FOREIGN KEY (plant_id)
        REFERENCES core.plant(plant_id)
);

CREATE INDEX IF NOT EXISTS idx_user_plant_access_user
ON app_security.user_plant_access (
    entra_tenant_id,
    entra_object_id
)
WHERE is_active = TRUE;

CREATE OR REPLACE VIEW app_api.v_user_organizations
AS

SELECT DISTINCT

    ua.entra_tenant_id,
    ua.entra_object_id,

    o.organization_id,
    o.organization_code,
    o.organization_name

FROM app_security.user_plant_access ua

JOIN core.plant p
    ON p.plant_id = ua.plant_id

JOIN core.organization o
    ON o.organization_id = p.organization_id

WHERE
    ua.is_active = TRUE
    AND p.is_active = TRUE
    AND o.is_active = TRUE;CREATE OR REPLACE VIEW app_api.v_user_plants
AS

SELECT

    ua.entra_tenant_id,
    ua.entra_object_id,

    o.organization_id,

    p.plant_id,
    p.plant_code,
    p.plant_name

FROM app_security.user_plant_access ua

JOIN core.plant p
    ON p.plant_id = ua.plant_id

JOIN core.organization o
    ON o.organization_id = p.organization_id

WHERE
    ua.is_active = TRUE
    AND p.is_active = TRUE
    AND o.is_active = TRUE;

  SELECT

    o.organization_id,
    o.organization_code,
    o.organization_name,

    p.plant_id,
    p.plant_code,
    p.plant_name

FROM core.organization o

JOIN core.plant p
    ON p.organization_id = o.organization_id

WHERE
    o.is_active = TRUE
    AND p.is_active = TRUE

ORDER BY
    o.organization_name,
    p.plant_name;