package com.gbconnected.users.functions;

import com.gbconnected.users.bootstrap.MicroserviceRuntime;

final class FunctionRuntime {

    static final MicroserviceRuntime RUNTIME =
            MicroserviceRuntime.fromEnvironment(System.getenv());

    private FunctionRuntime() {
    }
}