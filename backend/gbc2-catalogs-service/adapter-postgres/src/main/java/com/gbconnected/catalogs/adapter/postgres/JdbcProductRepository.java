package com.gbconnected.catalogs.adapter.postgres;

import com.gbconnected.catalogs.application.DefaultProductConflictException;
import com.gbconnected.catalogs.application.DuplicateProductException;
import com.gbconnected.catalogs.application.command.AuditContext;
import com.gbconnected.catalogs.application.command.RejectedProductAudit;
import com.gbconnected.catalogs.application.port.out.ProductRepository;
import com.gbconnected.catalogs.domain.Product;
import com.gbconnected.catalogs.domain.ProductLineConfiguration;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import javax.sql.DataSource;
import org.postgresql.util.PGobject;

public final class JdbcProductRepository implements ProductRepository {
    private static final Gson JSON = new GsonBuilder().serializeNulls().create();

    private final DataSource dataSource;

    public JdbcProductRepository(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public Product insert(Product product, AuditContext audit) {
        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);
            try {
                String sql = """
                        INSERT INTO core.product (
                            organization_id,
                            oracle_item_code,
                            erp_name,
                            product_name,
                            completion_subinventory,
                            base_dough_id,
                            is_default_item,
                            is_semi_finished,
                            semi_finished_uom,
                            has_lid_design_waste,
                            lid_design_waste_weight_kg,
                            has_edge_design_waste,
                            edge_design_waste_weight_kg,
                            is_active
                        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                        RETURNING product_id, created_at, updated_at
                        """;

                long id;
                Instant createdAt;
                Instant updatedAt;
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    bindMaster(statement, product);
                    try (ResultSet result = statement.executeQuery()) {
                        if (!result.next()) throw new IllegalStateException("Product insert returned no row");
                        id = result.getLong("product_id");
                        createdAt = instant(result, "created_at");
                        updatedAt = instant(result, "updated_at");
                    }
                }

                Product persisted = persisted(product, id, createdAt, updatedAt);
                insertLineConfigurationRows(connection, persisted);
                writeAudit(connection, persisted, null, "PRODUCT_CREATED", "SUCCESS", audit, null);
                connection.commit();
                return persisted;
            } catch (SQLException | RuntimeException ex) {
                rollback(connection);
                if (ex instanceof SQLException sql) throw translate(sql, product.baseDoughId(), "insert product");
                throw ex;
            }
        } catch (SQLException ex) {
            throw translate(ex, product.baseDoughId(), "insert product");
        }
    }

    @Override
    public Optional<Product> findProductAggregateById(long id) {
        String sql = """
                SELECT
                    product_id, organization_id, oracle_item_code, erp_name, product_name,
                    completion_subinventory, base_dough_id, is_default_item,
                    is_semi_finished, semi_finished_uom,
                    has_lid_design_waste, lid_design_waste_weight_kg,
                    has_edge_design_waste, edge_design_waste_weight_kg,
                    is_active, created_at, updated_at
                FROM core.product
                WHERE product_id = ?
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) return Optional.empty();
                return Optional.of(mapProduct(connection, result));
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to load product aggregate", ex);
        }
    }

    @Override
    public Product update(Product previous, Product product, AuditContext audit) {
        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);
            try {
                String sql = """
                        UPDATE core.product SET
                            organization_id = ?,
                            oracle_item_code = ?,
                            erp_name = ?,
                            product_name = ?,
                            completion_subinventory = ?,
                            base_dough_id = ?,
                            is_default_item = ?,
                            is_semi_finished = ?,
                            semi_finished_uom = ?,
                            has_lid_design_waste = ?,
                            lid_design_waste_weight_kg = ?,
                            has_edge_design_waste = ?,
                            edge_design_waste_weight_kg = ?,
                            is_active = ?,
                            updated_at = CURRENT_TIMESTAMP
                        WHERE product_id = ?
                        RETURNING created_at, updated_at
                        """;

                Instant createdAt;
                Instant updatedAt;
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    bindMaster(statement, product);
                    statement.setLong(15, product.id());
                    try (ResultSet result = statement.executeQuery()) {
                        if (!result.next()) throw new IllegalStateException("Product disappeared during update");
                        createdAt = instant(result, "created_at");
                        updatedAt = instant(result, "updated_at");
                    }
                }

                deleteLineConfigurationRows(connection, product.id());
                Product persisted = persisted(product, product.id(), createdAt, updatedAt);
                insertLineConfigurationRows(connection, persisted);
                writeUpdateAudit(connection, previous, persisted, audit);
                connection.commit();
                return persisted;
            } catch (SQLException | RuntimeException ex) {
                rollback(connection);
                if (ex instanceof SQLException sql) throw translate(sql, product.baseDoughId(), "update product");
                throw ex;
            }
        } catch (SQLException ex) {
            throw translate(ex, product.baseDoughId(), "update product");
        }
    }

    @Override
    public boolean hasActiveDefault(long doughId, Long excludingProductId) {
        String sql = """
                SELECT 1
                FROM core.product
                WHERE base_dough_id = ?
                  AND is_default_item = true
                  AND is_active = true
                  AND (? IS NULL OR product_id <> ?)
                LIMIT 1
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, doughId);
            if (excludingProductId == null) {
                statement.setNull(2, java.sql.Types.BIGINT);
                statement.setNull(3, java.sql.Types.BIGINT);
            } else {
                statement.setLong(2, excludingProductId);
                statement.setLong(3, excludingProductId);
            }
            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to validate default product", ex);
        }
    }

    @Override
    public void recordRejectedAudit(RejectedProductAudit rejected) {
        String sql = """
                INSERT INTO core.product_audit_log (
                    product_id, organization_id, line_id, item_code,
                    event_type, event_status, source_type, actor, correlation_id,
                    details
                ) VALUES (?,?,?,?,?,'REJECTED',?,?,?,?)
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            nullableLong(statement, 1, rejected.productId());
            statement.setLong(2, rejected.organizationId());
            nullableLong(statement, 3, rejected.lineId());
            statement.setString(4, rejected.itemCode());
            statement.setString(5, rejected.eventType());
            statement.setString(6, rejected.audit().sourceType());
            statement.setString(7, rejected.audit().actor());
            statement.setString(8, rejected.audit().correlationId());
            statement.setObject(9, jsonb(Map.of(
                    "validationCode", rejected.validationCode(),
                    "message", rejected.message() == null ? "Request rejected" : rejected.message())));
            statement.executeUpdate();
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to write rejected product audit", ex);
        }
    }

    private void bindMaster(PreparedStatement statement, Product product) throws SQLException {
        statement.setLong(1, product.organizationId());
        statement.setString(2, product.oracleItemCode());
        statement.setString(3, product.erpName());
        statement.setString(4, product.productName());
        statement.setString(5, product.completionSubinventory());
        statement.setLong(6, product.baseDoughId());
        statement.setBoolean(7, product.defaultItem());
        statement.setBoolean(8, product.semiFinished());
        statement.setString(9, product.semiFinishedUom());
        statement.setBoolean(10, product.lidDesignWasteEnabled());
        statement.setBigDecimal(11, product.lidDesignWasteWeightKg());
        statement.setBoolean(12, product.edgeDesignWasteEnabled());
        statement.setBigDecimal(13, product.edgeDesignWasteWeightKg());
        statement.setBoolean(14, product.active());
    }

    private void insertLineConfigurationRows(Connection connection, Product product) throws SQLException {
        String productDoughSql = """
                INSERT INTO core.product_dough (
                    line_id, product_id, dough_id, is_primary, is_active
                ) VALUES (?,?,?,?,?)
                """;
        String configurationSql = """
                INSERT INTO packaging.line_product_configuration (
                    line_id, product_id, hourly_production_rate,
                    primary_uom_id, packages_per_uom, pieces_per_package,
                    secondary_uom_id, uoms_per_secondary_container,
                    target_weight_package_kg, is_default_item, is_active,
                    integration_item_code
                ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
                """;

        try (PreparedStatement doughStatement = connection.prepareStatement(productDoughSql);
             PreparedStatement configStatement = connection.prepareStatement(configurationSql)) {
            for (ProductLineConfiguration line : product.lineConfigurations()) {
                boolean associationActive = line.active();

                doughStatement.setLong(1, line.lineId());
                doughStatement.setLong(2, product.id());
                doughStatement.setLong(3, product.baseDoughId());
                doughStatement.setBoolean(4, true);
                doughStatement.setBoolean(5, associationActive);
                doughStatement.addBatch();

                configStatement.setLong(1, line.lineId());
                configStatement.setLong(2, product.id());
                configStatement.setBigDecimal(3, line.hourlyProductionRate());
                configStatement.setLong(4, line.primaryUomId());
                configStatement.setBigDecimal(5, line.packagesPerUom());
                configStatement.setBigDecimal(6, line.piecesPerPackage());
                nullableLong(configStatement, 7, line.secondaryUomId());
                configStatement.setBigDecimal(8, line.uomsPerSecondaryContainer());
                configStatement.setBigDecimal(9, line.targetWeightPackageKg());
                configStatement.setBoolean(10, product.active() && product.defaultItem() && associationActive);
                configStatement.setBoolean(11, associationActive);
                configStatement.setString(12, line.integrationItemCode());
                configStatement.addBatch();
            }
            doughStatement.executeBatch();
            configStatement.executeBatch();
        }
    }

    private void deleteLineConfigurationRows(Connection connection, long productId) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "DELETE FROM packaging.line_product_configuration WHERE product_id = ?")) {
            statement.setLong(1, productId);
            statement.executeUpdate();
        }
        try (PreparedStatement statement = connection.prepareStatement(
                "DELETE FROM core.product_dough WHERE product_id = ?")) {
            statement.setLong(1, productId);
            statement.executeUpdate();
        }
    }

    private Product mapProduct(Connection connection, ResultSet result) throws SQLException {
        long productId = result.getLong("product_id");
        return Product.rehydrate(
                productId,
                result.getLong("organization_id"),
                result.getString("oracle_item_code"),
                result.getString("erp_name"),
                result.getString("product_name"),
                result.getString("completion_subinventory"),
                result.getLong("base_dough_id"),
                result.getBoolean("is_default_item"),
                result.getBoolean("is_semi_finished"),
                result.getString("semi_finished_uom"),
                result.getBoolean("has_lid_design_waste"),
                result.getBigDecimal("lid_design_waste_weight_kg"),
                result.getBoolean("has_edge_design_waste"),
                result.getBigDecimal("edge_design_waste_weight_kg"),
                result.getBoolean("is_active"),
                loadLineConfigurations(connection, productId),
                instant(result, "created_at"),
                instant(result, "updated_at"));
    }

    private List<ProductLineConfiguration> loadLineConfigurations(Connection connection, long productId)
            throws SQLException {
        String sql = """
                SELECT
                    line_id, integration_item_code, hourly_production_rate,
                    primary_uom_id, packages_per_uom, pieces_per_package,
                    secondary_uom_id, uoms_per_secondary_container,
                    target_weight_package_kg, is_active
                FROM packaging.line_product_configuration
                WHERE product_id = ?
                ORDER BY line_id
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, productId);
            try (ResultSet result = statement.executeQuery()) {
                List<ProductLineConfiguration> rows = new ArrayList<>();
                while (result.next()) {
                    rows.add(new ProductLineConfiguration(
                            result.getLong("line_id"),
                            result.getString("integration_item_code"),
                            result.getBigDecimal("hourly_production_rate"),
                            result.getLong("primary_uom_id"),
                            result.getBigDecimal("packages_per_uom"),
                            result.getBigDecimal("pieces_per_package"),
                            nullableLong(result, "secondary_uom_id"),
                            result.getBigDecimal("uoms_per_secondary_container"),
                            result.getBigDecimal("target_weight_package_kg"),
                            result.getBoolean("is_active")));
                }
                return List.copyOf(rows);
            }
        }
    }

    private void writeUpdateAudit(
            Connection connection,
            Product previous,
            Product current,
            AuditContext audit) throws SQLException {
        writeAudit(connection, current, previous, "PRODUCT_UPDATED", "SUCCESS", audit, null);
        if (previous.active() != current.active()) {
            writeAudit(connection, current, previous, "STATUS_CHANGED", "SUCCESS", audit, null);
        }
        if (previous.defaultItem() != current.defaultItem()
                || previous.baseDoughId() != current.baseDoughId()) {
            writeAudit(connection, current, previous, "DEFAULT_CHANGED", "SUCCESS", audit, null);
        }
        if (previous.semiFinished() != current.semiFinished()
                || !Objects.equals(previous.semiFinishedUom(), current.semiFinishedUom())) {
            writeAudit(connection, current, previous, "SEMI_FINISHED_CHANGED", "SUCCESS", audit, null);
        }
        if (previous.lidDesignWasteEnabled() != current.lidDesignWasteEnabled()
                || !Objects.equals(previous.lidDesignWasteWeightKg(), current.lidDesignWasteWeightKg())
                || previous.edgeDesignWasteEnabled() != current.edgeDesignWasteEnabled()
                || !Objects.equals(previous.edgeDesignWasteWeightKg(), current.edgeDesignWasteWeightKg())) {
            writeAudit(connection, current, previous, "DESIGN_WASTE_CHANGED", "SUCCESS", audit, null);
        }
        if (!previous.lineConfigurations().equals(current.lineConfigurations())) {
            writeAudit(connection, current, previous, "LINE_CONFIGURATION_CHANGED", "SUCCESS", audit, null);
        }
    }

    private void writeAudit(
            Connection connection,
            Product current,
            Product previous,
            String eventType,
            String eventStatus,
            AuditContext audit,
            Map<String, Object> details) throws SQLException {
        String sql = """
                INSERT INTO core.product_audit_log (
                    product_id, organization_id, item_code,
                    event_type, event_status, source_type, actor, correlation_id,
                    old_values, new_values, details
                ) VALUES (?,?,?,?,?,?,?,?,?,?,?)
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, current.id());
            statement.setLong(2, current.organizationId());
            statement.setString(3, current.oracleItemCode());
            statement.setString(4, eventType);
            statement.setString(5, eventStatus);
            statement.setString(6, audit.sourceType());
            statement.setString(7, audit.actor());
            statement.setString(8, audit.correlationId());
            statement.setObject(9, previous == null ? null : jsonb(snapshot(previous)));
            statement.setObject(10, jsonb(snapshot(current)));
            statement.setObject(11, details == null ? null : jsonb(details));
            statement.executeUpdate();
        }
    }

    private Map<String, Object> snapshot(Product product) {
        Map<String, Object> value = new LinkedHashMap<>();
        value.put("productId", product.id());
        value.put("organizationId", product.organizationId());
        value.put("oracleItemCode", product.oracleItemCode());
        value.put("erpName", product.erpName());
        value.put("productName", product.productName());
        value.put("completionSubinventory", product.completionSubinventory());
        value.put("baseDoughId", product.baseDoughId());
        value.put("defaultItem", product.defaultItem());
        value.put("semiFinished", product.semiFinished());
        value.put("semiFinishedUom", product.semiFinishedUom());
        value.put("lidDesignWasteEnabled", product.lidDesignWasteEnabled());
        value.put("lidDesignWasteWeightKg", product.lidDesignWasteWeightKg());
        value.put("edgeDesignWasteEnabled", product.edgeDesignWasteEnabled());
        value.put("edgeDesignWasteWeightKg", product.edgeDesignWasteWeightKg());
        value.put("active", product.active());
        value.put("lineConfigurations", product.lineConfigurations());
        return value;
    }

    private Product persisted(Product p, long id, Instant created, Instant updated) {
        return Product.rehydrate(id, p.organizationId(), p.oracleItemCode(), p.erpName(), p.productName(),
                p.completionSubinventory(), p.baseDoughId(), p.defaultItem(), p.semiFinished(),
                p.semiFinishedUom(), p.lidDesignWasteEnabled(), p.lidDesignWasteWeightKg(),
                p.edgeDesignWasteEnabled(), p.edgeDesignWasteWeightKg(), p.active(),
                p.lineConfigurations(), created, updated);
    }

    private RuntimeException translate(SQLException ex, long doughId, String operation) {
        if ("23505".equals(ex.getSQLState())) {
            String message = ex.getMessage() == null ? "" : ex.getMessage();
            if (message.contains("uq_product_default_per_dough")) {
                return new DefaultProductConflictException(doughId, ex);
            }
            return new DuplicateProductException(
                    "A product with the same organizationId and oracleItemCode already exists", ex);
        }
        return new IllegalStateException("Failed to " + operation, ex);
    }

    private void rollback(Connection connection) {
        try {
            connection.rollback();
        } catch (SQLException ignored) {
            // Preserve the original error.
        }
    }

    private PGobject jsonb(Object value) throws SQLException {
        PGobject object = new PGobject();
        object.setType("jsonb");
        object.setValue(JSON.toJson(value));
        return object;
    }

    private void nullableLong(PreparedStatement statement, int index, Long value) throws SQLException {
        if (value == null) statement.setNull(index, java.sql.Types.BIGINT);
        else statement.setLong(index, value);
    }

    private Long nullableLong(ResultSet result, String column) throws SQLException {
        long value = result.getLong(column);
        return result.wasNull() ? null : value;
    }

    private Instant instant(ResultSet result, String column) throws SQLException {
        Timestamp timestamp = result.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }
}
