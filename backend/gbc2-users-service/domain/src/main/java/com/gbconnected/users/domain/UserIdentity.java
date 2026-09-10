package com.gbconnected.users.domain;

import java.util.UUID;

public record UserIdentity(
        UUID tenantId,
        UUID objectId,
        String email,
        String name
) {

    public UserIdentity {
        if (tenantId == null) {
            throw new IllegalArgumentException("tenantId is required");
        }

        if (objectId == null) {
            throw new IllegalArgumentException("objectId is required");
        }
    }

    public static UserIdentity of(
            String tenantId,
            String objectId,
            String email,
            String name
    ) {
        try {
            return new UserIdentity(
                    UUID.fromString(tenantId),
                    UUID.fromString(objectId),
                    email,
                    name
            );
        } catch (Exception e) {
            throw new IllegalArgumentException(
                    "tenantId and objectId must be valid UUIDs",
                    e
            );
        }
    }
}