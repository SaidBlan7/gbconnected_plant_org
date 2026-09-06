package com.gbc.access.model;

import java.math.BigDecimal;
import java.time.Instant;

public record PlantDetails(
        Long plantId,
        Long organizationId,
        String plantCode,
        String plantName,
        String country,
        String plantAddress,
        String plantTimezone,
        BigDecimal plantLatitude,
        BigDecimal plantLongitude,
        String plantState,
        String plantMunicipality,
        Boolean active,
        String sourceSystem,
        Instant createdAt,
        Instant updatedAt,
        String createdBy,
        String updatedBy
) {}
