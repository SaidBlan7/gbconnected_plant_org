package com.gbconnected.catalogs.application.query;

public record ProductionLineOption(
        long lineId,
        long plantId,
        long organizationId,
        String lineCode,
        String lineName,
        boolean active
) {}
