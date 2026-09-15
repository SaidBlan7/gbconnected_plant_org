package com.gbconnected.catalogs.application.command;

public record RejectedProductAudit(
        Long productId,
        long organizationId,
        Long lineId,
        String itemCode,
        String eventType,
        String validationCode,
        String message,
        AuditContext audit
) {}
