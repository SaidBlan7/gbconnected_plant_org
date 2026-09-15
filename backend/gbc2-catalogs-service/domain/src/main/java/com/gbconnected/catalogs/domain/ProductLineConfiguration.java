package com.gbconnected.catalogs.domain;

import java.math.BigDecimal;

public record ProductLineConfiguration(
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
    public ProductLineConfiguration {
        if (lineId <= 0) throw new DomainValidationException("lineId must be positive");
        if (primaryUomId <= 0) throw new DomainValidationException("primaryUomId must be positive");
        positive(hourlyProductionRate, "hourlyProductionRate");
        positive(packagesPerUom, "packagesPerUom");
        positive(piecesPerPackage, "piecesPerPackage");
        positive(targetWeightPackageKg, "targetWeightPackageKg");

        if (integrationItemCode != null) {
            integrationItemCode = integrationItemCode.trim();
            if (integrationItemCode.isEmpty()) integrationItemCode = null;
            if (integrationItemCode != null && integrationItemCode.length() > 100) {
                throw new DomainValidationException("integrationItemCode exceeds 100 characters");
            }
        }

        if ((secondaryUomId == null) != (uomsPerSecondaryContainer == null)) {
            throw new DomainValidationException(
                    "secondaryUomId and uomsPerSecondaryContainer must be provided together");
        }
        if (secondaryUomId != null && secondaryUomId <= 0) {
            throw new DomainValidationException("secondaryUomId must be positive");
        }
        if (uomsPerSecondaryContainer != null) {
            positive(uomsPerSecondaryContainer, "uomsPerSecondaryContainer");
        }
    }

    public BigDecimal piecesPerPrimaryContainer() {
        return packagesPerUom.multiply(piecesPerPackage);
    }

    public BigDecimal packagesPerSecondaryContainer() {
        return uomsPerSecondaryContainer == null
                ? null
                : packagesPerUom.multiply(uomsPerSecondaryContainer);
    }

    public BigDecimal piecesPerSecondaryContainer() {
        BigDecimal packages = packagesPerSecondaryContainer();
        return packages == null ? null : packages.multiply(piecesPerPackage);
    }

    private static void positive(BigDecimal value, String field) {
        if (value == null || value.signum() <= 0) {
            throw new DomainValidationException(field + " must be greater than zero");
        }
    }
}
