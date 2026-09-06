package com.gbc.access.service;

import com.gbc.access.model.Organization;
import com.gbc.access.model.Plant;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccessService {

    private final LakebaseDataApiClient lakebase;
    private final MockAccessData mock;

    public AccessService(LakebaseDataApiClient lakebase, MockAccessData mock) {
        this.lakebase = lakebase;
        this.mock = mock;
    }

    public List<Organization> getOrganizations(String tenantId, String objectId) {
        if (useMockLakebase()) {
            return mock.getOrganizations(tenantId, objectId);
        }
        return lakebase.getOrganizations(tenantId, objectId);
    }

    public List<Plant> getPlants(String tenantId, String objectId, String organizationId) {
        if (useMockLakebase()) {
            return mock.getPlants(tenantId, objectId, organizationId);
        }
        return lakebase.getPlants(tenantId, objectId, organizationId);
    }

    public void healthCheck() {
        if (!useMockLakebase()) {
            lakebase.healthCheckCore();
        }
    }

    public String currentMode() {
        return useMockLakebase() ? "mock" : "data-api";
    }

    private boolean useMockLakebase() {
        return "mock".equalsIgnoreCase(System.getenv().getOrDefault("ACCESS_MODE", System.getenv().getOrDefault("LAKEBASE_MODE", "mock")));
    }
}
