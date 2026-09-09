package com.gbc.access.service;

import com.gbc.access.model.*;
import com.gbc.access.repository.LakebaseJdbcRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PlantCrudService {
    private final LakebaseJdbcRepository postgres;
    private final MockCoreData mock;

    public PlantCrudService(LakebaseJdbcRepository postgres, MockCoreData mock) {
        this.postgres = postgres;
        this.mock = mock;
    }

    public boolean isMock() {
        return "mock".equalsIgnoreCase(System.getenv().getOrDefault("PLANT_CRUD_MODE", "mock"));
    }

    public String currentMode() { return isMock() ? "mock" : "postgres"; }

    public List<CoreOrganization> organizations(Boolean active) {
        return isMock() ? mock.organizations(active) : postgres.listOrganizations(active);
    }

    public Optional<CoreOrganization> organization(long id) {
        return isMock() ? mock.organization(id) : postgres.getOrganization(id);
    }

    public List<PlantDetails> list(Long orgId, Boolean active) {
        return isMock() ? mock.plants(orgId, active) : postgres.listPlants(orgId, active);
    }

    public Optional<PlantDetails> get(long id) {
        return isMock() ? mock.plant(id) : postgres.getPlant(id);
    }

    public PlantDetails create(PlantCreateRequest r, String audit) {
        validate(r);
        return isMock() ? mock.create(r, audit) : postgres.createPlant(r, audit);
    }

    public Optional<PlantDetails> patch(long id, PlantUpdateRequest r, String audit) {
        return isMock() ? mock.patch(id, r, audit) : postgres.patchPlant(id, r, audit);
    }

    public Optional<PlantDetails> replace(long id, PlantCreateRequest r, String audit) {
        validate(r);
        return isMock() ? mock.replace(id, r, audit) : postgres.replacePlant(id, r, audit);
    }

    public boolean delete(long id) {
        return isMock() ? mock.delete(id) : postgres.deletePlant(id);
    }

    public void health() {
        if (!isMock()) postgres.healthCheck();
    }

    private void validate(PlantCreateRequest r) {
        if (r == null || r.organizationId() == null || blank(r.plantCode()) || blank(r.plantName()) || blank(r.country())) {
            throw new IllegalArgumentException("organizationId, plantCode, plantName and country are required");
        }
    }

    private boolean blank(String v) { return v == null || v.isBlank(); }
}
