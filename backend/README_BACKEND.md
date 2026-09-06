# GBC Access Backend

## Modos independientes

- `ACCESS_MODE=mock|data-api`: API existente `/api/me/...`. En modo real consulta `app_api.v_user_organizations` y `app_api.v_user_plants`.
- `PLANT_CRUD_MODE=mock|data-api`: CRUD nuevo de plantas. En modo real trabaja **directamente** sobre `core.plant` y lee `core.organization`.

Esto permite el modo híbrido actual: API de acceso simulada + CRUD real sobre `core`.

## Endpoints existentes

- `GET /api/me/organizations`
- `GET /api/me/organizations/{organizationId}/plants`
- `GET /api/debug/whoami`
- `GET /api/health/lakebase`

## Endpoints nuevos sobre core

- `GET /api/organizations?active=true`
- `GET /api/plants`
- `GET /api/plants?organizationId=1&active=true`
- `GET /api/plants/{plantId}`
- `POST /api/plants`
- `PATCH /api/plants/{plantId}`
- `PUT /api/plants/{plantId}`
- `DELETE /api/plants/{plantId}`

### POST/PUT de ejemplo

```json
{
  "organizationId": 1,
  "plantCode": "TOL",
  "plantName": "Planta Toluca",
  "country": "México",
  "plantAddress": "Dirección opcional",
  "plantTimezone": "America/Mexico_City",
  "plantLatitude": 19.2826,
  "plantLongitude": -99.6557,
  "plantState": "Estado de México",
  "plantMunicipality": "Toluca",
  "active": true,
  "sourceSystem": "GBC_CONFIGURADOR"
}
```

`PATCH` acepta los mismos campos, todos opcionales, y solo modifica los que se envían con valor no nulo.

## Desarrollo local con tu token Databricks

No guardes el token en Git. Puedes conservar `DATABRICKS_OAUTH_TOKEN` vacío y usar las variables que ya utilizaste con curl:

```powershell
$env:DBX_OAUTH_TOKEN = (databricks auth token gbc-dev | ConvertFrom-Json).access_token
$env:REST_ENDPOINT = "TU_API_URL_DE_LAKEBASE"
```

Para tu situación actual usa `local.settings.hybrid.example.json` como base y deja:

```text
AUTH_MODE=mock
ACCESS_MODE=mock
PLANT_CRUD_MODE=data-api
LAKEBASE_CORE_SCHEMA=core
LAKEBASE_ACCESS_SCHEMA=app_api
```

Después:

```powershell
.\mvnw.cmd clean test
.\mvnw.cmd azure-functions:run
```

El backend busca primero `DATABRICKS_OAUTH_TOKEN`; si está vacío, también acepta `DBX_OAUTH_TOKEN`. Para la URL busca `LAKEBASE_DATA_API_URL`; si está vacía, acepta `REST_ENDPOINT`.

## Cuando habiliten la API de acceso real

No se cambia código. Solo se cambia `ACCESS_MODE=data-api` y se requiere que `app_api` esté expuesto y que la identidad usada por Data API tenga `SELECT` sobre las vistas. El CRUD de plantas sigue usando exclusivamente `core`.

## Producción

Si no existe un token manual, `DatabricksTokenProvider` usa OAuth M2M con `DATABRICKS_HOST`, `DATABRICKS_CLIENT_ID` y `DATABRICKS_CLIENT_SECRET`. No se deben desplegar tokens de usuario de una hora.
