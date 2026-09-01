package com.gbc.access.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gbc.access.model.Organization;
import com.gbc.access.model.Plant;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class LakebaseDataApiClient {

    private final HttpClient client = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();
    private final DatabricksTokenProvider tokenProvider;

    public LakebaseDataApiClient(DatabricksTokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    public List<Organization> getOrganizations(String tenantId, String objectId) {
        String query =
                "select=" + encode("organization_id,organization_code,organization_name")
                        + "&entra_tenant_id=" + encode("eq." + tenantId)
                        + "&entra_object_id=" + encode("eq." + objectId)
                        + "&order=" + encode("organization_name.asc");

        List<Map<String, Object>> rows = get("v_user_organizations", query);
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

        List<Map<String, Object>> rows = get("v_user_plants", query);
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

    public void healthCheck() {
        get("v_user_organizations", "select=organization_id&limit=1");
    }

    private List<Map<String, Object>> get(String resource, String query) {
        try {
            String baseUrl = required("LAKEBASE_DATA_API_URL").replaceAll("/$", "");
            String schema = System.getenv().getOrDefault("LAKEBASE_SCHEMA", "gb_access");

            String url = baseUrl + "/" + schema + "/" + resource + "?" + query;

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Authorization", "Bearer " + tokenProvider.getToken())
                    .header("Accept", "application/json")
                    .GET()
                    .build();

            HttpResponse<String> response = client.send(
                    request,
                    HttpResponse.BodyHandlers.ofString()
            );

            if (response.statusCode() / 100 != 2) {
                throw new IllegalStateException(
                        "Lakebase Data API failed: " + response.statusCode() + " " + response.body()
                );
            }

            return mapper.readValue(
                    response.body(),
                    new TypeReference<List<Map<String, Object>>>() {}
            );
        } catch (Exception ex) {
            throw new IllegalStateException("Unable to query Lakebase Data API", ex);
        }
    }

    private String stringValue(Map<String, Object> row, String key) {
        Object value = row.get(key);
        return value == null ? null : value.toString();
    }

    private String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }

    private String required(String name) {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException(name + " is not configured");
        }
        return value;
    }
}
