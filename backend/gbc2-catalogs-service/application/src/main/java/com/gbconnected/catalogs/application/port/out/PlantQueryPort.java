package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.application.query.PlantSummary;

import java.util.*;

public interface PlantQueryPort {

    List<PlantSummary> findAll(Long organizationId, Boolean active);

    Optional<PlantSummary> findPlantById(long id);
}