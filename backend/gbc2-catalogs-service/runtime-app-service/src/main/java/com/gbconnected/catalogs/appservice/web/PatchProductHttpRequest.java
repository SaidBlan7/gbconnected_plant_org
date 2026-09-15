package com.gbconnected.catalogs.appservice.web;

import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.List;

public record PatchProductHttpRequest(
        @Positive Long organizationId,
        @Size(max = 100) String oracleItemCode,
        @Size(max = 250) String erpName,
        @Size(max = 250) String productName,
        @Size(max = 30) String completionSubinventory,
        @Positive Long baseDoughId,
        Boolean defaultItem,
        Boolean semiFinished,
        @Size(max = 10) String semiFinishedUom,
        Boolean lidDesignWasteEnabled,
        @DecimalMin(value = "0", inclusive = false) BigDecimal lidDesignWasteWeightKg,
        Boolean edgeDesignWasteEnabled,
        @DecimalMin(value = "0", inclusive = false) BigDecimal edgeDesignWasteWeightKg,
        Boolean active,
        List<@Valid ProductLineHttpRequest> lineConfigurations
) {}
