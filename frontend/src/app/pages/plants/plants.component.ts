import { Component, OnInit } from '@angular/core';
import { CommonModule, Location } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { AccessApiService } from '../../services/access-api.service';
import { Plant } from '../../models/access.models';

@Component({
  standalone: true,
  selector: 'app-plants',
  imports: [CommonModule],
  templateUrl: './plants.component.html',
  styleUrl: './plants.component.scss'
})
export class PlantsComponent implements OnInit {
  plants: Plant[] = [];
  loading = true;
  error = '';
  organizationId = '';
  organizationName = '';

  constructor(
    private readonly route: ActivatedRoute,
    private readonly api: AccessApiService,
    private readonly location: Location
  ) {
    const navigationState = history.state as { organizationName?: string };
    this.organizationName = navigationState.organizationName ?? '';
  }

  ngOnInit(): void {
    this.organizationId = this.route.snapshot.paramMap.get('organizationId') ?? '';

    if (!this.organizationId) {
      this.error = 'Organización inválida.';
      this.loading = false;
      return;
    }

    this.api.getPlants(this.organizationId).subscribe({
      next: data => {
        this.plants = data;
        this.loading = false;
      },
      error: error => {
        console.error(error);
        this.error = 'No fue posible cargar las plantas.';
        this.loading = false;
      }
    });
  }

  goBack(): void {
    this.location.back();
  }
}
