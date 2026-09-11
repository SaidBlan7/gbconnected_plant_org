INSERT INTO core.organization (
    organization_id,
    organization_code,
    organization_name,
    is_active
)
VALUES
    (1, 'MX', 'Organización México', TRUE),
    (2, 'US', 'Organización Estados Unidos', TRUE)
ON CONFLICT (organization_id) DO NOTHING;


-- ============================================================
-- 2. PLANTAS
-- ============================================================

INSERT INTO core.plant (
    plant_id,
    organization_id,
    plant_code,
    plant_name,
    erp_plant_code,
    country_code,
    region_code,
    address,
    timezone_name,
    language_code,
    is_active
)
VALUES
    (
        1,
        1,
        'TOL',
        'Planta Toluca',
        'ERP-TOL',
        'MX',
        'CENTRO',
        'Toluca, Estado de México',
        'America/Mexico_City',
        'es-MX',
        TRUE
    ),
    (
        2,
        1,
        'PUE',
        'Planta Puebla',
        'ERP-PUE',
        'MX',
        'CENTRO',
        'Puebla, Puebla',
        'America/Mexico_City',
        'es-MX',
        TRUE
    ),
    (
        3,
        2,
        'TX',
        'Planta Texas',
        'ERP-TX',
        'US',
        'SOUTH',
        'Texas, United States',
        'America/Chicago',
        'en-US',
        TRUE
    )
ON CONFLICT (plant_id) DO NOTHING;


-- ============================================================
-- 3. ACCESOS PARA EL USUARIO MOCK DEL MICROSERVICIO USERS
-- ============================================================

INSERT INTO app_security.user_plant_access (
    entra_tenant_id,
    entra_object_id,
    plant_id,
    is_active,
    created_by,
    updated_by
)
VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        1,
        TRUE,
        'LOCAL_TEST',
        'LOCAL_TEST'
    ),
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        2,
        TRUE,
        'LOCAL_TEST',
        'LOCAL_TEST'
    )
ON CONFLICT (
    entra_tenant_id,
    entra_object_id,
    plant_id
) DO NOTHING;
