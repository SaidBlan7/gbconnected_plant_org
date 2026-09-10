package com.gbconnected.users.functions;

import com.gbconnected.users.domain.UserIdentity;
import com.google.gson.*;
import com.microsoft.azure.functions.HttpRequestMessage;

import java.nio.charset.StandardCharsets;
import java.util.*;

final class FunctionCallerIdentityResolver {

    static UserIdentity resolve(HttpRequestMessage<?> r) {
        if ("mock".equalsIgnoreCase(
                System.getenv().getOrDefault("AUTH_MODE", "entra")
        )) {
            return UserIdentity.of(
                    System.getenv().getOrDefault(
                            "DEV_TENANT_ID",
                            "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
                    ),
                    System.getenv().getOrDefault(
                            "DEV_USER_OID",
                            "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
                    ),
                    System.getenv().getOrDefault(
                            "DEV_USER_EMAIL",
                            "local@demo.com"
                    ),
                    "Local Developer"
            );
        }

        String encoded = r.getHeaders()
                .entrySet()
                .stream()
                .filter(e -> e.getKey().equalsIgnoreCase("x-ms-client-principal"))
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse(null);

        if (encoded == null || encoded.isBlank()) {
            throw new SecurityException("Missing X-MS-CLIENT-PRINCIPAL");
        }

        try {
            JsonObject root = JsonParser.parseString(
                    new String(
                            Base64.getDecoder().decode(encoded),
                            StandardCharsets.UTF_8
                    )
            ).getAsJsonObject();

            String tid = claim(
                    root,
                    "tid",
                    "http://schemas.microsoft.com/identity/claims/tenantid"
            );

            String oid = claim(
                    root,
                    "oid",
                    "http://schemas.microsoft.com/identity/claims/objectidentifier"
            );

            String email = claim(
                    root,
                    "preferred_username",
                    "email",
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
            );

            String name = claim(
                    root,
                    "name",
                    "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
            );

            return UserIdentity.of(
                    tid,
                    oid,
                    email,
                    name
            );

        } catch (SecurityException e) {
            throw e;
        } catch (Exception e) {
            throw new SecurityException(
                    "Invalid X-MS-CLIENT-PRINCIPAL",
                    e
            );
        }
    }

    private static String claim(
            JsonObject root,
            String... names
    ) {
        JsonArray c = root.getAsJsonArray("claims");

        if (c == null) {
            return null;
        }

        for (JsonElement e : c) {
            JsonObject o = e.getAsJsonObject();

            String t = o.has("typ")
                    ? o.get("typ").getAsString()
                    : null;

            for (String n : names) {
                if (n.equals(t)) {
                    return o.has("val")
                            ? o.get("val").getAsString()
                            : null;
                }
            }
        }

        return null;
    }

    private static String req(String k) {
        String v = System.getenv(k);

        if (v == null || v.isBlank()) {
            throw new IllegalStateException(
                    k + " is not configured"
            );
        }

        return v;
    }
}