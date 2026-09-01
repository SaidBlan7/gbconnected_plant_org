import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Organization, Plant } from '../models/access.models';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class AccessApiService {
  private readonly baseUrl = environment.apiBaseUrl;

  constructor(private readonly http: HttpClient) {}

  getOrganizations(): Observable<Organization[]> {
    return this.http.get<Organization[]>(`${this.baseUrl}/me/organizations`);
  }

  getPlants(organizationId: string): Observable<Plant[]> {
    return this.http.get<Plant[]>(
      `${this.baseUrl}/me/organizations/${encodeURIComponent(organizationId)}/plants`
    );
  }
}
