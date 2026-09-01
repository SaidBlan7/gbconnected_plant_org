# Checklist de producción: Angular + Entra + Azure Functions + Lakebase

## 1. Microsoft Entra ID

Pide al administrador del tenant:

- App Registration para la SPA Angular.
- App Registration / recurso de API para el backend.
- Scope del backend, por ejemplo `access_as_user`.
- Permiso de la SPA para solicitar ese scope.
- Redirect URI de desarrollo y producción.
- Tenant ID, SPA Client ID y API scope.

El frontend productivo se configura en:

```text
frontend/src/environments/environment.production.ts
```

## 2. Azure Function App

Runtime recomendado para este proyecto:

```text
Azure Functions 4.x
Java 21
```

En Authentication configura Microsoft Entra ID y exige autenticación para las rutas de negocio. El token validado por Easy Auth se transforma en headers `X-MS-CLIENT-PRINCIPAL*`; el código extrae `tid` y `oid` desde ahí.

Configura las Application Settings:

```text
AUTH_MODE=entra
LAKEBASE_MODE=data-api
DATABRICKS_HOST=...
DATABRICKS_CLIENT_ID=...
DATABRICKS_CLIENT_SECRET=...
LAKEBASE_DATA_API_URL=...
LAKEBASE_SCHEMA=gb_access
```

No configures `DEV_TENANT_ID` ni `DEV_USER_OID` en producción.

## 3. Descubrir el OID/TID real del usuario

Una vez que Easy Auth funcione, inicia sesión y llama:

```text
GET https://TU-FUNCTION.azurewebsites.net/api/debug/whoami
```

Obtendrás algo similar a:

```json
{
  "tenantId": "...",
  "objectId": "...",
  "email": "...",
  "name": "..."
}
```

Con esos valores llena `sql/04_add_real_user.sql` y ejecuta la asignación en Lakebase.

## 4. Lakebase

En el proyecto productivo:

- Ejecuta `sql/01_schema.sql` o adapta el código a las tablas corporativas existentes.
- Activa Data API.
- Agrega `gb_access` a Exposed schemas.
- Crea el rol OAuth del Service Principal con `sql/03_data_api_permissions.sql`.
- Refresca schema cache.
- Copia la API URL a `LAKEBASE_DATA_API_URL`.

## 5. Frontend Angular

Completa `environment.production.ts` y ejecuta:

```powershell
npm install
npm run build:prod
```

Publica el contenido generado en el servicio Azure elegido para el frontend.

## 6. Pruebas mínimas productivas

1. Usuario con 2 plantas en México: ve México y esas 2 plantas.
2. Usuario sin asignación en USA: no ve USA.
3. URL manual `/organizations/org-us/plants`: backend devuelve `[]`.
4. Usuario sin asignaciones: organizaciones `[]`.
5. `health/lakebase`: `UP` cuando Data API funciona.
6. Cambia una asignación en Lakebase; al refrescar, Angular refleja el cambio.
