package com.gbconnected.catalogs.application;

public final class DefaultProductConflictException extends RuntimeException {
    public DefaultProductConflictException(long doughId) {
        super("Dough " + doughId + " already has an active default product");
    }

    public DefaultProductConflictException(long doughId, Throwable cause) {
        super("Dough " + doughId + " already has an active default product", cause);
    }
}
