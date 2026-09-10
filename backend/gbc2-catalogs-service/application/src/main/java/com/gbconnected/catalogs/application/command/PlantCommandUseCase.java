package com.gbconnected.catalogs.application.command;

import com.gbconnected.catalogs.domain.Plant;

public interface PlantCommandUseCase {

    Plant create(CreatePlantCommand c);

    Plant replace(long id, ReplacePlantCommand c);

    Plant patch(long id, PatchPlantCommand c);

    void delete(long id);
}