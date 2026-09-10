package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.domain.Plant;

import java.time.Instant;

public record PlantHttpResponse(
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

    static PlantHttpResponse from(Plant p) {
        return new PlantHttpResponse(
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