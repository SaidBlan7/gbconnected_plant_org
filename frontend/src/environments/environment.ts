export const environment = {
  production: false,
  authMode: 'mock' as 'mock' | 'entra',
  apiBaseUrl: 'http://localhost:7071/api',
  entra: {
    tenantId: 'REEMPLAZAR_EN_PRODUCCION',
    clientId: 'REEMPLAZAR_EN_PRODUCCION',
    apiScope: 'api://REEMPLAZAR_BACKEND_CLIENT_ID/access_as_user',
    redirectUri: 'http://localhost:4200'
  }
};
