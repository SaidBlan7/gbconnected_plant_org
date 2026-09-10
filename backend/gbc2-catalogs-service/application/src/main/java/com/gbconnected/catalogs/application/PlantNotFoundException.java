package com.gbconnected.catalogs.application;

public final class PlantNotFoundException extends RuntimeException {

    public PlantNotFoundException(long id) {
        super("Plant " + id + " was not found");
    }
}