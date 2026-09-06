package com.gbc.access.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Base64;

@Service
public class DatabricksTokenProvider {

    private final HttpClient client = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();

    private String cachedToken;
    private Instant expiresAt = Instant.EPOCH;

    /**
     * Local development:
     *   - DATABRICKS_OAUTH_TOKEN, or
     *   - DBX_OAUTH_TOKEN (same name used by the Databricks CLI examples)
     *
     * Production:
     *   - if there is no manual token, falls back to Databricks M2M OAuth
     *     using DATABRICKS_HOST + DATABRICKS_CLIENT_ID + DATABRICKS_CLIENT_SECRET.
     */
    public synchronized String getToken() {
        String manualToken = firstNonBlank(
                System.getenv("DATABRICKS_OAUTH_TOKEN"),
                System.getenv("DBX_OAUTH_TOKEN")
        );

        if (manualToken != null) {
            return normalizeBearerToken(manualToken);
        }

        if (cachedToken != null && Instant.now().plusSeconds(60).isBefore(expiresAt)) {
            return cachedToken;
        }

        try {
            String host = required("DATABRICKS_HOST").replaceAll("/$", "");
            String clientId = required("DATABRICKS_CLIENT_ID");
            String clientSecret = required("DATABRICKS_CLIENT_SECRET");

            String basic = Base64.getEncoder().encodeToString(
                    (clientId + ":" + clientSecret).getBytes(StandardCharsets.UTF_8)
            );

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(host + "/oidc/v1/token"))
                    .header("Authorization", "Basic " + basic)
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(
                            "grant_type=client_credentials&scope=all-apis"
                    ))
                    .build();

            HttpResponse<String> response = client.send(
                    request,
                    HttpResponse.BodyHandlers.ofString()
            );

            if (response.statusCode() / 100 != 2) {
                throw new IllegalStateException(
                        "Databricks OAuth failed: HTTP " + response.statusCode()
                );
            }

            JsonNode json = mapper.readTree(response.body());
            cachedToken = json.path("access_token").asText();
            long expiresIn = json.path("expires_in").asLong(3600);
            expiresAt = Instant.now().plusSeconds(expiresIn);

            if (cachedToken == null || cachedToken.isBlank()) {
                throw new IllegalStateException("Databricks OAuth response did not include access_token");
            }

            return cachedToken;
        } catch (Exception ex) {
            throw new IllegalStateException("Unable to obtain Databricks OAuth token", ex);
        }
    }

    private String normalizeBearerToken(String token) {
        String normalized = token.trim();
        if (normalized.regionMatches(true, 0, "Bearer ", 0, 7)) {
            normalized = normalized.substring(7).trim();
        }
        if (normalized.isBlank()) {
            throw new IllegalStateException("Configured Databricks OAuth token is empty");
        }
        return normalized;
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value;
            }
        }
        return null;
    }

    private String required(String name) {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException(name + " is not configured");
        }
        return value;
    }
}
