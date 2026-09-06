package com.gbc.access.service;

import com.gbc.access.model.*;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class PlantCrudService {
    private final LakebaseDataApiClient lakebase; private final MockCoreData mock;
    public PlantCrudService(LakebaseDataApiClient lakebase, MockCoreData mock){this.lakebase=lakebase;this.mock=mock;}
    public boolean isMock(){ return "mock".equalsIgnoreCase(System.getenv().getOrDefault("PLANT_CRUD_MODE", System.getenv().getOrDefault("LAKEBASE_MODE","mock"))); }
    public String currentMode(){return isMock()?"mock":"data-api";}
    public List<CoreOrganization> organizations(Boolean active){return isMock()?mock.organizations(active):lakebase.listCoreOrganizations(active);}
    public Optional<CoreOrganization> organization(long id){return isMock()?mock.organization(id):lakebase.getCoreOrganization(id);}
    public List<PlantDetails> list(Long orgId,Boolean active){return isMock()?mock.plants(orgId,active):lakebase.listCorePlants(orgId,active);}
    public Optional<PlantDetails> get(long id){return isMock()?mock.plant(id):lakebase.getCorePlant(id);}
    public PlantDetails create(PlantCreateRequest r,String audit){validate(r);return isMock()?mock.create(r,audit):lakebase.createCorePlant(r,audit);}
    public Optional<PlantDetails> patch(long id,PlantUpdateRequest r,String audit){return isMock()?mock.patch(id,r,audit):lakebase.patchCorePlant(id,r,audit);}
    public Optional<PlantDetails> replace(long id,PlantCreateRequest r,String audit){validate(r);return isMock()?mock.replace(id,r,audit):lakebase.replaceCorePlant(id,r,audit);}
    public boolean delete(long id){return isMock()?mock.delete(id):lakebase.deleteCorePlant(id);}
    public void health(){if(!isMock())lakebase.healthCheckCore();}
    private void validate(PlantCreateRequest r){
        if(r==null||r.organizationId()==null||blank(r.plantCode())||blank(r.plantName())||blank(r.country())) throw new IllegalArgumentException("organizationId, plantCode, plantName and country are required");
    }
    private boolean blank(String v){return v==null||v.isBlank();}
}
