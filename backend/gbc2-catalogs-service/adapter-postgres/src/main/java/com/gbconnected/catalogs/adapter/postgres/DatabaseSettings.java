package com.gbconnected.catalogs.adapter.postgres;

import java.util.Map;

public record DatabaseSettings(
        String mode,
        String jdbcUrl,
        String username,
        String password,
        int maximumPoolSize,
        int minimumIdle) {

    public static DatabaseSettings from(Map<String, String> env) {
        String mode = env.getOrDefault("GBC_PERSISTENCE_MODE", "memory");
        int maxPool = integer(env, "DB_POOL_MAX_SIZE", 10);
        int minIdle = integer(env, "DB_POOL_MIN_IDLE", 0);
        return new DatabaseSettings(
                mode,
                env.get("JDBC_URL"),
                env.get("DB_USER"),
                env.get("DB_PASSWORD"),
                maxPool,
                minIdle);
    }

    private static int integer(Map<String, String> env, String key, int defaultValue) {
        String raw = env.get(key);
        if (raw == null || raw.isBlank()) return defaultValue;
        return Integer.parseInt(raw);
    }

    static String required(Map<String, String> env, String key) {
        String value = env.get(key);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException("Missing required environment variable: " + key);
        }
        return value;
    }
}
