package com.gbconnected.catalogs.appservice.web;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;

public record ProductLineHttpRequest(
        @Positive long lineId,
        @Size(max = 100) String integrationItemCode,
        @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal hourlyProductionRate,
        @Positive long primaryUomId,
        @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal packagesPerUom,
        @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal piecesPerPackage,
        @Positive Long secondaryUomId,
        @DecimalMin(value = "0", inclusive = false) BigDecimal uomsPerSecondaryContainer,
        @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal targetWeightPackageGrams,
        Boolean active
) {}
