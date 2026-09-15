package com.gbconnected.catalogs.application.query;

public record DoughOption(
        long doughId,
        long organizationId,
        String doughCode,
        String doughName,
        boolean active
) {}
