package com.gbconnected.catalogs.application.query;

import java.time.Instant;

public record PlantSummary(
        long plantId,
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
) {}