package com.gbconnected.users.bootstrap;

import com.gbconnected.users.adapter.memory.InMemoryUserAccessQueryAdapter;
import com.gbconnected.users.adapter.postgres.*;
import com.gbconnected.users.application.port.out.*;
import com.gbconnected.users.application.query.UserAccessQueryService;
import com.zaxxer.hikari.HikariDataSource;

import java.util.Map;

public final class MicroserviceRuntime implements AutoCloseable {

    private final UserAccessQueryService access;
    private final DatabaseHealthPort health;
    private final AutoCloseable closeable;

    private MicroserviceRuntime(
            UserAccessQueryService a,
            DatabaseHealthPort h,
            AutoCloseable c
    ) {
        access = a;
        health = h;
        closeable = c;
    }

    public static MicroserviceRuntime fromEnvironment(Map<String, String> env) {
        DatabaseSettings s = DatabaseSettings.from(env);

        UserAccessQueryPort q;
        DatabaseHealthPort h;
        AutoCloseable c = () -> {};

        switch (s.mode()) {
            case "memory" -> {
                var m = new InMemoryUserAccessQueryAdapter();
                q = m;
                h = m;
            }

            case "postgres-password" -> {
                HikariDataSource d =
                        PooledDataSourceFactory.createPasswordDataSource(s);

                var a = new JdbcUserAccessQueryAdapter(d);

                q = a;
                h = a;
                c = d;
            }

            case "lakebase-oauth" -> {
                HikariDataSource d =
                        PooledDataSourceFactory.createLakebaseOAuthDataSource(
                                s,
                                env
                        );

                var a = new JdbcUserAccessQueryAdapter(d);

                q = a;
                h = a;
                c = d;
            }

            default -> throw new IllegalArgumentException(
                    "Unsupported GBC_PERSISTENCE_MODE: " + s.mode()
            );
        }

        return new MicroserviceRuntime(
                new UserAccessQueryService(q),
                h,
                c
        );
    }

    public UserAccessQueryService userAccess() {
        return access;
    }

    public void healthCheck() {
        health.check();
    }

    public void close() throws Exception {
        closeable.close();
    }
}