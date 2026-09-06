package com.gbc.access.service;

import com.gbc.access.model.*;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class MockCoreData {
    private final Map<Long, CoreOrganization> organizations = new LinkedHashMap<>();
    private final Map<Long, PlantDetails> plants = new ConcurrentHashMap<>();
    private final AtomicLong ids = new AtomicLong(4);

    public MockCoreData() {
        organizations.put(1L, new CoreOrganization(1L,"MX","Organización México","MX",true,"GBC_CONFIGURADOR"));
        organizations.put(2L, new CoreOrganization(2L,"US","Organización Estados Unidos","US",true,"GBC_CONFIGURADOR"));
        Instant now = Instant.now();
        plants.put(1L, plant(1,1,"TOL","Planta Toluca","México",now));
        plants.put(2L, plant(2,1,"PUE","Planta Puebla","México",now));
        plants.put(3L, plant(3,2,"TX","Planta Texas","Estados Unidos",now));
    }

    private PlantDetails plant(long id,long org,String code,String name,String country,Instant now){
        return new PlantDetails(id,org,code,name,country,null,"America/Mexico_City",null,null,null,null,true,"GBC_CONFIGURADOR",now,now,"GBC_ACCESS_API","GBC_ACCESS_API");
    }

    public List<CoreOrganization> organizations(Boolean active){
        return organizations.values().stream().filter(o -> active == null || Objects.equals(o.active(),active)).toList();
    }
    public Optional<CoreOrganization> organization(long id){ return Optional.ofNullable(organizations.get(id)); }
    public List<PlantDetails> plants(Long orgId, Boolean active){
        return plants.values().stream().filter(p -> orgId==null || Objects.equals(p.organizationId(),orgId)).filter(p -> active==null || Objects.equals(p.active(),active)).sorted(Comparator.comparing(PlantDetails::plantName)).toList();
    }
    public Optional<PlantDetails> plant(long id){ return Optional.ofNullable(plants.get(id)); }
    public PlantDetails create(PlantCreateRequest r,String audit){
        long id=ids.getAndIncrement(); Instant now=Instant.now();
        PlantDetails p=new PlantDetails(id,r.organizationId(),r.plantCode(),r.plantName(),r.country(),r.plantAddress(),r.plantTimezone(),r.plantLatitude(),r.plantLongitude(),r.plantState(),r.plantMunicipality(),r.active()==null?true:r.active(),r.sourceSystem()==null?"GBC_CONFIGURADOR":r.sourceSystem(),now,now,audit,audit);
        plants.put(id,p); return p;
    }
    public Optional<PlantDetails> patch(long id, PlantUpdateRequest r,String audit){
        PlantDetails p=plants.get(id); if(p==null)return Optional.empty();
        PlantDetails n=new PlantDetails(id, nvl(r.organizationId(),p.organizationId()), nvl(r.plantCode(),p.plantCode()), nvl(r.plantName(),p.plantName()), nvl(r.country(),p.country()), nvl(r.plantAddress(),p.plantAddress()), nvl(r.plantTimezone(),p.plantTimezone()), nvl(r.plantLatitude(),p.plantLatitude()), nvl(r.plantLongitude(),p.plantLongitude()), nvl(r.plantState(),p.plantState()), nvl(r.plantMunicipality(),p.plantMunicipality()), nvl(r.active(),p.active()), nvl(r.sourceSystem(),p.sourceSystem()), p.createdAt(),Instant.now(),p.createdBy(),audit);
        plants.put(id,n); return Optional.of(n);
    }
    public Optional<PlantDetails> replace(long id, PlantCreateRequest r,String audit){
        PlantDetails p=plants.get(id); if(p==null)return Optional.empty();
        PlantDetails n=new PlantDetails(id,r.organizationId(),r.plantCode(),r.plantName(),r.country(),r.plantAddress(),r.plantTimezone(),r.plantLatitude(),r.plantLongitude(),r.plantState(),r.plantMunicipality(),r.active()==null?true:r.active(),r.sourceSystem()==null?"GBC_CONFIGURADOR":r.sourceSystem(),p.createdAt(),Instant.now(),p.createdBy(),audit);
        plants.put(id,n); return Optional.of(n);
    }
    public boolean delete(long id){ return plants.remove(id)!=null; }
    private <T> T nvl(T a,T b){ return a==null?b:a; }
}
