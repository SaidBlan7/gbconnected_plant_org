package com.gbconnected.catalogs.appservice.web;

import jakarta.validation.constraints.*;

public record PlantHttpRequest(
        @NotNull @Positive Long organizationId,
        @NotBlank @Size(max = 50) String plantCode,
        @NotBlank @Size(max = 200) String plantName,
        @Size(max = 100) String erpPlantCode,
        @Size(max = 20) String countryCode,
        @Size(max = 50) String regionCode,
        @Size(max = 500) String address,
        @NotBlank @Size(max = 100) String timezoneName,
        @Size(max = 20) String languageCode,
        Boolean active
) {}