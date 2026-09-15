package com.gbconnected.catalogs.application.query;

public record ContainerUomOption(
        long containerUomId,
        long plantId,
        String code,
        String displayName,
        String containerLevel,
        boolean active,
        String sourceType
) {}
