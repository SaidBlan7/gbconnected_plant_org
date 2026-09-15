package com.gbconnected.catalogs.application.command;

import java.math.BigDecimal;
import java.util.List;

public record PatchProductCommand(
        Long organizationId,
        String oracleItemCode,
        String erpName,
        String productName,
        String completionSubinventory,
        Long baseDoughId,
        Boolean defaultItem,
        Boolean semiFinished,
        String semiFinishedUom,
        Boolean lidDesignWasteEnabled,
        BigDecimal lidDesignWasteWeightKg,
        Boolean edgeDesignWasteEnabled,
        BigDecimal edgeDesignWasteWeightKg,
        Boolean active,
        List<ProductLineCommand> lineConfigurations,
        AuditContext audit
) {}
