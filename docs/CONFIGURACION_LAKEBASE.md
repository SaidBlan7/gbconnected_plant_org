# Configuración de Lakebase: qué identifica cada dato

Esta es la parte que debes revisar cuando cambies el Lakebase del laboratorio por el Lakebase de otro ambiente.

## Flujo real

```text
Azure Function Java
      |
      | 1) pide token OAuth
      v
DATABRICKS_HOST /oidc/v1/token
      |
      | token del Service Principal
      v
LAKEBASE_DATA_API_URL
      |
      | /gb_access/v_user_organizations
      | /gb_access/v_user_plants
      v
Lakebase PostgreSQL
```

## Variables

### `LAKEBASE_DATA_API_URL`

Esta es la variable que apunta a la Data API del proyecto Lakebase.

La obtienes en Databricks:

```text
Lakebase
-> abre el proyecto correcto
-> Data API
-> pestaña API
-> API URL
```

Copia la URL BASE que muestra Databricks. No agregues `/gb_access`, porque el código lo agrega.

El código que usa esta variable está en:

```text
backend/src/main/java/com/gbc/access/service/LakebaseDataApiClient.java
```

### `LAKEBASE_SCHEMA`

En este proyecto es:

```text
gb_access
```

El schema debe estar incluido en `Data API -> Settings -> Exposed schemas`.

### `DATABRICKS_HOST`

NO es la URL de Lakebase.

Es la URL del Azure Databricks workspace que emite el token OAuth al Service Principal, por ejemplo:

```text
https://adb-xxxxxxxxxxxxxxxx.x.azuredatabricks.net
```

La usa:

```text
backend/src/main/java/com/gbc/access/service/DatabricksTokenProvider.java
```

para llamar:

```text
{DATABRICKS_HOST}/oidc/v1/token
```

### `DATABRICKS_CLIENT_ID` y `DATABRICKS_CLIENT_SECRET`

Son la identidad máquina-a-máquina del backend ante Azure Databricks. No son las credenciales del usuario humano.

El mismo Client ID debe aparecer en `sql/03_data_api_permissions.sql` para crear el rol OAuth PostgreSQL y otorgarle SELECT sobre las vistas.

## Si cambias a OTRO Lakebase en el MISMO workspace

Haz esto:

1. En el nuevo Lakebase ejecuta `sql/01_schema.sql`.
2. Carga los datos reales o `02_seed_local.sql` si sigue siendo laboratorio.
3. Activa Data API.
4. Expón `gb_access`.
5. Ejecuta `03_data_api_permissions.sql` con el Client ID del backend.
6. Refresca el schema cache.
7. Cambia solamente `LAKEBASE_DATA_API_URL` si el Service Principal y workspace siguen siendo los mismos.

## Si cambias a OTRO Lakebase en OTRO workspace

Además de lo anterior:

1. Cambia `DATABRICKS_HOST`.
2. Verifica que el Service Principal tenga acceso al nuevo workspace.
3. Si usarás otro Service Principal, cambia `DATABRICKS_CLIENT_ID` y `DATABRICKS_CLIENT_SECRET`.
4. Ejecuta `03_data_api_permissions.sql` usando ese nuevo Client ID.
5. Cambia `LAKEBASE_DATA_API_URL` por la API URL del nuevo proyecto.

## ¿Dónde cambio esto localmente?

```text
backend/src/main/resources/local.settings.json
```

## ¿Dónde cambio esto en producción?

En Azure Portal:

```text
Function App
-> Settings / Configuration
-> Application settings
```

Crea o modifica:

```text
AUTH_MODE=entra
LAKEBASE_MODE=data-api
DATABRICKS_HOST=...
DATABRICKS_CLIENT_ID=...
DATABRICKS_CLIENT_SECRET=...
LAKEBASE_DATA_API_URL=...
LAKEBASE_SCHEMA=gb_access
```

Para producción es preferible guardar el secreto en Key Vault o evolucionar a identidad federada/Managed Identity.

## Cómo comprobar que estás hablando con el Lakebase correcto

Ejecuta en el SQL Editor del Lakebase:

```sql
SELECT current_database(), current_user;
SELECT * FROM gb_access.v_user_organizations;
```

Luego llama:

```text
GET /api/health/lakebase
```

y después:

```text
GET /api/me/organizations
```

Si modificas una asignación en `gb_access.user_plant_access` y al refrescar la API cambia la respuesta, comprobaste el camino completo hasta ese Lakebase.
