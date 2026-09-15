package com.gbconnected.catalogs.appservice.web;

import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.List;

public record ProductHttpRequest(
        @NotNull @Positive Long organizationId,
        @NotBlank @Size(max = 100) String oracleItemCode,
        @Size(max = 250) String erpName,
        @NotBlank @Size(max = 250) String productName,
        @Size(max = 30) String completionSubinventory,
        @NotNull @Positive Long baseDoughId,
        Boolean defaultItem,
        Boolean semiFinished,
        @Size(max = 10) String semiFinishedUom,
        Boolean lidDesignWasteEnabled,
        @DecimalMin(value = "0", inclusive = false) BigDecimal lidDesignWasteWeightKg,
        Boolean edgeDesignWasteEnabled,
        @DecimalMin(value = "0", inclusive = false) BigDecimal edgeDesignWasteWeightKg,
        Boolean active,
        @NotEmpty List<@Valid ProductLineHttpRequest> lineConfigurations
) {}
