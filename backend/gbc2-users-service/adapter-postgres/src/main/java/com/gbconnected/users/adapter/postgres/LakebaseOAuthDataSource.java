package com.gbconnected.users.adapter.postgres;

import com.databricks.sdk.WorkspaceClient;
import com.databricks.sdk.core.DatabricksConfig;
import com.databricks.sdk.service.postgres.DatabaseCredential;
import com.databricks.sdk.service.postgres.GenerateDatabaseCredentialRequest;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.Map;
import java.util.logging.Logger;
import javax.sql.DataSource;

public final class LakebaseOAuthDataSource implements DataSource {
    private final WorkspaceClient workspaceClient;
    private final String endpointName;
    private final String jdbcUrl;
    private final String username;
    private volatile PrintWriter logWriter;
    private volatile int loginTimeout;

    private LakebaseOAuthDataSource(
            WorkspaceClient workspaceClient,
            String endpointName,
            String jdbcUrl,
            String username) {
        this.workspaceClient = workspaceClient;
        this.endpointName = endpointName;
        this.jdbcUrl = jdbcUrl;
        this.username = username;
    }

    public static LakebaseOAuthDataSource from(Map<String, String> env) {
        String databricksHost = DatabaseSettings.required(env, "DATABRICKS_HOST");
        String clientId = DatabaseSettings.required(env, "DATABRICKS_CLIENT_ID");
        String clientSecret = DatabaseSettings.required(env, "DATABRICKS_CLIENT_SECRET");
        String endpointName = DatabaseSettings.required(env, "ENDPOINT_NAME");
        String host = DatabaseSettings.required(env, "PGHOST");
        String database = DatabaseSettings.required(env, "PGDATABASE");
        String user = DatabaseSettings.required(env, "PGUSER");
        String port = env.getOrDefault("PGPORT", "5432");

        WorkspaceClient client = new WorkspaceClient(new DatabricksConfig()
                .setHost(databricksHost)
                .setClientId(clientId)
                .setClientSecret(clientSecret));

        String jdbcUrl = "jdbc:postgresql://" + host + ":" + port + "/" + database
                + "?sslmode=require&connectTimeout=10&socketTimeout=30";
        return new LakebaseOAuthDataSource(client, endpointName, jdbcUrl, user);
    }

    @Override
    public Connection getConnection() throws SQLException {
        try {
            DatabaseCredential credential = workspaceClient.postgres().generateDatabaseCredential(
                    new GenerateDatabaseCredentialRequest().setEndpoint(endpointName));
            return DriverManager.getConnection(jdbcUrl, username, credential.getToken());
        } catch (RuntimeException ex) {
            throw new SQLException("Unable to generate Lakebase database credential", ex);
        }
    }

    @Override
    public Connection getConnection(String username, String password) {
        throw new UnsupportedOperationException("Explicit username/password is not supported for Lakebase OAuth");
    }

    @Override
    public PrintWriter getLogWriter() {
        return logWriter;
    }

    @Override
    public void setLogWriter(PrintWriter out) {
        this.logWriter = out;
        DriverManager.setLogWriter(out);
    }

    @Override
    public void setLoginTimeout(int seconds) {
        this.loginTimeout = seconds;
        DriverManager.setLoginTimeout(seconds);
    }

    @Override
    public int getLoginTimeout() {
        return loginTimeout;
    }

    @Override
    public Logger getParentLogger() throws SQLFeatureNotSupportedException {
        return Logger.getLogger("com.gbconnected.users.adapter.postgres");
    }

    @Override
    public <T> T unwrap(Class<T> iface) throws SQLException {
        if (iface.isInstance(this)) return iface.cast(this);
        throw new SQLException("Not a wrapper for " + iface.getName());
    }

    @Override
    public boolean isWrapperFor(Class<?> iface) {
        return iface.isInstance(this);
    }
}
