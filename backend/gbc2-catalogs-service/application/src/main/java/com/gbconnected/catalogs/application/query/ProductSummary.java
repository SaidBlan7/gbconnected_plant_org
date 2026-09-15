package com.gbconnected.catalogs.application.query;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

public record ProductSummary(
        long productId,
        long organizationId,
        String oracleItemCode,
        String erpName,
        String productName,
        String completionSubinventory,
        long baseDoughId,
        String baseDoughCode,
        String baseDoughName,
        boolean defaultItem,
        boolean semiFinished,
        String semiFinishedUom,
        boolean lidDesignWasteEnabled,
        BigDecimal lidDesignWasteWeightKg,
        boolean edgeDesignWasteEnabled,
        BigDecimal edgeDesignWasteWeightKg,
        boolean active,
        List<ProductLineSummary> lineConfigurations,
        Instant createdAt,
        Instant updatedAt
) {}
