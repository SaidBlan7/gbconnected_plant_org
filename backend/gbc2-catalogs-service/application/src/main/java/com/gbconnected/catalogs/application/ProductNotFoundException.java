package com.gbconnected.catalogs.application;

public final class ProductNotFoundException extends RuntimeException {
    public ProductNotFoundException(long id) {
        super("Product " + id + " was not found");
    }
}
