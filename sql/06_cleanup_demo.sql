-- OPCIONAL. Elimina solamente los datos demo del usuario ficticio.
DELETE FROM gb_access.user_plant_access
WHERE entra_tenant_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid
  AND entra_object_id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::uuid;
