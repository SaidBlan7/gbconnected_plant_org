package com.gbc.access.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gbc.access.model.CoreOrganization;
import com.gbc.access.model.Organization;
import com.gbc.access.model.Plant;
import com.gbc.access.model.PlantCreateRequest;
import com.gbc.access.model.PlantDetails;
import com.gbc.access.model.PlantUpdateRequest;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class LakebaseDataApiClient {

    private static final TypeReference<List<Map<String, Object>>> ROW_LIST = new TypeReference<>() {};

    private static final String PLANT_SELECT = String.join(",",
            "plant_id",
            "organization_id",
            "plant_code",
            "plant_name",
            "country",
            "plant_address",
            "plant_timezone",
            "plant_latitude",
            "plant_longitude",
            "plant_state",
            "plant_municipality",
            "is_active",
            "source_system",
            "created_at",
            "updated_at",
            "created_by",
            "updated_by"
    );

    private static final String ORGANIZATION_SELECT = String.join(",",
            "organization_id",
            "organization_code",
            "organization_name",
            "country_code",
            "is_active",
            "source_system"
    );

    private final HttpClient client = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();
    private final DatabricksTokenProvider tokenProvider;

    public LakebaseDataApiClient(DatabricksTokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    // ---------------------------------------------------------------------
    // Existing access API. It intentionally keeps using the app_api views.
    // It will work when app_api is exposed in Data API and permissions exist.
    // ---------------------------------------------------------------------

    public List<Organization> getOrganizations(String tenantId, String objectId) {
        String query =
                "select=" + encode("organization_id,organization_code,organization_name")
                        + "&entra_tenant_id=" + encode("eq." + tenantId)
                        + "&entra_object_id=" + encode("eq." + objectId)
                        + "&order=" + encode("organization_name.asc");

        List<Map<String, Object>> rows = get(accessSchema(), "v_user_organizations", query);
        List<Organization> result = new ArrayList<>();

        for (Map<String, Object> row : rows) {
            result.add(new Organization(
                    stringValue(row, "organization_id"),
                    stringValue(row, "organization_code"),
                    stringValue(row, "organization_name")
            ));
        }
        return result;
    }

    public List<Plant> getPlants(String tenantId, String objectId, String organizationId) {
        String query =
                "select=" + encode("plant_id,plant_code,plant_name")
                        + "&entra_tenant_id=" + encode("eq." + tenantId)
                        + "&entra_object_id=" + encode("eq." + objectId)
                        + "&organization_id=" + encode("eq." + organizationId)
                        + "&order=" + encode("plant_name.asc");

        List<Map<String, Object>> rows = get(accessSchema(), "v_user_plants", query);
        List<Plant> result = new ArrayList<>();

        for (Map<String, Object> row : rows) {
            result.add(new Plant(
                    stringValue(row, "plant_id"),
                    stringValue(row, "plant_code"),
                    stringValue(row, "plant_name")
            ));
        }
        return result;
    }

    // ---------------------------------------------------------------------
    // Direct core access. These endpoints only require core to be exposed.
    // ---------------------------------------------------------------------

    public List<CoreOrganization> listCoreOrganizations(Boolean active) {
        StringBuilder query = new StringBuilder("select=")
                .append(encode(ORGANIZATION_SELECT));

        if (active != null) {
            query.append("&is_active=").append(encode("eq." + active));
        }
        query.append("&order=").append(encode("organization_name.asc"));

        return get(coreSchema(), "organization", query.toString())
                .stream()
                .map(this::toCoreOrganization)
                .toList();
    }

    public Optional<CoreOrganization> getCoreOrganization(long organizationId) {
        String query = "select=" + encode(ORGANIZATION_SELECT)
                + "&organization_id=" + encode("eq." + organizationId)
                + "&limit=1";

        return get(coreSchema(), "organization", query)
                .stream()
                .findFirst()
                .map(this::toCoreOrganization);
    }

    public List<PlantDetails> listCorePlants(Long organizationId, Boolean active) {
        StringBuilder query = new StringBuilder("select=")
                .append(encode(PLANT_SELECT));

        if (organizationId != null) {
            query.append("&organization_id=").append(encode("eq." + organizationId));
        }
        if (active != null) {
            query.append("&is_active=").append(encode("eq." + active));
        }
        query.append("&order=").append(encode("plant_name.asc"));

        return get(coreSchema(), "plant", query.toString())
                .stream()
                .map(this::toPlantDetails)
                .toList();
    }

    public Optional<PlantDetails> getCorePlant(long plantId) {
        String query = "select=" + encode(PLANT_SELECT)
                + "&plant_id=" + encode("eq." + plantId)
                + "&limit=1";

        return get(coreSchema(), "plant", query)
                .stream()
                .findFirst()
                .map(this::toPlantDetails);
    }

    public PlantDetails createCorePlant(PlantCreateRequest request, String auditUser) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("organization_id", request.organizationId());
        body.put("plant_code", request.plantCode());
        body.put("plant_name", request.plantName());
        body.put("country", request.country());
        putIfNotNull(body, "plant_address", request.plantAddress());
        putIfNotNull(body, "plant_timezone", request.plantTimezone());
        putIfNotNull(body, "plant_latitude", request.plantLatitude());
        putIfNotNull(body, "plant_longitude", request.plantLongitude());
        putIfNotNull(body, "plant_state", request.plantState());
        putIfNotNull(body, "plant_municipality", request.plantMunicipality());
        putIfNotNull(body, "is_active", request.active());
        putIfNotNull(body, "source_system", request.sourceSystem());
        body.put("created_by", auditUser);
        body.put("updated_by", auditUser);

        List<Map<String, Object>> rows = write(
                "POST",
                coreSchema(),
                "plant",
                null,
                body,
                true
        );

        if (!rows.isEmpty()) {
            return toPlantDetails(rows.getFirst());
        }

        // Defensive fallback in case the Data API is configured to suppress bodies.
        return findPlantByCode(request.plantCode())
                .orElseThrow(() -> new IllegalStateException("Plant was created but could not be reloaded"));
    }

    /** Partial update: only non-null properties are modified. */
    public Optional<PlantDetails> patchCorePlant(long plantId, PlantUpdateRequest request, String auditUser) {
        Map<String, Object> body = new LinkedHashMap<>();
        putIfNotNull(body, "organization_id", request.organizationId());
        putIfNotNull(body, "plant_code", request.plantCode());
        putIfNotNull(body, "plant_name", request.plantName());
        putIfNotNull(body, "country", request.country());
        putIfNotNull(body, "plant_address", request.plantAddress());
        putIfNotNull(body, "plant_timezone", request.plantTimezone());
        putIfNotNull(body, "plant_latitude", request.plantLatitude());
        putIfNotNull(body, "plant_longitude", request.plantLongitude());
        putIfNotNull(body, "plant_state", request.plantState());
        putIfNotNull(body, "plant_municipality", request.plantMunicipality());
        putIfNotNull(body, "is_active", request.active());
        putIfNotNull(body, "source_system", request.sourceSystem());

        if (body.isEmpty()) {
            return getCorePlant(plantId);
        }

        body.put("updated_at", Instant.now().toString());
        body.put("updated_by", auditUser);

        String query = "plant_id=" + encode("eq." + plantId);
        List<Map<String, Object>> rows = write(
                "PATCH",
                coreSchema(),
                "plant",
                query,
                body,
                true
        );

        if (!rows.isEmpty()) {
            return Optional.of(toPlantDetails(rows.getFirst()));
        }
        return getCorePlant(plantId);
    }

    /**
     * Full replacement of mutable plant fields. Nullable optional values are
     * deliberately sent as null so they can be cleared.
     */
    public Optional<PlantDetails> replaceCorePlant(long plantId, PlantCreateRequest request, String auditUser) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("organization_id", request.organizationId());
        body.put("plant_code", request.plantCode());
        body.put("plant_name", request.plantName());
        body.put("country", request.country());
        body.put("plant_address", request.plantAddress());
        body.put("plant_timezone", request.plantTimezone());
        body.put("plant_latitude", request.plantLatitude());
        body.put("plant_longitude", request.plantLongitude());
        body.put("plant_state", request.plantState());
        body.put("plant_municipality", request.plantMunicipality());
        body.put("is_active", request.active() == null ? Boolean.TRUE : request.active());
        body.put("source_system", request.sourceSystem() == null || request.sourceSystem().isBlank()
                ? "GBC_CONFIGURADOR"
                : request.sourceSystem());
        body.put("updated_at", Instant.now().toString());
        body.put("updated_by", auditUser);

        String query = "plant_id=" + encode("eq." + plantId);
        List<Map<String, Object>> rows = write(
                "PATCH",
                coreSchema(),
                "plant",
                query,
                body,
                true
        );

        if (!rows.isEmpty()) {
            return Optional.of(toPlantDetails(rows.getFirst()));
        }
        return getCorePlant(plantId);
    }

    public boolean deleteCorePlant(long plantId) {
        if (getCorePlant(plantId).isEmpty()) {
            return false;
        }

        String query = "plant_id=" + encode("eq." + plantId);
        write("DELETE", coreSchema(), "plant", query, null, false);
        return true;
    }

    public void healthCheckCore() {
        get(coreSchema(), "organization", "select=organization_id&limit=1");
    }

    // ---------------------------------------------------------------------
    // HTTP helpers
    // ---------------------------------------------------------------------

    private Optional<PlantDetails> findPlantByCode(String plantCode) {
        String query = "select=" + encode(PLANT_SELECT)
                + "&plant_code=" + encode("eq." + plantCode)
                + "&limit=1";
        return get(coreSchema(), "plant", query)
                .stream()
                .findFirst()
                .map(this::toPlantDetails);
    }

    private List<Map<String, Object>> get(String schema, String resource, String query) {
        String url = resourceUrl(schema, resource, query);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Authorization", "Bearer " + tokenProvider.getToken())
                .header("Accept", "application/json")
                .GET()
                .build();

        HttpResponse<String> response = send(request);
        ensureSuccess(response);
        return readRows(response.body());
    }

    private List<Map<String, Object>> write(
            String method,
            String schema,
            String resource,
            String query,
            Map<String, Object> body,
            boolean returnRepresentation
    ) {
        try {
            String url = resourceUrl(schema, resource, query);
            HttpRequest.Builder builder = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Authorization", "Bearer " + tokenProvider.getToken())
                    .header("Accept", "application/json");

            if (returnRepresentation) {
                builder.header("Prefer", "return=representation");
            }

            if (body != null) {
                String json = mapper.writeValueAsString(body);
                builder.header("Content-Type", "application/json")
                        .method(method, HttpRequest.BodyPublishers.ofString(json));
            } else {
                builder.method(method, HttpRequest.BodyPublishers.noBody());
            }

            HttpResponse<String> response = send(builder.build());
            ensureSuccess(response);
            return readRows(response.body());
        } catch (JsonProcessingException ex) {
            throw new LakebaseDataApiException("Unable to serialize Lakebase Data API request", ex);
        }
    }

    private HttpResponse<String> send(HttpRequest request) {
        try {
            return client.send(request, HttpResponse.BodyHandlers.ofString());
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
            throw new LakebaseDataApiException("Lakebase Data API request was interrupted", ex);
        } catch (Exception ex) {
            throw new LakebaseDataApiException("Unable to call Lakebase Data API", ex);
        }
    }

    private void ensureSuccess(HttpResponse<String> response) {
        if (response.statusCode() / 100 != 2) {
            throw new LakebaseDataApiException(response.statusCode(), response.body());
        }
    }

    private List<Map<String, Object>> readRows(String body) {
        if (body == null || body.isBlank()) {
            return List.of();
        }
        try {
            return mapper.readValue(body, ROW_LIST);
        } catch (JsonProcessingException ex) {
            throw new LakebaseDataApiException("Unable to parse Lakebase Data API response", ex);
        }
    }

    private String resourceUrl(String schema, String resource, String query) {
        String url = dataApiBaseUrl() + "/" + schema + "/" + resource;
        if (query != null && !query.isBlank()) {
            url += "?" + query;
        }
        return url;
    }

    private String dataApiBaseUrl() {
        String configured = System.getenv("LAKEBASE_DATA_API_URL");
        if (isUsableUrl(configured)) {
            return configured.replaceAll("/$", "");
        }

        // Convenient for the local PowerShell flow already used with curl.
        String restEndpoint = System.getenv("REST_ENDPOINT");
        if (isUsableUrl(restEndpoint)) {
            return restEndpoint.replaceAll("/$", "");
        }

        throw new IllegalStateException(
                "LAKEBASE_DATA_API_URL (or REST_ENDPOINT for local development) is not configured"
        );
    }

    private boolean isUsableUrl(String value) {
        if (value == null || value.isBlank()) {
            return false;
        }
        String upper = value.toUpperCase();
        return (value.startsWith("https://") || value.startsWith("http://"))
                && !upper.contains("REEMPLAZAR")
                && !upper.contains("TU-WORKSPACE")
                && !upper.contains("API-URL");
    }

    private String coreSchema() {
        return System.getenv().getOrDefault("LAKEBASE_CORE_SCHEMA", "core");
    }

    private String accessSchema() {
        return System.getenv().getOrDefault("LAKEBASE_ACCESS_SCHEMA", "app_api");
    }

    private CoreOrganization toCoreOrganization(Map<String, Object> row) {
        return new CoreOrganization(
                longValue(row, "organization_id"),
                stringValue(row, "organization_code"),
                stringValue(row, "organization_name"),
                stringValue(row, "country_code"),
                booleanValue(row, "is_active"),
                stringValue(row, "source_system")
        );
    }

    private PlantDetails toPlantDetails(Map<String, Object> row) {
        return new PlantDetails(
                longValue(row, "plant_id"),
                longValue(row, "organization_id"),
                stringValue(row, "plant_code"),
                stringValue(row, "plant_name"),
                stringValue(row, "country"),
                stringValue(row, "plant_address"),
                stringValue(row, "plant_timezone"),
                decimalValue(row, "plant_latitude"),
                decimalValue(row, "plant_longitude"),
                stringValue(row, "plant_state"),
                stringValue(row, "plant_municipality"),
                booleanValue(row, "is_active"),
                stringValue(row, "source_system"),
                instantValue(row, "created_at"),
                instantValue(row, "updated_at"),
                stringValue(row, "created_by"),
                stringValue(row, "updated_by")
        );
    }

    private void putIfNotNull(Map<String, Object> target, String key, Object value) {
        if (value != null) {
            target.put(key, value);
        }
    }

    private String stringValue(Map<String, Object> row, String key) {
        Object value = row.get(key);
        return value == null ? null : value.toString();
    }

    private Long longValue(Map<String, Object> row, String key) {
        Object value = row.get(key);
        if (value == null) {
            return null;
        }
        if (value instanceof Number number) {
            return number.longValue();
        }
        return Long.valueOf(value.toString());
    }

    private Boolean booleanValue(Map<String, Object> row, String key) {
        Object value = row.get(key);
        if (value == null) {
            return null;
        }
        if (value instanceof Boolean bool) {
            return bool;
        }
        return Boolean.valueOf(value.toString());
    }

    private BigDecimal decimalValue(Map<String, Object> row, String key) {
        Object value = row.get(key);
        if (value == null) {
            return null;
        }
        if (value instanceof BigDecimal decimal) {
            return decimal;
        }
        return new BigDecimal(value.toString());
    }

    private Instant instantValue(Map<String, Object> row, String key) {
        String value = stringValue(row, key);
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return Instant.parse(value);
        } catch (Exception ignored) {
            return OffsetDateTime.parse(value).toInstant();
        }
    }

    private String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }
}
