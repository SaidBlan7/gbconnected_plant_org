# GB Connected 2.0 - Users Microservice

Migración del bloque de acceso por usuario de `backend(2)` a la plantilla oficial de microservicios GB Connected 2.0.

## Arquitectura

Mantiene exactamente los módulos de la plantilla: `domain`, `application`, `adapter-memory`, `adapter-postgres`, `bootstrap`, `runtime-app-service` y `runtime-functions`.

## Responsabilidad

- Resolver la identidad Entra (`tid` + `oid`).
- Listar organizaciones a las que el usuario tiene acceso.
- Listar plantas accesibles dentro de una organización.
- Endpoint de diagnóstico `whoami`.

La autorización de datos se resuelve directamente con `app_security.user_plant_access`, enlazando `plant_id` con `core.plant` y `core.organization`. No se depende de las vistas `app_api.v_user_organizations`/`v_user_plants` del backend anterior porque no aparecen definidas en el DDL entregado.

## API App Service

- `GET /api/v1/me/organizations`
- `GET /api/v1/me/organizations/{organizationId}/plants`
- `GET /api/v1/debug/whoami`
- `GET /api/v1/health/database`
- `GET /actuator/health`

## Compatibilidad con `backend(2)`

Además de las rutas canónicas `/api/v1`, se mantienen temporalmente los alias antiguos `/api/me/organizations`, `/api/me/organizations/{organizationId}/plants`, `/api/debug/whoami` y `/api/health/lakebase` en ambos runtimes.

## Identidad

Local:

```text
GBC_SECURITY_ENABLED=false
AUTH_MODE=mock
DEV_TENANT_ID=aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa
DEV_USER_OID=bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb
DEV_USER_EMAIL=local@demo.com
```

App Service productivo:

```text
GBC_SECURITY_ENABLED=true
SPRING_SECURITY_OAUTH2_RESOURCESERVER_JWT_ISSUER_URI=https://login.microsoftonline.com/<tenant-id>/v2.0
```

Azure Functions conserva soporte para `X-MS-CLIENT-PRINCIPAL` (Easy Auth) y `AUTH_MODE=mock` local. Los endpoints de negocio usan `AuthorizationLevel.FUNCTION`, como la plantilla.

## Persistencia

- `memory` para ejecución sin BD.
- `postgres-password` para PostgreSQL local.
- `lakebase-oauth` para Lakebase con OAuth M2M y HikariCP.

El `compose.yaml` incluye tablas `core` mínimas solo como dependencia local de pruebas; el microservicio Usuarios no es dueño de esas tablas en ambientes compartidos.

## Build

```bash
mvn clean verify
mvn -pl runtime-app-service -am clean package
mvn -pl runtime-functions -am clean package
```
