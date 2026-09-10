package com.gbconnected.users.application.query;

public record UserPlantSummary(
        long id,
        String code,
        String name,
        long organizationId
) {}