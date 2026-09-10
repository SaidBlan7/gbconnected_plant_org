package com.gbconnected.catalogs.functions;

import com.gbconnected.catalogs.domain.Plant;

import java.time.Instant;

record PlantFunctionResponse(
        Long plantId,
        long organizationId,
        String plantCode,
        String plantName,
        String erpPlantCode,
        String countryCode,
        String regionCode,
        String address,
        String timezoneName,
        String languageCode,
        boolean active,
        Instant createdAt,
        Instant updatedAt
) {

    static PlantFunctionResponse from(Plant p) {
        return new PlantFunctionResponse(
                p.id(),
                p.organizationId(),
                p.plantCode(),
                p.plantName(),
                p.erpPlantCode(),
                p.countryCode(),
                p.regionCode(),
                p.address(),
                p.timezoneName(),
                p.languageCode(),
                p.active(),
                p.createdAt(),
                p.updatedAt()
        );
    }
}