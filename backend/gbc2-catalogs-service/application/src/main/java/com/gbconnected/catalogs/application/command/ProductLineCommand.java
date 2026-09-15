package com.gbconnected.catalogs.application.command;

import com.gbconnected.catalogs.domain.ProductLineConfiguration;
import java.math.BigDecimal;

public record ProductLineCommand(
        long lineId,
        String integrationItemCode,
        BigDecimal hourlyProductionRate,
        long primaryUomId,
        BigDecimal packagesPerUom,
        BigDecimal piecesPerPackage,
        Long secondaryUomId,
        BigDecimal uomsPerSecondaryContainer,
        BigDecimal targetWeightPackageKg,
        boolean active
) {
    public ProductLineConfiguration toDomain() {
        return new ProductLineConfiguration(
                lineId,
                integrationItemCode,
                hourlyProductionRate,
                primaryUomId,
                packagesPerUom,
                piecesPerPackage,
                secondaryUomId,
                uomsPerSecondaryContainer,
                targetWeightPackageKg,
                active);
    }
}
