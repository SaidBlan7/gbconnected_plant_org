package com.gbconnected.users.adapter.memory;

import com.gbconnected.users.application.port.out.*;
import com.gbconnected.users.application.query.*;

import java.util.*;
import java.util.UUID;

public final class InMemoryUserAccessQueryAdapter
        implements UserAccessQueryPort, DatabaseHealthPort {

    public static final UUID DEMO_TENANT =
            UUID.fromString("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");

    public static final UUID DEMO_USER =
            UUID.fromString("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb");

    private boolean demo(UUID t, UUID o) {
        return DEMO_TENANT.equals(t) && DEMO_USER.equals(o);
    }

    public List<UserOrganizationSummary> organizations(UUID t, UUID o) {
        return demo(t, o)
                ? List.of(
                        new UserOrganizationSummary(
                                1,
                                "MX",
                                "Organización México"
                        )
                )
                : List.of();
    }

    public List<UserPlantSummary> plants(UUID t, UUID o, long org) {
        if (!demo(t, o) || org != 1) {
            return List.of();
        }

        return List.of(
                new UserPlantSummary(
                        1,
                        "TOL",
                        "Planta Toluca",
                        1
                ),
                new UserPlantSummary(
                        2,
                        "PUE",
                        "Planta Puebla",
                        1
                )
        );
    }

    public void check() {
    }
}