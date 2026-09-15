package com.gbconnected.catalogs.application.command;

public record AuditContext(
        String sourceType,
        String actor,
        String correlationId
) {
    public AuditContext {
        sourceType = normalizeSource(sourceType);
        actor = actor == null || actor.isBlank() ? "SYSTEM" : actor.trim();
        correlationId = correlationId == null || correlationId.isBlank() ? null : correlationId.trim();
    }

    public static AuditContext manual(String actor, String correlationId) {
        return new AuditContext("MANUAL", actor, correlationId);
    }

    private static String normalizeSource(String value) {
        String source = value == null || value.isBlank() ? "MANUAL" : value.trim().toUpperCase();
        return switch (source) {
            case "MANUAL", "ORACLE", "WMS", "BULK_LOAD", "SYSTEM" -> source;
            default -> throw new IllegalArgumentException("Unsupported sourceType: " + source);
        };
    }
}
