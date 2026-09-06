package com.gbc.access.model;

import java.math.BigDecimal;

public record PlantCreateRequest(
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
        String sourceSystem
) {}
