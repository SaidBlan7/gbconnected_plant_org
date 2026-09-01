package com.gbc.access.security;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gbc.access.model.CallerIdentity;
import com.microsoft.azure.functions.HttpRequestMessage;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;

@Service
public class CallerIdentityResolver {

    private final ObjectMapper mapper = new ObjectMapper();

    public CallerIdentity resolve(HttpRequestMessage<?> request) {
        String authMode = System.getenv().getOrDefault("AUTH_MODE", "entra");

        if ("mock".equalsIgnoreCase(authMode)) {
            return resolveMock();
        }

        return resolveEntra(request);
    }

    private CallerIdentity resolveMock() {
        return new CallerIdentity(
                requiredEnv("DEV_TENANT_ID"),
                requiredEnv("DEV_USER_OID"),
                System.getenv().getOrDefault("DEV_USER_EMAIL", "local@demo.com"),
                "Local Developer"
        );
    }

    private CallerIdentity resolveEntra(HttpRequestMessage<?> request) {
        Map<String, String> headers = request.getHeaders();
        String encoded = findHeader(headers, "x-ms-client-principal");

        if (encoded == null || encoded.isBlank()) {
            throw new SecurityException("Missing X-MS-CLIENT-PRINCIPAL. Verify Function App Authentication / Easy Auth.");
        }

        try {
            String json = new String(
                    Base64.getDecoder().decode(encoded),
                    StandardCharsets.UTF_8
            );

            JsonNode principal = mapper.readTree(json);
            JsonNode claims = principal.path("claims");

            String oid = findClaim(
                    claims,
                    "oid",
                    "http://schemas.microsoft.com/identity/claims/objectidentifier"
            );

            String tid = findClaim(
                    claims,
                    "tid",
                    "http://schemas.microsoft.com/identity/claims/tenantid"
            );

            String email = findClaim(
                    claims,
                    "preferred_username",
                    "email",
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
            );

            String name = findClaim(
                    claims,
                    "name",
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
            );

            if (oid == null || tid == null) {
                throw new SecurityException("Entra identity is missing oid/tid claims.");
            }

            return new CallerIdentity(tid, oid, email, name);
        } catch (SecurityException ex) {
            throw ex;
        } catch (Exception ex) {
            throw new SecurityException("Invalid X-MS-CLIENT-PRINCIPAL", ex);
        }
    }

    private String findHeader(Map<String, String> headers, String name) {
        return headers.entrySet().stream()
                .filter(entry -> entry.getKey().equalsIgnoreCase(name))
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse(null);
    }

    private String findClaim(JsonNode claims, String... names) {
        if (!claims.isArray()) {
            return null;
        }

        for (JsonNode claim : claims) {
            String type = claim.path("typ").asText();
            for (String name : names) {
                if (name.equals(type)) {
                    return claim.path("val").asText(null);
                }
            }
        }
        return null;
    }

    private String requiredEnv(String name) {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException(name + " is not configured");
        }
        return value;
    }
}
