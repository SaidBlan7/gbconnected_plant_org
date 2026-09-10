package com.gbconnected.users.appservice.security;

import com.gbconnected.users.domain.UserIdentity;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Component;

@Component
public class CallerIdentityResolver {

    private final boolean security;

    public CallerIdentityResolver(
            @Value("${gbc.security.enabled:false}") boolean security
    ) {
        this.security = security;
    }

    public UserIdentity resolve(Authentication a) {
        if (!security
                || "mock".equalsIgnoreCase(
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

        if (!(a instanceof JwtAuthenticationToken j)) {
            throw new SecurityException("JWT authentication is required");
        }

        var jwt = j.getToken();

        String tid = jwt.getClaimAsString("tid");
        String oid = jwt.getClaimAsString("oid");
        String email = first(
                jwt.getClaimAsString("preferred_username"),
                jwt.getClaimAsString("email")
        );
        String name = jwt.getClaimAsString("name");

        return UserIdentity.of(
                tid,
                oid,
                email,
                name
        );
    }

    private String required(String k) {
        String v = System.getenv(k);

        if (v == null || v.isBlank()) {
            throw new IllegalStateException(
                    k + " is not configured"
            );
        }

        return v;
    }

    private String first(String a, String b) {
        return a == null || a.isBlank() ? b : a;
    }
}