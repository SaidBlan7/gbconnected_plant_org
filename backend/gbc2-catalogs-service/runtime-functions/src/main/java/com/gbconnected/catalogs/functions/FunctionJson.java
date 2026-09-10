package com.gbconnected.catalogs.functions;

import com.google.gson.*;

import java.time.Instant;

final class FunctionJson {

    static final Gson GSON = new GsonBuilder()
            .registerTypeAdapter(
                    Instant.class,
                    new InstantTypeAdapter()
            )
            .create();

    private FunctionJson() {
    }
}