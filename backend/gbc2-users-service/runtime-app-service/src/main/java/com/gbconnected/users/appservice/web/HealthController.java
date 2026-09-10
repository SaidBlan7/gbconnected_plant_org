package com.gbconnected.users.appservice.web;

import com.gbconnected.users.bootstrap.MicroserviceRuntime;

import java.time.Instant;
import java.util.Map;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping({"/api/v1/health", "/api/health"})
public class HealthController {

    private final MicroserviceRuntime r;

    public HealthController(MicroserviceRuntime r) {
        this.r = r;
    }

    @GetMapping({"/database", "/lakebase"})
    Map<String, Object> db() {
        r.healthCheck();

        return Map.of(
                "status", "UP",
                "timestamp", Instant.now().toString()
        );
    }
}