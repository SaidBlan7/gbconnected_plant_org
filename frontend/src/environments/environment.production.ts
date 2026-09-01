export const environment = {
  production: true,
  authMode: 'entra' as 'mock' | 'entra',

  // URL PUBLICA de tu Azure Function App, SIN slash final.
  // Ejemplo: https://gbc-access-api.azurewebsites.net/api
  apiBaseUrl: 'https://REEMPLAZAR-FUNCTION-APP.azurewebsites.net/api',

  entra: {
    // Datos entregados por el administrador de Microsoft Entra ID.
    tenantId: 'REEMPLAZAR_TENANT_ID',
    clientId: 'REEMPLAZAR_SPA_CLIENT_ID',
    apiScope: 'api://REEMPLAZAR_BACKEND_CLIENT_ID/access_as_user',

    // URL donde publiques Angular.
    redirectUri: 'https://REEMPLAZAR-FRONTEND-URL'
  }
};
