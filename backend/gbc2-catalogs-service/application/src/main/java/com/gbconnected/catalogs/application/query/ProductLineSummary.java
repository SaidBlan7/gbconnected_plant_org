package com.gbconnected.catalogs.application.query;

import java.math.BigDecimal;

public record ProductLineSummary(
        long lineId,
        long plantId,
        String lineCode,
        String lineName,
        String integrationItemCode,
        BigDecimal hourlyProductionRate,
        long primaryUomId,
        String primaryUomCode,
        String primaryUomName,
        BigDecimal packagesPerUom,
        BigDecimal piecesPerPackage,
        BigDecimal piecesPerPrimaryContainer,
        Long secondaryUomId,
        String secondaryUomCode,
        String secondaryUomName,
        BigDecimal uomsPerSecondaryContainer,
        BigDecimal packagesPerSecondaryContainer,
        BigDecimal piecesPerSecondaryContainer,
        BigDecimal targetWeightPackageKg,
        BigDecimal targetWeightPackageGrams,
        boolean active
) {}
