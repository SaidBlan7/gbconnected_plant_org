import {
  ApplicationConfig,
  inject,
  provideAppInitializer,
  provideZoneChangeDetection
} from '@angular/core';

import {
  provideRouter
} from '@angular/router';

import {
  provideHttpClient,
  withInterceptors
} from '@angular/common/http';

import {
  routes
} from './app.routes';

import {
  AuthService
} from './auth/auth.service';

import {
  authInterceptor
} from './auth/auth.interceptor';


export const appConfig: ApplicationConfig = {

  providers: [
    provideZoneChangeDetection(),

    provideRouter(
      routes
    ),

    provideHttpClient(
      withInterceptors([
        authInterceptor
      ])
    ),

    provideAppInitializer(
      () =>
        inject(AuthService)
          .initialize()
    )
  ]
};