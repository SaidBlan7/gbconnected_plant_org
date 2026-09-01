package com.gbc.access.model;

public record CallerIdentity(
        String tenantId,
        String objectId,
        String email,
        String name
) {}
