package com.gbc.access.model;

public record CoreOrganization(
        Long organizationId,
        String organizationCode,
        String organizationName,
        String countryCode,
        Boolean active,
        String sourceSystem
) {}
