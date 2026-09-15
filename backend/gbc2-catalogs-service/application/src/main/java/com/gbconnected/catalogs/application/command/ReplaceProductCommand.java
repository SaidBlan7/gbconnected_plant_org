package com.gbconnected.catalogs.application.command;

import java.math.BigDecimal;
import java.util.List;

public record ReplaceProductCommand(
        long organizationId,
        String oracleItemCode,
        String erpName,
        String productName,
        String completionSubinventory,
        long baseDoughId,
        boolean defaultItem,
        boolean semiFinished,
        String semiFinishedUom,
        boolean lidDesignWasteEnabled,
        BigDecimal lidDesignWasteWeightKg,
        boolean edgeDesignWasteEnabled,
        BigDecimal edgeDesignWasteWeightKg,
        boolean active,
        List<ProductLineCommand> lineConfigurations,
        AuditContext audit
) {}
