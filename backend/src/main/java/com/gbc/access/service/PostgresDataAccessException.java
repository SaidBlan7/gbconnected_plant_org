package com.gbc.access.service;

import org.springframework.dao.DataAccessException;

import java.sql.SQLException;

public class PostgresDataAccessException extends RuntimeException {
    private final String sqlState;

    public PostgresDataAccessException(String message, String sqlState, Throwable cause) {
        super(message, cause);
        this.sqlState = sqlState;
    }

    public String getSqlState() { return sqlState; }

    public static PostgresDataAccessException from(DataAccessException ex) {
        Throwable current = ex;
        SQLException sql = null;
        while (current != null) {
            if (current instanceof SQLException found) {
                sql = found;
                break;
            }
            current = current.getCause();
        }
        String state = sql == null ? null : sql.getSQLState();
        String message = sql == null ? ex.getMessage() : sql.getMessage();
        return new PostgresDataAccessException(message, state, ex);
    }
}
