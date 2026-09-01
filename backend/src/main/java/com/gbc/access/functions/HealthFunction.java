package com.gbc.access.functions;

import com.gbc.access.service.AccessService;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;

@Component
public class HealthFunction {

    @Autowired
    private AccessService accessService;

    @FunctionName("lakebaseHealth")
    public HttpResponseMessage execute(
            @HttpTrigger(
                    name = "request",
                    methods = {HttpMethod.GET},
                    authLevel = AuthorizationLevel.ANONYMOUS,
                    route = "health/lakebase"
            ) HttpRequestMessage<Optional<String>> request,
            ExecutionContext context
    ) {
        try {
            accessService.healthCheck();
            return request.createResponseBuilder(HttpStatus.OK)
                    .header("Content-Type", "application/json")
                    .body(Map.of(
                            "status", "UP",
                            "backend", "UP",
                            "lakebase", "UP",
                            "lakebaseMode", accessService.currentMode(),
                            "timestamp", Instant.now().toString()
                    ))
                    .build();
        } catch (Exception ex) {
            context.getLogger().severe("Health error: " + ex.getMessage());
            return request.createResponseBuilder(HttpStatus.SERVICE_UNAVAILABLE)
                    .header("Content-Type", "application/json")
                    .body(Map.of(
                            "status", "DOWN",
                            "backend", "UP",
                            "lakebase", "DOWN",
                            "lakebaseMode", accessService.currentMode(),
                            "timestamp", Instant.now().toString()
                    ))
                    .build();
        }
    }
}
