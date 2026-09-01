-- Verifica datos base
SELECT * FROM gb_access.organizations ORDER BY name;
SELECT * FROM gb_access.plants ORDER BY organization_id, name;
SELECT * FROM gb_access.user_plant_access ORDER BY entra_object_id, plant_id;

-- Debe devolver SOLO org-mx para el usuario local ficticio.
SELECT *
FROM gb_access.v_user_organizations
WHERE entra_tenant_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid
  AND entra_object_id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::uuid
ORDER BY organization_name;

-- Debe devolver Toluca y Puebla, NO Texas.
SELECT *
FROM gb_access.v_user_plants
WHERE entra_tenant_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid
  AND entra_object_id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::uuid
  AND organization_id = 'org-mx'
ORDER BY plant_name;

-- Información útil para saber en qué base estás parado.
SELECT current_database() AS database_name,
       current_user AS postgres_role;
