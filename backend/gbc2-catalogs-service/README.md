# GB Connected 2.0 - Catalogs Microservice

Migración del bloque de catálogos de `backend(2)` a la plantilla oficial de microservicios GB Connected 2.0.

## Arquitectura

Se conserva la estructura de la plantilla: `domain`, `application`, `adapter-memory`, `adapter-postgres`, `bootstrap`, `runtime-app-service` y `runtime-functions`. Los comandos pasan por dominio y repositorio; los GET usan puertos de lectura con proyecciones JDBC.

## Responsabilidad

Este microservicio contiene el catálogo actualmente migrado del backend original:

- Organizaciones de `core.organization` (lectura).
- Plantas de `core.plant` (CRUD).

Se corrigió el contrato viejo para coincidir con el DDL recibido. En particular, `core.plant` usa `erp_plant_code`, `country_code`, `region_code`, `address`, `timezone_name`, `language_code`, `is_active`, `created_at` y `updated_at`. No se usan columnas inexistentes del backend anterior (`plant_latitude`, `plant_longitude`, `plant_state`, `plant_municipality`, `source_system`, `created_by`, `updated_by`).

## API App Service

- `GET /api/v1/organizations?active=true`
- `GET /api/v1/organizations/{id}`
- `GET /api/v1/plants?organizationId=1&active=true`
- `GET /api/v1/plants/{id}`
- `POST /api/v1/plants`
- `PUT /api/v1/plants/{id}`
- `PATCH /api/v1/plants/{id}`
- `DELETE /api/v1/plants/{id}`
- `GET /api/v1/health/database`
- `GET /actuator/health`

Ejemplo de body:

```json
{
  "organizationId": 1,
  "plantCode": "TOL",
  "plantName": "Planta Toluca",
  "erpPlantCode": "ERP-TOL",
  "countryCode": "MX",
  "regionCode": "CENTRO",
  "address": "Dirección opcional",
  "timezoneName": "America/Mexico_City",
  "languageCode": "es-MX",
  "active": true
}
```

## Compatibilidad con `backend(2)`

Además de las rutas canónicas `/api/v1`, se mantienen temporalmente los alias antiguos `/api/organizations`, `/api/plants`, `/api/plants/{id}` y `/api/health/lakebase` en ambos runtimes.

## Persistencia

Modos idénticos a la plantilla:

- `GBC_PERSISTENCE_MODE=memory`
- `GBC_PERSISTENCE_MODE=postgres-password`
- `GBC_PERSISTENCE_MODE=lakebase-oauth`

PostgreSQL local:

```bash
docker compose up -d
export GBC_PERSISTENCE_MODE=postgres-password
export JDBC_URL=jdbc:postgresql://localhost:5432/gbc2
export DB_USER=gbc2
export DB_PASSWORD=gbc2_local_only
mvn -pl runtime-app-service -am spring-boot:run
```

Lakebase OAuth usa las mismas variables de la plantilla: `DATABRICKS_HOST`, `DATABRICKS_CLIENT_ID`, `DATABRICKS_CLIENT_SECRET`, `ENDPOINT_NAME`, `PGHOST`, `PGDATABASE`, `PGUSER`, `PGPORT` y pool DB.

## Seguridad

Con `GBC_SECURITY_ENABLED=false` se permite ejecución local. Con `true`, los GET de API requieren JWT Entra y las mutaciones de plantas requieren el App Role `GB.Admin`. Health queda público.

## Azure Functions

```bash
mvn -pl runtime-functions -am clean package
cp runtime-functions/local.settings.example.json runtime-functions/local.settings.json
mvn -pl runtime-functions azure-functions:run
```

Las Functions siguen el patrón de la plantilla: Java 21, Functions v4, sin arrancar Spring Boot, y `AuthorizationLevel.FUNCTION` para endpoints de negocio.

## Build

```bash
mvn clean verify
mvn -pl runtime-app-service -am clean package
mvn -pl runtime-functions -am clean package
```
