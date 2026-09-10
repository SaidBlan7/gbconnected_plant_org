package com.gbconnected.catalogs.application;

public final class OrganizationNotFoundException extends RuntimeException {

    public OrganizationNotFoundException(long id) {
        super("Organization " + id + " was not found");
    }
}