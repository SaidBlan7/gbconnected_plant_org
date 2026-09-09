package com.gbc.access.service;

import com.gbc.access.model.Organization;
import com.gbc.access.model.Plant;
import com.gbc.access.repository.LakebaseJdbcRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccessService {

    private final LakebaseJdbcRepository postgres;
    private final MockAccessData mock;

    public AccessService(LakebaseJdbcRepository postgres, MockAccessData mock) {
        this.postgres = postgres;
        this.mock = mock;
    }

    public List<Organization> getOrganizations(String tenantId, String objectId) {
        return useMock() ? mock.getOrganizations(tenantId, objectId)
                : postgres.getUserOrganizations(tenantId, objectId);
    }

    public List<Plant> getPlants(String tenantId, String objectId, String organizationId) {
        return useMock() ? mock.getPlants(tenantId, objectId, organizationId)
                : postgres.getUserPlants(tenantId, objectId, organizationId);
    }

    public void healthCheck() {
        if (!useMock()) postgres.healthCheck();
    }

    public String currentMode() { return useMock() ? "mock" : "postgres"; }

    private boolean useMock() {
        return "mock".equalsIgnoreCase(System.getenv().getOrDefault("ACCESS_MODE", "mock"));
    }
}
