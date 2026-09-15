package com.gbconnected.catalogs.application;

public final class DuplicateProductException extends RuntimeException {
    public DuplicateProductException(String message, Throwable cause) {
        super(message, cause);
    }
}
