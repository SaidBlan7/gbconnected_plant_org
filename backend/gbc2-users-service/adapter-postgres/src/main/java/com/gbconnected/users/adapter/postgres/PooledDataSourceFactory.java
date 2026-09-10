package com.gbconnected.users.adapter.postgres;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.util.Map;
import javax.sql.DataSource;

public final class PooledDataSourceFactory {
    private PooledDataSourceFactory() {
    }

    public static HikariDataSource createPasswordDataSource(DatabaseSettings settings) {
        if (settings.jdbcUrl() == null || settings.username() == null || settings.password() == null) {
            throw new IllegalStateException("JDBC_URL, DB_USER and DB_PASSWORD are required for postgres-password mode");
        }
        HikariConfig config = baseConfig(settings);
        config.setJdbcUrl(settings.jdbcUrl());
        config.setUsername(settings.username());
        config.setPassword(settings.password());
        return new HikariDataSource(config);
    }

    public static HikariDataSource createLakebaseOAuthDataSource(DatabaseSettings settings, Map<String, String> env) {
        DataSource tokenDataSource = LakebaseOAuthDataSource.from(env);
        HikariConfig config = baseConfig(settings);
        config.setDataSource(tokenDataSource);
        config.setMaxLifetime(45L * 60L * 1000L);
        config.setIdleTimeout(15L * 60L * 1000L);
        return new HikariDataSource(config);
    }

    private static HikariConfig baseConfig(DatabaseSettings settings) {
        HikariConfig config = new HikariConfig();
        config.setPoolName("gbc2-users-db");
        config.setMaximumPoolSize(settings.maximumPoolSize());
        config.setMinimumIdle(settings.minimumIdle());
        config.setConnectionTimeout(10_000L);
        config.setValidationTimeout(5_000L);
        config.setLeakDetectionThreshold(0L);
        return config;
    }
}
