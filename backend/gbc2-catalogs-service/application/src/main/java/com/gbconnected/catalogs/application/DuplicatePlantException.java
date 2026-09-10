package com.gbconnected.catalogs.application;

public final class DuplicatePlantException extends RuntimeException {

    public DuplicatePlantException(String message, Throwable cause) {
        super(message, cause);
    }
}