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
        return List.of(
                new Organization("org-mx", "MX", "Organización México")
        );
    }

    public List<Plant> getPlants(String tenantId, String objectId, String organizationId) {
        if (!DEMO_TENANT.equalsIgnoreCase(tenantId) || !DEMO_USER.equalsIgnoreCase(objectId)) {
            return List.of();
        }
        if (!"org-mx".equalsIgnoreCase(organizationId)) {
            return List.of();
        }
        return List.of(
                new Plant("plant-tol", "TOL", "Planta Toluca"),
                new Plant("plant-pue", "PUE", "Planta Puebla")
        );
    }
}
