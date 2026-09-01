import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AccessApiService } from '../../services/access-api.service';
import { Organization } from '../../models/access.models';

@Component({
  standalone: true,
  selector: 'app-organizations',
  imports: [CommonModule],
  templateUrl: './organizations.component.html',
  styleUrl: './organizations.component.scss'
})
export class OrganizationsComponent implements OnInit {
  organizations: Organization[] = [];
  loading = true;
  error = '';

  constructor(
    private readonly api: AccessApiService,
    private readonly router: Router
  ) {}

  ngOnInit(): void {
    this.api.getOrganizations().subscribe({
      next: data => {
        this.organizations = data;
        this.loading = false;
      },
      error: error => {
        console.error(error);
        this.error = 'No fue posible cargar las organizaciones.';
        this.loading = false;
      }
    });
  }

  openOrganization(organization: Organization): void {
    void this.router.navigate([
      '/organizations',
      organization.id,
      'plants'
    ], {
      state: { organizationName: organization.name }
    });
  }
}
