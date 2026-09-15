package com.gbconnected.catalogs.functions;

import java.math.BigDecimal;
import java.util.List;

final class ProductFunctionRequest {
    Long organizationId;
    String oracleItemCode;
    String erpName;
    String productName;
    String completionSubinventory;
    Long baseDoughId;
    Boolean defaultItem;
    Boolean semiFinished;
    String semiFinishedUom;
    Boolean lidDesignWasteEnabled;
    BigDecimal lidDesignWasteWeightKg;
    Boolean edgeDesignWasteEnabled;
    BigDecimal edgeDesignWasteWeightKg;
    Boolean active;
    List<Line> lineConfigurations;

    static final class Line {
        Long lineId;
        String integrationItemCode;
        BigDecimal hourlyProductionRate;
        Long primaryUomId;
        BigDecimal packagesPerUom;
        BigDecimal piecesPerPackage;
        Long secondaryUomId;
        BigDecimal uomsPerSecondaryContainer;
        BigDecimal targetWeightPackageGrams;
        Boolean active;
    }
}
