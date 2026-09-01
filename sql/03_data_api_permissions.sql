-- ====================================================================
-- PERMISOS PARA LAKEBASE DATA API
--
-- 1) Reemplaza __DATABRICKS_SP_CLIENT_ID__ por el Application/Client ID
--    del Service Principal de Azure Databricks que usará el backend.
-- 2) Ejecuta este archivo en el SQL Editor DEL MISMO proyecto Lakebase
--    cuya API URL vas a poner en LAKEBASE_DATA_API_URL.
-- ====================================================================

CREATE EXTENSION IF NOT EXISTS databricks_auth;

-- Crea el rol OAuth solo si todavía no existe.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = '__DATABRICKS_SP_CLIENT_ID__'
    ) THEN
        PERFORM databricks_create_role(
            '__DATABRICKS_SP_CLIENT_ID__',
            'SERVICE_PRINCIPAL'
        );
    END IF;
END
$$;

-- Data API autentica como 'authenticator' y asume la identidad solicitante.
GRANT "__DATABRICKS_SP_CLIENT_ID__" TO authenticator;

-- Principio de mínimo privilegio: el backend solo necesita consultar las vistas.
GRANT USAGE ON SCHEMA gb_access
TO "__DATABRICKS_SP_CLIENT_ID__";

GRANT SELECT ON
    gb_access.v_user_organizations,
    gb_access.v_user_plants
TO "__DATABRICKS_SP_CLIENT_ID__";

-- Si tu base no usa el nombre por defecto, adapta o elimina esta línea.
-- GRANT CONNECT ON DATABASE databricks_postgres
-- TO "__DATABRICKS_SP_CLIENT_ID__";
