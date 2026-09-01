-- ====================================================================
-- ASIGNAR PLANTAS A UN USUARIO REAL DE MICROSOFT ENTRA ID
--
-- Obtén los valores reales llamando, ya desplegado con Easy Auth:
-- GET https://TU-FUNCTION.azurewebsites.net/api/debug/whoami
--
-- Luego reemplaza los UUID y las plantas de abajo.
-- ====================================================================

INSERT INTO gb_access.user_plant_access (
    entra_tenant_id,
    entra_object_id,
    plant_id,
    active
)
VALUES
    (
        'REEMPLAZAR-TENANT-ID'::uuid,
        'REEMPLAZAR-OBJECT-ID'::uuid,
        'plant-tol',
        TRUE
    )
ON CONFLICT (entra_tenant_id, entra_object_id, plant_id)
DO UPDATE SET active = TRUE;
