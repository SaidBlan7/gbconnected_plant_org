package com.gbconnected.catalogs.application.query;

import java.time.Instant;

public record OrganizationSummary(
        long organizationId,
        String organizationCode,
        String organizationName,
        boolean active,
        Instant createdAt,
        Instant updatedAt
) {}