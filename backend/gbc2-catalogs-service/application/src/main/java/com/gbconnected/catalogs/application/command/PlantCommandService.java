package com.gbconnected.catalogs.application.command;
import com.gbconnected.catalogs.application.PlantNotFoundException;
import com.gbconnected.catalogs.application.port.out.PlantRepository;
import com.gbconnected.catalogs.domain.Plant;
import java.util.Objects;
public final class PlantCommandService implements PlantCommandUseCase {
 private final PlantRepository repository;
 public PlantCommandService(PlantRepository repository){this.repository=Objects.requireNonNull(repository);}
 public Plant create(CreatePlantCommand c){Objects.requireNonNull(c); return repository.insert(Plant.create(c.organizationId(),c.plantCode(),c.plantName(),c.erpPlantCode(),c.countryCode(),c.regionCode(),c.address(),c.timezoneName(),c.languageCode(),c.active()));}
 public Plant replace(long id,ReplacePlantCommand c){Objects.requireNonNull(c); Plant current=repository.findAggregateById(id).orElseThrow(()->new PlantNotFoundException(id)); return repository.update(current.replace(c.organizationId(),c.plantCode(),c.plantName(),c.erpPlantCode(),c.countryCode(),c.regionCode(),c.address(),c.timezoneName(),c.languageCode(),c.active()));}
 public Plant patch(long id,PatchPlantCommand c){Objects.requireNonNull(c); Plant current=repository.findAggregateById(id).orElseThrow(()->new PlantNotFoundException(id)); return repository.update(current.patch(c.organizationId(),c.plantCode(),c.plantName(),c.erpPlantCode(),c.countryCode(),c.regionCode(),c.address(),c.timezoneName(),c.languageCode(),c.active()));}
 public void delete(long id){ if(!repository.delete(id)) throw new PlantNotFoundException(id); }
}
