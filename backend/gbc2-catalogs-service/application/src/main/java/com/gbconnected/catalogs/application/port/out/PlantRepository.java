package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.domain.Plant;

import java.util.Optional;

public interface PlantRepository {

    Plant insert(Plant plant);

    Optional<Plant> findAggregateById(long id);

    Plant update(Plant plant);

    boolean delete(long id);
}