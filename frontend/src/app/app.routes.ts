import { Routes } from '@angular/router';
import { OrganizationsComponent } from './pages/organizations/organizations.component';
import { PlantsComponent } from './pages/plants/plants.component';

export const routes: Routes = [
  { path: '', redirectTo: 'organizations', pathMatch: 'full' },
  { path: 'organizations', component: OrganizationsComponent },
  { path: 'organizations/:organizationId/plants', component: PlantsComponent },
  { path: '**', redirectTo: 'organizations' }
];
