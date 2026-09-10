package com.gbconnected.catalogs.domain;

public final class DomainValidationException extends RuntimeException {

    public DomainValidationException(String message) {
        super(message);
    }
}