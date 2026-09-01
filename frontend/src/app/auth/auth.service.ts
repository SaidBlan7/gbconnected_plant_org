import { Injectable } from '@angular/core';
import {
  AccountInfo,
  AuthenticationResult,
  InteractionRequiredAuthError,
  PublicClientApplication
} from '@azure/msal-browser';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly msal = new PublicClientApplication({
    auth: {
      clientId: environment.entra.clientId,
      authority: `https://login.microsoftonline.com/${environment.entra.tenantId}`,
      redirectUri: environment.entra.redirectUri
    },
    cache: {
      cacheLocation: 'sessionStorage'
    }
  });

  private initialized = false;

  async initialize(): Promise<void> {
    if (environment.authMode === 'mock' || this.initialized) {
      this.initialized = true;
      return;
    }

    await this.msal.initialize();
    const result = await this.msal.handleRedirectPromise();

    if (result?.account) {
      this.msal.setActiveAccount(result.account);
    } else if (!this.msal.getActiveAccount()) {
      const accounts = this.msal.getAllAccounts();
      if (accounts.length > 0) {
        this.msal.setActiveAccount(accounts[0]);
      }
    }

    this.initialized = true;

    if (!this.msal.getActiveAccount()) {
      await this.msal.loginRedirect({
        scopes: [environment.entra.apiScope]
      });
    }
  }

  async getAccessToken(): Promise<string> {
    if (environment.authMode === 'mock') {
      return '';
    }

    if (!this.initialized) {
      await this.initialize();
    }

    const account = this.activeAccount();
    if (!account) {
      await this.msal.loginRedirect({ scopes: [environment.entra.apiScope] });
      return '';
    }

    try {
      const result: AuthenticationResult = await this.msal.acquireTokenSilent({
        account,
        scopes: [environment.entra.apiScope]
      });
      return result.accessToken;
    } catch (error) {
      if (error instanceof InteractionRequiredAuthError) {
        await this.msal.acquireTokenRedirect({
          account,
          scopes: [environment.entra.apiScope]
        });
        return '';
      }
      throw error;
    }
  }

  activeAccount(): AccountInfo | null {
    return this.msal.getActiveAccount();
  }
}
