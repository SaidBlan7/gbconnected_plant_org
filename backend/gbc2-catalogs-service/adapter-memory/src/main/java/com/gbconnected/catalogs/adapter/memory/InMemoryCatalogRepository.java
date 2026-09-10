package com.gbconnected.catalogs.adapter.memory;
import com.gbconnected.catalogs.application.DuplicatePlantException;
import com.gbconnected.catalogs.application.port.out.*; import com.gbconnected.catalogs.application.query.*; import com.gbconnected.catalogs.domain.Plant;
import java.time.Instant; import java.util.*; import java.util.concurrent.ConcurrentHashMap; import java.util.concurrent.atomic.AtomicLong;
public final class InMemoryCatalogRepository implements OrganizationQueryPort,PlantQueryPort,PlantRepository,DatabaseHealthPort {
 private final Map<Long,OrganizationSummary> orgs=new LinkedHashMap<>(); private final Map<Long,Plant> plants=new ConcurrentHashMap<>(); private final AtomicLong ids=new AtomicLong(4);
 public InMemoryCatalogRepository(){Instant now=Instant.now(); orgs.put(1L,new OrganizationSummary(1,"MX","Organización México",true,now,now)); orgs.put(2L,new OrganizationSummary(2,"US","Organización Estados Unidos",true,now,now)); plants.put(1L,Plant.rehydrate(1,1,"TOL","Planta Toluca",null,"MX",null,null,"America/Mexico_City","es-MX",true,now,now)); plants.put(2L,Plant.rehydrate(2,1,"PUE","Planta Puebla",null,"MX",null,null,"America/Mexico_City","es-MX",true,now,now)); plants.put(3L,Plant.rehydrate(3,2,"TX","Planta Texas",null,"US",null,null,"America/Chicago","en-US",true,now,now));}
 public List<OrganizationSummary> findAll(Boolean active){return orgs.values().stream().filter(o->active==null||o.active()==active).toList();}
 public Optional<OrganizationSummary> findOrganizationById(long id){return Optional.ofNullable(orgs.get(id));}
 public List<PlantSummary> findAll(Long organizationId,Boolean active){return plants.values().stream().filter(p->organizationId==null||p.organizationId()==organizationId).filter(p->active==null||p.active()==active).sorted(Comparator.comparing(Plant::plantName)).map(this::summary).toList();}
 public Optional<PlantSummary> findPlantById(long id){return Optional.ofNullable(plants.get(id)).map(this::summary);}
 public Plant insert(Plant p){ if(plants.values().stream().anyMatch(x->x.organizationId()==p.organizationId()&&x.plantCode().equalsIgnoreCase(p.plantCode()))) throw new DuplicatePlantException("A plant with the same organizationId and plantCode already exists",null); long id=ids.getAndIncrement(); Instant now=Instant.now(); Plant n=Plant.rehydrate(id,p.organizationId(),p.plantCode(),p.plantName(),p.erpPlantCode(),p.countryCode(),p.regionCode(),p.address(),p.timezoneName(),p.languageCode(),p.active(),now,now); plants.put(id,n); return n;}
 public Optional<Plant> findAggregateById(long id){return Optional.ofNullable(plants.get(id));}
 public Plant update(Plant p){Instant now=Instant.now(); Plant n=Plant.rehydrate(p.id(),p.organizationId(),p.plantCode(),p.plantName(),p.erpPlantCode(),p.countryCode(),p.regionCode(),p.address(),p.timezoneName(),p.languageCode(),p.active(),p.createdAt(),now); plants.put(p.id(),n); return n;}
 public boolean delete(long id){return plants.remove(id)!=null;} public void check(){}
 private PlantSummary summary(Plant p){return new PlantSummary(p.id(),p.organizationId(),p.plantCode(),p.plantName(),p.erpPlantCode(),p.countryCode(),p.regionCode(),p.address(),p.timezoneName(),p.languageCode(),p.active(),p.createdAt(),p.updatedAt());}
}
