package com.gbconnected.catalogs.adapter.postgres;

import com.gbconnected.catalogs.application.port.out.ProductQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductReferenceQueryPort;
import com.gbconnected.catalogs.application.query.ContainerUomOption;
import com.gbconnected.catalogs.application.query.DoughOption;
import com.gbconnected.catalogs.application.query.ProductLineSummary;
import com.gbconnected.catalogs.application.query.ProductSummary;
import com.gbconnected.catalogs.application.query.ProductionLineOption;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import javax.sql.DataSource;

public final class JdbcProductQueryAdapter implements ProductQueryPort, ProductReferenceQueryPort {
    private final DataSource dataSource;

    public JdbcProductQueryAdapter(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource);
    }

    @Override
    public List<ProductSummary> findAll(
            Long organizationId,
            Long plantId,
            Long lineId,
            Long doughId,
            Boolean active,
            Boolean semiFinished,
            String search) {
        StringBuilder sql = new StringBuilder("""
                SELECT
                    p.product_id, p.organization_id, p.oracle_item_code, p.erp_name,
                    p.product_name, p.completion_subinventory,
                    p.base_dough_id, d.dough_code, d.dough_name,
                    p.is_default_item, p.is_semi_finished, p.semi_finished_uom,
                    p.has_lid_design_waste, p.lid_design_waste_weight_kg,
                    p.has_edge_design_waste, p.edge_design_waste_weight_kg,
                    p.is_active, p.created_at, p.updated_at
                FROM core.product p
                JOIN core.dough d ON d.dough_id = p.base_dough_id
                """);

        List<Object> parameters = new ArrayList<>();
        List<String> filters = new ArrayList<>();
        if (organizationId != null) {
            filters.add("p.organization_id = ?");
            parameters.add(organizationId);
        }
        if (doughId != null) {
            filters.add("p.base_dough_id = ?");
            parameters.add(doughId);
        }
        if (active != null) {
            filters.add("p.is_active = ?");
            parameters.add(active);
        }
        if (semiFinished != null) {
            filters.add("p.is_semi_finished = ?");
            parameters.add(semiFinished);
        }
        if (lineId != null) {
            filters.add("EXISTS (SELECT 1 FROM packaging.line_product_configuration lpc WHERE lpc.product_id = p.product_id AND lpc.line_id = ? AND lpc.is_active = true)");
            parameters.add(lineId);
        }
        if (plantId != null) {
            filters.add("""
                    EXISTS (
                        SELECT 1
                        FROM packaging.line_product_configuration lpc
                        JOIN core.production_line pl ON pl.line_id = lpc.line_id
                        WHERE lpc.product_id = p.product_id
                          AND lpc.is_active = true
                          AND pl.plant_id = ?
                    )
                    """);
            parameters.add(plantId);
        }
        if (search != null && !search.isBlank()) {
            filters.add("(p.oracle_item_code ILIKE ? OR p.erp_name ILIKE ? OR p.product_name ILIKE ?)");
            String like = "%" + search.trim() + "%";
            parameters.add(like);
            parameters.add(like);
            parameters.add(like);
        }

        if (!filters.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", filters));
        }
        sql.append(" ORDER BY p.product_name, p.product_id");

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, parameters);
            try (ResultSet result = statement.executeQuery()) {
                List<ProductSummary> products = new ArrayList<>();
                while (result.next()) {
                    products.add(mapProductSummary(connection, result));
                }
                return List.copyOf(products);
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to list products", ex);
        }
    }

    @Override
    public Optional<ProductSummary> findProductById(long id) {
        String sql = """
                SELECT
                    p.product_id, p.organization_id, p.oracle_item_code, p.erp_name,
                    p.product_name, p.completion_subinventory,
                    p.base_dough_id, d.dough_code, d.dough_name,
                    p.is_default_item, p.is_semi_finished, p.semi_finished_uom,
                    p.has_lid_design_waste, p.lid_design_waste_weight_kg,
                    p.has_edge_design_waste, p.edge_design_waste_weight_kg,
                    p.is_active, p.created_at, p.updated_at
                FROM core.product p
                JOIN core.dough d ON d.dough_id = p.base_dough_id
                WHERE p.product_id = ?
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next()
                        ? Optional.of(mapProductSummary(connection, result))
                        : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to query product", ex);
        }
    }

    @Override
    public List<DoughOption> findDoughs(Long organizationId, Long lineId, Boolean active) {
        StringBuilder sql = new StringBuilder("""
                SELECT DISTINCT
                    d.dough_id, d.organization_id, d.dough_code, d.dough_name, d.is_active
                FROM core.dough d
                """);
        List<Object> parameters = new ArrayList<>();
        List<String> filters = new ArrayList<>();

        if (lineId != null) {
            sql.append(" JOIN core.line_dough_configuration ldc ON ldc.dough_id = d.dough_id ");
            filters.add("ldc.line_id = ?");
            parameters.add(lineId);
            filters.add("ldc.is_active = true");
        }
        if (organizationId != null) {
            filters.add("d.organization_id = ?");
            parameters.add(organizationId);
        }
        if (active != null) {
            filters.add("d.is_active = ?");
            parameters.add(active);
        }
        if (!filters.isEmpty()) sql.append(" WHERE ").append(String.join(" AND ", filters));
        sql.append(" ORDER BY d.dough_name");

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, parameters);
            try (ResultSet result = statement.executeQuery()) {
                List<DoughOption> rows = new ArrayList<>();
                while (result.next()) rows.add(dough(result));
                return List.copyOf(rows);
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to list doughs", ex);
        }
    }

    @Override
    public Optional<DoughOption> findDoughById(long id) {
        String sql = """
                SELECT dough_id, organization_id, dough_code, dough_name, is_active
                FROM core.dough
                WHERE dough_id = ?
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(dough(result)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to query dough", ex);
        }
    }

    @Override
    public List<ProductionLineOption> findLines(Long plantId, Long organizationId, Boolean active) {
        StringBuilder sql = new StringBuilder("""
                SELECT
                    l.line_id, l.plant_id, p.organization_id,
                    l.line_code, l.line_name, l.is_active
                FROM core.production_line l
                JOIN core.plant p ON p.plant_id = l.plant_id
                """);
        List<Object> parameters = new ArrayList<>();
        List<String> filters = new ArrayList<>();
        if (plantId != null) {
            filters.add("l.plant_id = ?");
            parameters.add(plantId);
        }
        if (organizationId != null) {
            filters.add("p.organization_id = ?");
            parameters.add(organizationId);
        }
        if (active != null) {
            filters.add("l.is_active = ?");
            parameters.add(active);
        }
        if (!filters.isEmpty()) sql.append(" WHERE ").append(String.join(" AND ", filters));
        sql.append(" ORDER BY l.line_name");

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, parameters);
            try (ResultSet result = statement.executeQuery()) {
                List<ProductionLineOption> rows = new ArrayList<>();
                while (result.next()) {
                    rows.add(new ProductionLineOption(
                            result.getLong("line_id"),
                            result.getLong("plant_id"),
                            result.getLong("organization_id"),
                            result.getString("line_code"),
                            result.getString("line_name"),
                            result.getBoolean("is_active")));
                }
                return List.copyOf(rows);
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to list production lines", ex);
        }
    }

    @Override
    public Optional<ProductionLineOption> findLineById(long id) {
        String sql = """
                SELECT
                    l.line_id, l.plant_id, p.organization_id,
                    l.line_code, l.line_name, l.is_active
                FROM core.production_line l
                JOIN core.plant p ON p.plant_id = l.plant_id
                WHERE l.line_id = ?
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) return Optional.empty();
                return Optional.of(new ProductionLineOption(
                        result.getLong("line_id"),
                        result.getLong("plant_id"),
                        result.getLong("organization_id"),
                        result.getString("line_code"),
                        result.getString("line_name"),
                        result.getBoolean("is_active")));
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to query production line", ex);
        }
    }

    @Override
    public List<ContainerUomOption> findContainerUoms(Long plantId, String level, Boolean active) {
        StringBuilder sql = new StringBuilder("""
                SELECT
                    container_uom_id, plant_id, code, display_name,
                    container_level, is_active, source_type
                FROM packaging.container_uom
                """);
        List<Object> parameters = new ArrayList<>();
        List<String> filters = new ArrayList<>();
        if (plantId != null) {
            filters.add("plant_id = ?");
            parameters.add(plantId);
        }
        if (level != null && !level.isBlank()) {
            filters.add("container_level = ?");
            parameters.add(level.trim().toUpperCase());
        }
        if (active != null) {
            filters.add("is_active = ?");
            parameters.add(active);
        }
        if (!filters.isEmpty()) sql.append(" WHERE ").append(String.join(" AND ", filters));
        sql.append(" ORDER BY display_name");

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            bind(statement, parameters);
            try (ResultSet result = statement.executeQuery()) {
                List<ContainerUomOption> rows = new ArrayList<>();
                while (result.next()) rows.add(containerUom(result));
                return List.copyOf(rows);
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to list container UOMs", ex);
        }
    }

    @Override
    public Optional<ContainerUomOption> findContainerUomById(long id) {
        String sql = """
                SELECT
                    container_uom_id, plant_id, code, display_name,
                    container_level, is_active, source_type
                FROM packaging.container_uom
                WHERE container_uom_id = ?
                """;
        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(containerUom(result)) : Optional.empty();
            }
        } catch (SQLException ex) {
            throw new IllegalStateException("Failed to query container UOM", ex);
        }
    }

    private ProductSummary mapProductSummary(Connection connection, ResultSet result) throws SQLException {
        long productId = result.getLong("product_id");
        return new ProductSummary(
                productId,
                result.getLong("organization_id"),
                result.getString("oracle_item_code"),
                result.getString("erp_name"),
                result.getString("product_name"),
                result.getString("completion_subinventory"),
                result.getLong("base_dough_id"),
                result.getString("dough_code"),
                result.getString("dough_name"),
                result.getBoolean("is_default_item"),
                result.getBoolean("is_semi_finished"),
                result.getString("semi_finished_uom"),
                result.getBoolean("has_lid_design_waste"),
                result.getBigDecimal("lid_design_waste_weight_kg"),
                result.getBoolean("has_edge_design_waste"),
                result.getBigDecimal("edge_design_waste_weight_kg"),
                result.getBoolean("is_active"),
                loadLineSummaries(connection, productId),
                instant(result, "created_at"),
                instant(result, "updated_at"));
    }

    private List<ProductLineSummary> loadLineSummaries(Connection connection, long productId)
            throws SQLException {
        String sql = """
                SELECT
                    lpc.line_id, pl.plant_id, pl.line_code, pl.line_name,
                    lpc.integration_item_code, lpc.hourly_production_rate,
                    lpc.primary_uom_id, pu.code AS primary_uom_code,
                    pu.display_name AS primary_uom_name,
                    lpc.packages_per_uom, lpc.pieces_per_package,
                    lpc.secondary_uom_id, su.code AS secondary_uom_code,
                    su.display_name AS secondary_uom_name,
                    lpc.uoms_per_secondary_container,
                    lpc.target_weight_package_kg,
                    lpc.is_active
                FROM packaging.line_product_configuration lpc
                JOIN core.production_line pl ON pl.line_id = lpc.line_id
                JOIN packaging.container_uom pu ON pu.container_uom_id = lpc.primary_uom_id
                LEFT JOIN packaging.container_uom su ON su.container_uom_id = lpc.secondary_uom_id
                WHERE lpc.product_id = ?
                ORDER BY pl.line_name, pl.line_id
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, productId);
            try (ResultSet result = statement.executeQuery()) {
                List<ProductLineSummary> rows = new ArrayList<>();
                while (result.next()) {
                    BigDecimal packages = result.getBigDecimal("packages_per_uom");
                    BigDecimal piecesPerPackage = result.getBigDecimal("pieces_per_package");
                    BigDecimal primaryPieces = packages.multiply(piecesPerPackage);
                    BigDecimal uomsPerSecondary = result.getBigDecimal("uoms_per_secondary_container");
                    BigDecimal packagesSecondary = uomsPerSecondary == null
                            ? null : packages.multiply(uomsPerSecondary);
                    BigDecimal piecesSecondary = packagesSecondary == null
                            ? null : packagesSecondary.multiply(piecesPerPackage);
                    BigDecimal kg = result.getBigDecimal("target_weight_package_kg");
                    BigDecimal grams = kg == null ? null : kg.multiply(BigDecimal.valueOf(1000));
                    rows.add(new ProductLineSummary(
                            result.getLong("line_id"),
                            result.getLong("plant_id"),
                            result.getString("line_code"),
                            result.getString("line_name"),
                            result.getString("integration_item_code"),
                            result.getBigDecimal("hourly_production_rate"),
                            result.getLong("primary_uom_id"),
                            result.getString("primary_uom_code"),
                            result.getString("primary_uom_name"),
                            packages,
                            piecesPerPackage,
                            primaryPieces,
                            nullableLong(result, "secondary_uom_id"),
                            result.getString("secondary_uom_code"),
                            result.getString("secondary_uom_name"),
                            uomsPerSecondary,
                            packagesSecondary,
                            piecesSecondary,
                            kg,
                            grams,
                            result.getBoolean("is_active")));
                }
                return List.copyOf(rows);
            }
        }
    }

    private DoughOption dough(ResultSet result) throws SQLException {
        return new DoughOption(
                result.getLong("dough_id"),
                result.getLong("organization_id"),
                result.getString("dough_code"),
                result.getString("dough_name"),
                result.getBoolean("is_active"));
    }

    private ContainerUomOption containerUom(ResultSet result) throws SQLException {
        return new ContainerUomOption(
                result.getLong("container_uom_id"),
                result.getLong("plant_id"),
                result.getString("code"),
                result.getString("display_name"),
                result.getString("container_level"),
                result.getBoolean("is_active"),
                result.getString("source_type"));
    }

    private void bind(PreparedStatement statement, List<Object> parameters) throws SQLException {
        for (int i = 0; i < parameters.size(); i++) {
            statement.setObject(i + 1, parameters.get(i));
        }
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
