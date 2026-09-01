-- ============================================================
-- Datos de prueba para AUTH_MODE=mock
-- Deben coincidir con backend/local.settings*.json
-- ============================================================

INSERT INTO gb_access.organizations (id, code, name)
VALUES
    ('org-mx', 'MX', 'Organización México'),
    ('org-us', 'US', 'Organización Estados Unidos')
ON CONFLICT (id) DO UPDATE SET
    code = EXCLUDED.code,
    name = EXCLUDED.name,
    active = TRUE;

INSERT INTO gb_access.plants (id, organization_id, code, name)
VALUES
    ('plant-tol', 'org-mx', 'TOL', 'Planta Toluca'),
    ('plant-pue', 'org-mx', 'PUE', 'Planta Puebla'),
    ('plant-tx',  'org-us', 'TX',  'Planta Texas')
ON CONFLICT (id) DO UPDATE SET
    organization_id = EXCLUDED.organization_id,
    code = EXCLUDED.code,
    name = EXCLUDED.name,
    active = TRUE;

-- Usuario local ficticio: SOLO México / Toluca y Puebla.
INSERT INTO gb_access.user_plant_access (
    entra_tenant_id,
    entra_object_id,
    plant_id,
    active
)
VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        'plant-tol',
        TRUE
    ),
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        'plant-pue',
        TRUE
    )
ON CONFLICT (entra_tenant_id, entra_object_id, plant_id)
DO UPDATE SET active = TRUE;
