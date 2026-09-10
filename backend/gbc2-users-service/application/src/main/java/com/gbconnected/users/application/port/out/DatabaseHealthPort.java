package com.gbconnected.users.application.port.out;

@FunctionalInterface
public interface DatabaseHealthPort {

    void check();
}