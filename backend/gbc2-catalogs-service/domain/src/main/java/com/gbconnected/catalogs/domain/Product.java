package com.gbconnected.catalogs.domain;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

public final class Product {
    private static final Pattern ITEM_CODE = Pattern.compile("^[A-Za-z0-9._/-]+$");

    private final Long id;
    private final long organizationId;
    private final String oracleItemCode;
    private final String erpName;
    private final String productName;
    private final String completionSubinventory;
    private final long baseDoughId;
    private final boolean defaultItem;
    private final boolean semiFinished;
    private final String semiFinishedUom;
    private final boolean lidDesignWasteEnabled;
    private final BigDecimal lidDesignWasteWeightKg;
    private final boolean edgeDesignWasteEnabled;
    private final BigDecimal edgeDesignWasteWeightKg;
    private final boolean active;
    private final List<ProductLineConfiguration> lineConfigurations;
    private final Instant createdAt;
    private final Instant updatedAt;

    private Product(
            Long id,
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
            List<ProductLineConfiguration> lineConfigurations,
            Instant createdAt,
            Instant updatedAt) {
        if (organizationId <= 0) throw new DomainValidationException("organizationId must be positive");
        if (baseDoughId <= 0) throw new DomainValidationException("baseDoughId must be positive");

        this.id = id;
        this.organizationId = organizationId;
        this.oracleItemCode = itemCode(oracleItemCode);
        this.erpName = optional(erpName, 250);
        this.productName = required(productName, "productName", 250);
        this.completionSubinventory = optional(completionSubinventory, 30);
        this.baseDoughId = baseDoughId;
        this.active = active;
        this.defaultItem = active && defaultItem;
        this.semiFinished = semiFinished;
        this.semiFinishedUom = semiFinishedUom(semiFinished, semiFinishedUom);
        this.lidDesignWasteEnabled = lidDesignWasteEnabled;
        this.lidDesignWasteWeightKg = wasteWeight(
                lidDesignWasteEnabled, lidDesignWasteWeightKg, "lidDesignWasteWeightKg");
        this.edgeDesignWasteEnabled = edgeDesignWasteEnabled;
        this.edgeDesignWasteWeightKg = wasteWeight(
                edgeDesignWasteEnabled, edgeDesignWasteWeightKg, "edgeDesignWasteWeightKg");
        this.lineConfigurations = validateLines(lineConfigurations);
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public static Product create(
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
            List<ProductLineConfiguration> lineConfigurations) {
        return new Product(null, organizationId, oracleItemCode, erpName, productName,
                completionSubinventory, baseDoughId, defaultItem, semiFinished, semiFinishedUom,
                lidDesignWasteEnabled, lidDesignWasteWeightKg, edgeDesignWasteEnabled,
                edgeDesignWasteWeightKg, active, lineConfigurations, null, null);
    }

    public static Product rehydrate(
            long id,
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
            List<ProductLineConfiguration> lineConfigurations,
            Instant createdAt,
            Instant updatedAt) {
        return new Product(id, organizationId, oracleItemCode, erpName, productName,
                completionSubinventory, baseDoughId, defaultItem, semiFinished, semiFinishedUom,
                lidDesignWasteEnabled, lidDesignWasteWeightKg, edgeDesignWasteEnabled,
                edgeDesignWasteWeightKg, active, lineConfigurations, createdAt, updatedAt);
    }

    public Product replace(
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
            List<ProductLineConfiguration> lineConfigurations) {
        requirePersistent();
        return new Product(id, organizationId, oracleItemCode, erpName, productName,
                completionSubinventory, baseDoughId, defaultItem, semiFinished, semiFinishedUom,
                lidDesignWasteEnabled, lidDesignWasteWeightKg, edgeDesignWasteEnabled,
                edgeDesignWasteWeightKg, active, lineConfigurations, createdAt, updatedAt);
    }

    public Product patch(
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
            List<ProductLineConfiguration> lineConfigurations) {
        requirePersistent();

        boolean nextSemi = semiFinished == null ? this.semiFinished : semiFinished;
        String nextSemiUom = semiFinishedUom == null ? this.semiFinishedUom : semiFinishedUom;
        if (Boolean.FALSE.equals(semiFinished)) nextSemiUom = null;

        boolean nextLid = lidDesignWasteEnabled == null
                ? this.lidDesignWasteEnabled : lidDesignWasteEnabled;
        BigDecimal nextLidWeight = lidDesignWasteWeightKg == null
                ? this.lidDesignWasteWeightKg : lidDesignWasteWeightKg;
        if (Boolean.FALSE.equals(lidDesignWasteEnabled)) nextLidWeight = null;

        boolean nextEdge = edgeDesignWasteEnabled == null
                ? this.edgeDesignWasteEnabled : edgeDesignWasteEnabled;
        BigDecimal nextEdgeWeight = edgeDesignWasteWeightKg == null
                ? this.edgeDesignWasteWeightKg : edgeDesignWasteWeightKg;
        if (Boolean.FALSE.equals(edgeDesignWasteEnabled)) nextEdgeWeight = null;

        return new Product(
                id,
                organizationId == null ? this.organizationId : organizationId,
                oracleItemCode == null ? this.oracleItemCode : oracleItemCode,
                erpName == null ? this.erpName : erpName,
                productName == null ? this.productName : productName,
                completionSubinventory == null ? this.completionSubinventory : completionSubinventory,
                baseDoughId == null ? this.baseDoughId : baseDoughId,
                defaultItem == null ? this.defaultItem : defaultItem,
                nextSemi,
                nextSemiUom,
                nextLid,
                nextLidWeight,
                nextEdge,
                nextEdgeWeight,
                active == null ? this.active : active,
                lineConfigurations == null ? this.lineConfigurations : lineConfigurations,
                createdAt,
                updatedAt);
    }

    private static List<ProductLineConfiguration> validateLines(List<ProductLineConfiguration> lines) {
        if (lines == null || lines.isEmpty()) {
            throw new DomainValidationException("At least one line configuration is required");
        }
        Set<Long> ids = new HashSet<>();
        for (ProductLineConfiguration line : lines) {
            if (line == null) throw new DomainValidationException("lineConfigurations cannot contain null values");
            if (!ids.add(line.lineId())) {
                throw new DomainValidationException("lineId " + line.lineId() + " is duplicated");
            }
        }
        return List.copyOf(lines);
    }

    private static String itemCode(String value) {
        String result = required(value, "oracleItemCode", 100);
        if (!ITEM_CODE.matcher(result).matches()) {
            throw new DomainValidationException(
                    "oracleItemCode must contain only letters, numbers, '.', '_', '/', or '-'");
        }
        return result;
    }

    private static String semiFinishedUom(boolean enabled, String value) {
        if (!enabled) {
            if (value != null && !value.isBlank()) {
                throw new DomainValidationException("semiFinishedUom must be empty when semiFinished is false");
            }
            return null;
        }
        if (value == null || value.isBlank()) {
            throw new DomainValidationException("semiFinishedUom is required when semiFinished is true");
        }
        String normalized = value.trim().toUpperCase();
        if (!normalized.equals("PIECE") && !normalized.equals("KG")) {
            throw new DomainValidationException("semiFinishedUom must be PIECE or KG");
        }
        return normalized;
    }

    private static BigDecimal wasteWeight(boolean enabled, BigDecimal value, String field) {
        if (!enabled) {
            if (value != null) throw new DomainValidationException(field + " must be empty when its flag is false");
            return null;
        }
        if (value == null || value.signum() <= 0) {
            throw new DomainValidationException(field + " must be greater than zero when enabled");
        }
        return value;
    }

    private static String required(String value, String field, int max) {
        if (value == null || value.isBlank()) throw new DomainValidationException(field + " is required");
        String result = value.trim();
        if (result.length() > max) throw new DomainValidationException(field + " exceeds " + max + " characters");
        return result;
    }

    private static String optional(String value, int max) {
        if (value == null) return null;
        String result = value.trim();
        if (result.isEmpty()) return null;
        if (result.length() > max) throw new DomainValidationException("value exceeds " + max + " characters");
        return result;
    }

    private void requirePersistent() {
        if (id == null) throw new IllegalStateException("Product must be persisted first");
    }

    public Long id() { return id; }
    public long organizationId() { return organizationId; }
    public String oracleItemCode() { return oracleItemCode; }
    public String erpName() { return erpName; }
    public String productName() { return productName; }
    public String completionSubinventory() { return completionSubinventory; }
    public long baseDoughId() { return baseDoughId; }
    public boolean defaultItem() { return defaultItem; }
    public boolean semiFinished() { return semiFinished; }
    public String semiFinishedUom() { return semiFinishedUom; }
    public boolean lidDesignWasteEnabled() { return lidDesignWasteEnabled; }
    public BigDecimal lidDesignWasteWeightKg() { return lidDesignWasteWeightKg; }
    public boolean edgeDesignWasteEnabled() { return edgeDesignWasteEnabled; }
    public BigDecimal edgeDesignWasteWeightKg() { return edgeDesignWasteWeightKg; }
    public boolean active() { return active; }
    public List<ProductLineConfiguration> lineConfigurations() { return lineConfigurations; }
    public Instant createdAt() { return createdAt; }
    public Instant updatedAt() { return updatedAt; }
}
