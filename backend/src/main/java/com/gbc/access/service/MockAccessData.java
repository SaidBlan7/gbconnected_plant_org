package com.gbc.access.service;

import com.gbc.access.model.Organization;
import com.gbc.access.model.Plant;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MockAccessData {

    private static final String DEMO_TENANT = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa";
    private static final String DEMO_USER = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb";

    public List<Organization> getOrganizations(String tenantId, String objectId) {
        if (!DEMO_TENANT.equalsIgnoreCase(tenantId) || !DEMO_USER.equalsIgnoreCase(objectId)) {
            return List.of();
        }

        // Los IDs simulados imitan los BIGINT reales de core.organization.
        return List.of(
                new Organization("1", "MX", "Organización México")
        );
    }

    public List<Plant> getPlants(String tenantId, String objectId, String organizationId) {
        if (!DEMO_TENANT.equalsIgnoreCase(tenantId) || !DEMO_USER.equalsIgnoreCase(objectId)) {
            return List.of();
        }

        // Compatibilidad temporal con el ID mock anterior "org-mx".
        if (!("1".equals(organizationId) || "org-mx".equalsIgnoreCase(organizationId))) {
            return List.of();
        }

        // Coinciden con MockCoreData: plant_id 1 = TOL, plant_id 2 = PUE.
        return List.of(
                new Plant("1", "TOL", "Planta Toluca"),
                new Plant("2", "PUE", "Planta Puebla")
        );
    }
}
