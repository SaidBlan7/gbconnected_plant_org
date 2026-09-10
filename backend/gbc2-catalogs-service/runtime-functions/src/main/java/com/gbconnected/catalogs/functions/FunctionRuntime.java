package com.gbconnected.catalogs.functions;

import com.gbconnected.catalogs.bootstrap.MicroserviceRuntime;

final class FunctionRuntime {

    static final MicroserviceRuntime RUNTIME =
            MicroserviceRuntime.fromEnvironment(System.getenv());

    private FunctionRuntime() {
    }
}