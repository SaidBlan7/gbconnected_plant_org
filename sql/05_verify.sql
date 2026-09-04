
CREATE EXTENSION IF NOT EXISTS databricks_auth;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'cesar.vazquez@gbsupport.net'
    ) THEN
        PERFORM databricks_create_role(
            'cesar.vazquez@gbsupport.net',
            'USER'
        );
    END IF;
END
$$;

GRANT "cesar.vazquez@gbsupport.net"
TO authenticator;


GRANT CONNECT, CREATE, TEMPORARY
ON DATABASE db_gbc_ope_dev
TO "cesar.vazquez@gbsupport.net";

DO $$
DECLARE
    s RECORD;
BEGIN
    FOR s IN
        SELECT schema_name
        FROM information_schema.schemata
        WHERE schema_name <> 'information_schema'
          AND schema_name NOT LIKE 'pg_%'
          AND schema_name <> 'pgrst'
    LOOP
        EXECUTE format(
            'GRANT USAGE, CREATE ON SCHEMA %I TO %I',
            s.schema_name,
            'cesar.vazquez@gbsupport.net'
        );

        EXECUTE format(
            'GRANT SELECT, INSERT, UPDATE, DELETE
             ON ALL TABLES IN SCHEMA %I TO %I',
            s.schema_name,
            'cesar.vazquez@gbsupport.net'
        );

        EXECUTE format(
            'GRANT USAGE, SELECT, UPDATE
             ON ALL SEQUENCES IN SCHEMA %I TO %I',
            s.schema_name,
            'cesar.vazquez@gbsupport.net'
        );

        EXECUTE format(
            'GRANT EXECUTE
             ON ALL FUNCTIONS IN SCHEMA %I TO %I',
            s.schema_name,
            'cesar.vazquez@gbsupport.net'
        );

    END LOOP;
END
$$;


SELECT
    current_database() AS database_name,

    has_database_privilege(
        'cesar.vazquez@gbsupport.net',
        'db_gbc_ope_dev',
        'CONNECT'
    ) AS can_connect,

    has_database_privilege(
        'cesar.vazquez@gbsupport.net',
        'db_gbc_ope_dev',
        'CREATE'
    ) AS can_create_schema;

SELECT
    schema_name,
    has_schema_privilege(
        'cesar.vazquez@gbsupport.net',
        schema_name,
        'USAGE'
    ) AS can_use,
    has_schema_privilege(
        'cesar.vazquez@gbsupport.net',
        schema_name,
        'CREATE'
    ) AS can_create
FROM information_schema.schemata
WHERE schema_name <> 'information_schema'
  AND schema_name NOT LIKE 'pg_%'
ORDER BY schema_name;

SELECT
    has_table_privilege(
        'cesar.vazquez@gbsupport.net',
        'core.organization',
        'SELECT'
    ) AS organization_select,

    has_table_privilege(
        'cesar.vazquez@gbsupport.net',
        'core.organization',
        'INSERT'
    ) AS organization_insert,

    has_table_privilege(
        'cesar.vazquez@gbsupport.net',
        'core.organization',
        'UPDATE'
    ) AS organization_update,

    has_table_privilege(
        'cesar.vazquez@gbsupport.net',
        'core.organization',
        'DELETE'
    ) AS organization_delete;
