package com.gbconnected.catalogs.application.command;

public record PatchPlantCommand(
        Long organizationId,
        String plantCode,
        String plantName,
        String erpPlantCode,
        String countryCode,
        String regionCode,
        String address,
        String timezoneName,
        String languageCode,
        Boolean active
) {}