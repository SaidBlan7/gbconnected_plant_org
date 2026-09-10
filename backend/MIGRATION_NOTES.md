# Migración backend(2) -> microservicios GB Connected 2.0

## Resultado

Se migró la funcionalidad existente de `backend(2)` a dos repositorios independientes basados en `gb-gbc2-microservice-template`:

- `gbc2-catalogs-service`: lectura de organizaciones y CRUD de plantas.
- `gbc2-users-service`: identidad del usuario, organizaciones permitidas, plantas permitidas y `whoami`.

Ambos mantienen los módulos de la plantilla:

`domain` -> `application` -> `adapter-memory` / `adapter-postgres` -> `bootstrap` -> `runtime-app-service` / `runtime-functions`.

## Separación de responsabilidades

### Catálogos

Es dueño de las operaciones de catálogo actualmente presentes en el backend original:

- `core.organization` (lectura).
- `core.plant` (lectura y CRUD).

El contrato de planta fue alineado al DDL entregado. Se usan únicamente las columnas reales:

`plant_id`, `organization_id`, `plant_code`, `plant_name`, `erp_plant_code`, `country_code`, `region_code`, `address`, `timezone_name`, `language_code`, `is_active`, `created_at`, `updated_at`.

Se eliminaron del contrato migrado las columnas que el backend anterior intentaba usar pero que no existen en el DDL: `country`, `plant_address`, `plant_timezone`, `plant_latitude`, `plant_longitude`, `plant_state`, `plant_municipality`, `source_system`, `created_by`, `updated_by`.

### Usuarios

Es dueño de la consulta de acceso del usuario, no del catálogo maestro. La autorización de datos se obtiene desde:

`app_security.user_plant_access` -> `core.plant` -> `core.organization`.

Esto reemplaza la dependencia del backend anterior sobre `app_api.v_user_organizations` y `app_api.v_user_plants`, ya que esas vistas no están definidas en el DDL proporcionado.

## Endpoints migrados

### Catálogos - canónicos

- `GET /api/v1/organizations`
- `GET /api/v1/organizations/{id}`
- `GET /api/v1/plants`
- `GET /api/v1/plants/{id}`
- `POST /api/v1/plants`
- `PUT /api/v1/plants/{id}`
- `PATCH /api/v1/plants/{id}`
- `DELETE /api/v1/plants/{id}`
- `GET /api/v1/health/database`

### Usuarios - canónicos

- `GET /api/v1/me/organizations`
- `GET /api/v1/me/organizations/{organizationId}/plants`
- `GET /api/v1/debug/whoami`
- `GET /api/v1/health/database`

### Compatibilidad temporal

Se conservaron aliases de las rutas del backend anterior bajo `/api/...`, incluyendo `/api/health/lakebase`, para facilitar la transición del frontend.

## Persistencia

Se conservaron los tres modos de la plantilla:

- `memory`
- `postgres-password`
- `lakebase-oauth`

La implementación productiva usa JDBC/Hikari y el mecanismo OAuth de Lakebase de la plantilla, en lugar del cliente HTTP/Data API del backend anterior.

## Seguridad

### App Service

- Desarrollo: `GBC_SECURITY_ENABLED=false`.
- Producción: JWT Entra con resource server.
- Catálogos: las mutaciones de plantas requieren `APPROLE_GB.Admin` cuando la seguridad está habilitada.
- Usuarios: los endpoints de usuario requieren autenticación cuando la seguridad está habilitada.

### Azure Functions

Se mantiene el patrón de la plantilla:

- Java 21.
- Functions v4.
- Runtime sin arrancar Spring Boot.
- `AuthorizationLevel.FUNCTION` en endpoints de negocio.
- Health anónimo.
- Usuarios obtiene identidad desde `X-MS-CLIENT-PRINCIPAL` en modo Entra/Easy Auth y admite `AUTH_MODE=mock` local.

## Validación realizada

- POMs XML válidos.
- JSON válidos.
- Balance estructural de fuentes Java revisado.
- Sin residuos del ejemplo `QualityRule` / `gbc2-quality` de la plantilla.
- Compilación con `javac --release 21` de `domain`, `application`, `adapter-memory` y adaptadores JDBC que sólo dependen del JDK.
- Smoke test de Catálogos: crear -> consultar -> modificar -> eliminar planta: OK.
- Smoke test de Usuarios: resolver organización y dos plantas para identidad demo: OK.

No fue posible ejecutar el ciclo Maven completo dentro del entorno de generación porque no existe el ejecutable `mvn` instalado y el entorno no permite descargarlo. Por ello, antes de desplegar debe ejecutarse en un equipo/agente con Maven 3.9+:

```bash
mvn clean verify
mvn -pl runtime-app-service -am clean package
mvn -pl runtime-functions -am clean package
```

## Base de datos local

Cada repositorio incluye `compose.yaml` y scripts SQL mínimos para probar su contexto. En el repositorio Usuarios, las tablas `core` incluidas en el compose son sólo dependencias de prueba local; su ownership sigue siendo Catálogos en un ambiente compartido.

## Alcance

La base entregada contiene más tablas (`dough`, líneas, máquinas, turnos, packaging, scheduling y waste), pero `backend(2)` no implementaba APIs para ellas. Esta migración traslada por completo la funcionalidad existente del backend entregado sin inventar nuevos casos de uso. Esos catálogos adicionales pueden agregarse posteriormente al microservicio Catálogos siguiendo el mismo patrón ya implementado.
