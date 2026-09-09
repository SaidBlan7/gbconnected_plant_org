package com.gbc.access.repository;

import com.gbc.access.model.*;
import com.gbc.access.service.PostgresDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class LakebaseJdbcRepository {

    private static final String PLANT_COLUMNS = """
            plant_id, organization_id, plant_code, plant_name, country,
            plant_address, plant_timezone, plant_latitude, plant_longitude,
            plant_state, plant_municipality, is_active, source_system,
            created_at, updated_at, created_by, updated_by
            """;

    private static final String ORGANIZATION_COLUMNS = """
            organization_id, organization_code, organization_name,
            country_code, is_active, source_system
            """;

    private volatile JdbcTemplate jdbcTemplate;

    private JdbcTemplate jdbc() {
        JdbcTemplate current = jdbcTemplate;
        if (current != null) return current;

        synchronized (this) {
            if (jdbcTemplate == null) {
                String url = env("LAKEBASE_JDBC_URL");
                if (blank(url)) {
                    String host = required("LAKEBASE_DB_HOST").trim();
                    host = host.replaceFirst("^https?://", "").replaceAll("/+$", "");
                    String port = defaultValue(env("LAKEBASE_DB_PORT"), "5432");
                    String database = required("LAKEBASE_DB_NAME");
                    String sslMode = defaultValue(env("LAKEBASE_SSLMODE"), "require");
                    url = "jdbc:postgresql://" + host + ":" + port + "/" + database + "?sslmode=" + sslMode;
                }

                String user = required("LAKEBASE_DB_USER");
                String password = firstNonBlank(env("LAKEBASE_DB_PASSWORD"), env("LAKEBASE_DB_TOKEN"));
                if (blank(password)) {
                    throw new IllegalStateException(
                            "Missing database credential. Set LAKEBASE_DB_PASSWORD or LAKEBASE_DB_TOKEN."
                    );
                }

                DriverManagerDataSource dataSource = new DriverManagerDataSource();
                dataSource.setDriverClassName("org.postgresql.Driver");
                dataSource.setUrl(url);
                dataSource.setUsername(user);
                dataSource.setPassword(password);
                jdbcTemplate = new JdbcTemplate(dataSource);
            }
            return jdbcTemplate;
        }
    }

    // ---------------------------------------------------------------------
    // API original: usuario -> organizaciones -> plantas.
    // En mock no toca PostgreSQL. Si ACCESS_MODE=postgres, usa las vistas
    // ya diseñadas app_api.v_user_organizations / app_api.v_user_plants.
    // ---------------------------------------------------------------------

    public List<Organization> getUserOrganizations(String tenantId, String objectId) {
        String schema = accessSchema();
        String sql = """
                SELECT organization_id::text AS id,
                       organization_code AS code,
                       organization_name AS name
                FROM %s.v_user_organizations
                WHERE entra_tenant_id = ?::uuid
                  AND entra_object_id = ?::uuid
                ORDER BY organization_name
                """.formatted(quoteIdentifier(schema));

        return query(sql, (rs, rowNum) -> new Organization(
                rs.getString("id"), rs.getString("code"), rs.getString("name")
        ), tenantId, objectId);
    }

    public List<Plant> getUserPlants(String tenantId, String objectId, String organizationId) {
        long orgId;
        try {
            orgId = Long.parseLong(organizationId);
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException("organizationId must be numeric in postgres mode");
        }

        String schema = accessSchema();
        String sql = """
                SELECT plant_id::text AS id,
                       plant_code AS code,
                       plant_name AS name
                FROM %s.v_user_plants
                WHERE entra_tenant_id = ?::uuid
                  AND entra_object_id = ?::uuid
                  AND organization_id = ?
                ORDER BY plant_name
                """.formatted(quoteIdentifier(schema));

        return query(sql, (rs, rowNum) -> new Plant(
                rs.getString("id"), rs.getString("code"), rs.getString("name")
        ), tenantId, objectId, orgId);
    }

    // ---------------------------------------------------------------------
    // CORE - organizaciones / plantas reales.
    // ---------------------------------------------------------------------

    public List<CoreOrganization> listOrganizations(Boolean active) {
        StringBuilder sql = new StringBuilder("SELECT ").append(ORGANIZATION_COLUMNS)
                .append(" FROM ").append(coreSchemaQuoted()).append(".organization");
        List<Object> args = new ArrayList<>();
        if (active != null) {
            sql.append(" WHERE is_active = ?");
            args.add(active);
        }
        sql.append(" ORDER BY organization_name");
        return query(sql.toString(), this::mapOrganization, args.toArray());
    }

    public Optional<CoreOrganization> getOrganization(long id) {
        String sql = "SELECT " + ORGANIZATION_COLUMNS + " FROM " + coreSchemaQuoted()
                + ".organization WHERE organization_id = ?";
        return query(sql, this::mapOrganization, id).stream().findFirst();
    }

    public List<PlantDetails> listPlants(Long organizationId, Boolean active) {
        StringBuilder sql = new StringBuilder("SELECT ").append(PLANT_COLUMNS)
                .append(" FROM ").append(coreSchemaQuoted()).append(".plant WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (organizationId != null) {
            sql.append(" AND organization_id = ?");
            args.add(organizationId);
        }
        if (active != null) {
            sql.append(" AND is_active = ?");
            args.add(active);
        }
        sql.append(" ORDER BY plant_name");
        return query(sql.toString(), this::mapPlant, args.toArray());
    }

    public Optional<PlantDetails> getPlant(long id) {
        String sql = "SELECT " + PLANT_COLUMNS + " FROM " + coreSchemaQuoted()
                + ".plant WHERE plant_id = ?";
        return query(sql, this::mapPlant, id).stream().findFirst();
    }

    public PlantDetails createPlant(PlantCreateRequest r, String audit) {
        String sql = """
                INSERT INTO %s.plant (
                    organization_id, plant_code, plant_name, country,
                    plant_address, plant_timezone, plant_latitude, plant_longitude,
                    plant_state, plant_municipality, is_active, source_system,
                    created_by, updated_by
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                RETURNING %s
                """.formatted(coreSchemaQuoted(), PLANT_COLUMNS);

        Boolean active = r.active() == null ? Boolean.TRUE : r.active();
        String sourceSystem = blank(r.sourceSystem()) ? "GBC_CONFIGURADOR" : r.sourceSystem();

        return queryOne(sql, this::mapPlant,
                r.organizationId(), r.plantCode(), r.plantName(), r.country(),
                r.plantAddress(), r.plantTimezone(), r.plantLatitude(), r.plantLongitude(),
                r.plantState(), r.plantMunicipality(), active, sourceSystem, audit, audit
        ).orElseThrow(() -> new IllegalStateException("Plant insert returned no row"));
    }

    public Optional<PlantDetails> patchPlant(long id, PlantUpdateRequest r, String audit) {
        List<String> sets = new ArrayList<>();
        List<Object> args = new ArrayList<>();
        add(sets, args, "organization_id", r.organizationId());
        add(sets, args, "plant_code", r.plantCode());
        add(sets, args, "plant_name", r.plantName());
        add(sets, args, "country", r.country());
        add(sets, args, "plant_address", r.plantAddress());
        add(sets, args, "plant_timezone", r.plantTimezone());
        add(sets, args, "plant_latitude", r.plantLatitude());
        add(sets, args, "plant_longitude", r.plantLongitude());
        add(sets, args, "plant_state", r.plantState());
        add(sets, args, "plant_municipality", r.plantMunicipality());
        add(sets, args, "is_active", r.active());
        add(sets, args, "source_system", r.sourceSystem());

        sets.add("updated_at = CURRENT_TIMESTAMP");
        sets.add("updated_by = ?");
        args.add(audit);
        args.add(id);

        String sql = "UPDATE " + coreSchemaQuoted() + ".plant SET "
                + String.join(", ", sets)
                + " WHERE plant_id = ? RETURNING " + PLANT_COLUMNS;

        return queryOne(sql, this::mapPlant, args.toArray());
    }

    public Optional<PlantDetails> replacePlant(long id, PlantCreateRequest r, String audit) {
        String sql = """
                UPDATE %s.plant SET
                    organization_id = ?,
                    plant_code = ?,
                    plant_name = ?,
                    country = ?,
                    plant_address = ?,
                    plant_timezone = ?,
                    plant_latitude = ?,
                    plant_longitude = ?,
                    plant_state = ?,
                    plant_municipality = ?,
                    is_active = ?,
                    source_system = ?,
                    updated_at = CURRENT_TIMESTAMP,
                    updated_by = ?
                WHERE plant_id = ?
                RETURNING %s
                """.formatted(coreSchemaQuoted(), PLANT_COLUMNS);

        Boolean active = r.active() == null ? Boolean.TRUE : r.active();
        String sourceSystem = blank(r.sourceSystem()) ? "GBC_CONFIGURADOR" : r.sourceSystem();

        return queryOne(sql, this::mapPlant,
                r.organizationId(), r.plantCode(), r.plantName(), r.country(),
                r.plantAddress(), r.plantTimezone(), r.plantLatitude(), r.plantLongitude(),
                r.plantState(), r.plantMunicipality(), active, sourceSystem, audit, id
        );
    }

    public boolean deletePlant(long id) {
        String sql = "DELETE FROM " + coreSchemaQuoted() + ".plant WHERE plant_id = ?";
        return update(sql, id) > 0;
    }

    public void healthCheck() {
        Integer one = queryForObject("SELECT 1", Integer.class);
        if (one == null || one != 1) throw new IllegalStateException("Lakebase JDBC health check failed");
    }

    private CoreOrganization mapOrganization(ResultSet rs, int rowNum) throws SQLException {
        return new CoreOrganization(
                rs.getLong("organization_id"),
                rs.getString("organization_code"),
                rs.getString("organization_name"),
                rs.getString("country_code"),
                rs.getBoolean("is_active"),
                rs.getString("source_system")
        );
    }

    private PlantDetails mapPlant(ResultSet rs, int rowNum) throws SQLException {
        return new PlantDetails(
                rs.getLong("plant_id"),
                rs.getLong("organization_id"),
                rs.getString("plant_code"),
                rs.getString("plant_name"),
                rs.getString("country"),
                rs.getString("plant_address"),
                rs.getString("plant_timezone"),
                rs.getBigDecimal("plant_latitude"),
                rs.getBigDecimal("plant_longitude"),
                rs.getString("plant_state"),
                rs.getString("plant_municipality"),
                rs.getBoolean("is_active"),
                rs.getString("source_system"),
                value(rs, "created_at"),
                value(rs, "updated_at"),
                rs.getString("created_by"),
                rs.getString("updated_by")
        );
    }

    private String value(ResultSet rs, String column) throws SQLException {
        Object value = rs.getObject(column);
        return value == null ? null : value.toString();
    }

    private void add(List<String> sets, List<Object> args, String column, Object value) {
        if (value != null) {
            sets.add(column + " = ?");
            args.add(value);
        }
    }

    private String coreSchemaQuoted() { return quoteIdentifier(defaultValue(env("LAKEBASE_CORE_SCHEMA"), "core")); }
    private String accessSchema() { return defaultValue(env("LAKEBASE_ACCESS_SCHEMA"), "app_api"); }

    private String quoteIdentifier(String value) {
        if (value == null || !value.matches("[A-Za-z_][A-Za-z0-9_]*")) {
            throw new IllegalStateException("Invalid SQL identifier: " + value);
        }
        return '"' + value + '"';
    }

    private String env(String key) { return System.getenv(key); }
    private String required(String key) {
        String value = env(key);
        if (blank(value)) throw new IllegalStateException("Missing environment variable: " + key);
        return value;
    }
    private String defaultValue(String value, String fallback) { return blank(value) ? fallback : value; }
    private String firstNonBlank(String a, String b) { return !blank(a) ? a : b; }
    private boolean blank(String value) { return value == null || value.isBlank(); }

    private <T> List<T> query(String sql, org.springframework.jdbc.core.RowMapper<T> mapper, Object... args) {
        try {
            return jdbc().query(sql, mapper, args);
        } catch (org.springframework.dao.DataAccessException ex) {
            throw PostgresDataAccessException.from(ex);
        }
    }

    private <T> Optional<T> queryOne(String sql, org.springframework.jdbc.core.RowMapper<T> mapper, Object... args) {
        List<T> rows = query(sql, mapper, args);
        return rows.stream().findFirst();
    }

    private int update(String sql, Object... args) {
        try {
            return jdbc().update(sql, args);
        } catch (org.springframework.dao.DataAccessException ex) {
            throw PostgresDataAccessException.from(ex);
        }
    }

    private <T> T queryForObject(String sql, Class<T> type) {
        try {
            return jdbc().queryForObject(sql, type);
        } catch (org.springframework.dao.DataAccessException ex) {
            throw PostgresDataAccessException.from(ex);
        }
    }
}
