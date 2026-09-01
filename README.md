# GB Connected Access Lab

Proyecto listo para probar el flujo:

```text
Angular (2 pantallas)
    -> Azure Functions Java + Spring Boot
    -> Azure Databricks OAuth
    -> Lakebase Data API
    -> Lakebase PostgreSQL
```

El usuario se identifica por `tenantId + objectId` de Microsoft Entra ID. No hay roles en este laboratorio: si tiene plantas asignadas, ve sus organizaciones y sus plantas; si no tiene asignaciones, obtiene listas vacías.

## Qué trae el ZIP

- `backend/`: Java 21 + Spring Boot + Azure Functions SDK.
- `frontend/`: Angular con dos pantallas.
- `sql/`: esquema, datos demo, permisos Data API y consultas de validación.
- `docs/CONFIGURACION_LAKEBASE.md`: explica exactamente a qué Lakebase se conecta y qué cambiar.
- `docs/PRODUCCION_ENTRA_AZURE.md`: preparación para Entra ID y producción.
- `scripts/`: comandos PowerShell de apoyo.

---

# 1. Prueba inmediata SIN Lakebase real

Esta prueba valida primero Angular + Functions + Spring Boot.

## Requisitos

- JDK 21
- Maven 3.6.3+
- Azure Functions Core Tools 4
- Node.js compatible con Angular 21 (Node 20.19+, 22.12+ o 24+)
- npm

## Backend

En PowerShell:

```powershell
cd backend
Copy-Item .\src\main\resources\local.settings.example.json .\src\main\resources\local.settings.json
mvn clean package
mvn azure-functions:run
```

`local.settings.example.json` viene con:

```text
AUTH_MODE=mock
LAKEBASE_MODE=mock
```

Por eso no pide Entra ni Databricks todavía.

Prueba:

```text
http://localhost:7071/api/debug/whoami
http://localhost:7071/api/health/lakebase
http://localhost:7071/api/me/organizations
http://localhost:7071/api/me/organizations/org-mx/plants
```

Resultados esperados:

- Organizaciones: solo `Organización México`.
- Plantas de `org-mx`: `Planta Toluca` y `Planta Puebla`.
- Plantas de `org-us`: `[]`.

## Frontend

En otra terminal:

```powershell
cd frontend
npm install
npm start
```

Abre:

```text
http://localhost:4200
```

Pantalla 1 lista organizaciones; al seleccionar México, pantalla 2 lista Toluca y Puebla.

---

# 2. Prueba local CONTRA TU LAKEBASE REAL

En esta modalidad solamente se simula el usuario de Entra. El backend, OAuth de Databricks, Data API y Lakebase son reales.

## Paso A - prepara el Lakebase

En el SQL Editor del proyecto Lakebase que quieras usar ejecuta, en orden:

```text
sql/01_schema.sql
sql/02_seed_local.sql
sql/03_data_api_permissions.sql
sql/05_verify.sql
```

Antes de ejecutar `03_data_api_permissions.sql`, sustituye:

```text
__DATABRICKS_SP_CLIENT_ID__
```

por el Client/Application ID del Service Principal de Databricks usado por el backend.

## Paso B - habilita Data API

En el proyecto Lakebase:

```text
Lakebase -> Project -> Data API -> Enable Data API
```

Después, en la configuración avanzada de Data API, agrega el schema:

```text
gb_access
```

y pulsa `Refresh schema cache`.

Copia el valor `API URL` de esa misma pantalla.

IMPORTANTE: copia la URL base tal como aparece. El backend agrega automáticamente `/gb_access/...`.

## Paso C - configura el backend

```powershell
cd backend
Copy-Item .\src\main\resources\local.settings.lakebase.example.json .\src\main\resources\local.settings.json
```

Edita `src/main/resources/local.settings.json` y llena:

```text
DATABRICKS_HOST
DATABRICKS_CLIENT_ID
DATABRICKS_CLIENT_SECRET
LAKEBASE_DATA_API_URL
```

Debe quedar:

```text
AUTH_MODE=mock
LAKEBASE_MODE=data-api
```

Luego:

```powershell
mvn clean package
mvn azure-functions:run
```

Primero prueba:

```text
http://localhost:7071/api/health/lakebase
```

Debe indicar:

```json
{
  "status": "UP",
  "backend": "UP",
  "lakebase": "UP",
  "lakebaseMode": "data-api"
}
```

Después:

```text
http://localhost:7071/api/me/organizations
http://localhost:7071/api/me/organizations/org-mx/plants
```

Con el seed incluido debes ver México, Toluca y Puebla.

---

# 3. Endpoints incluidos

```text
GET /api/debug/whoami
GET /api/health/lakebase
GET /api/me/organizations
GET /api/me/organizations/{organizationId}/plants
```

`/api/debug/whoami` es especialmente útil en producción para conocer el `tid` y `oid` reales que Entra entregó al backend.

---

# 4. Producción

En producción las dos diferencias principales son:

```text
AUTH_MODE=entra
LAKEBASE_MODE=data-api
```

Azure Functions debe tener Microsoft Entra ID / App Service Authentication (Easy Auth) configurado para exigir autenticación. Angular usa MSAL Browser para iniciar sesión y adjuntar el access token a las llamadas al backend.

Configura las variables del backend como Function App Application Settings; NO subas secretos al repositorio.

Configura el frontend en:

```text
frontend/src/environments/environment.production.ts
```

con:

```text
apiBaseUrl
entra.tenantId
entra.clientId
entra.apiScope
entra.redirectUri
```

Después:

```powershell
cd frontend
npm install
npm run build:prod
```

Consulta `docs/PRODUCCION_ENTRA_AZURE.md` para el checklist.

---

# 5. ¿Dónde se conecta exactamente a Lakebase?

La conexión NO usa `PGHOST`, `PGPORT` ni JDBC en este proyecto. Usa Lakebase Data API por HTTPS.

El punto exacto está en:

```text
backend/src/main/java/com/gbc/access/service/LakebaseDataApiClient.java
```

Ese archivo construye llamadas así:

```text
{LAKEBASE_DATA_API_URL}/{LAKEBASE_SCHEMA}/v_user_organizations?...filtros...
```

o:

```text
{LAKEBASE_DATA_API_URL}/{LAKEBASE_SCHEMA}/v_user_plants?...filtros...
```

La variable más importante para cambiar de Lakebase es:

```text
LAKEBASE_DATA_API_URL
```

Localmente está en:

```text
backend/src/main/resources/local.settings.json
```

En Azure estará en:

```text
Function App -> Settings/Configuration -> Application settings
```

Lee `docs/CONFIGURACION_LAKEBASE.md` antes de cambiar de ambiente.

---

# 6. Identidades: no confundirlas

```text
Microsoft Entra ID
  -> identifica al USUARIO humano
  -> tid + oid

Databricks Service Principal
  -> identifica al BACKEND ante Databricks/Lakebase Data API
  -> DATABRICKS_CLIENT_ID + secret

Lakebase
  -> relaciona tid + oid con plantas
```

El token de Entra del usuario no se reenvía directamente a Lakebase. El backend consulta Lakebase con su identidad de servicio Databricks y filtra por el `tid + oid` del usuario autenticado.
