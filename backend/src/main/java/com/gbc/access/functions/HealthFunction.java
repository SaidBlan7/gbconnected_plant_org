package com.gbc.access.functions;

import com.gbc.access.service.AccessService;
import com.gbc.access.service.PlantCrudService;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Map;
import java.util.Optional;

@Component
public class HealthFunction {
    private final AccessService accessService;
    private final PlantCrudService plantCrudService;

    public HealthFunction(AccessService accessService, PlantCrudService plantCrudService) {
        this.accessService = accessService;
        this.plantCrudService = plantCrudService;
    }

    @FunctionName("lakebaseHealth")
    public HttpResponseMessage execute(
            @HttpTrigger(name="request", methods={HttpMethod.GET}, authLevel=AuthorizationLevel.ANONYMOUS, route="health/lakebase")
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            if ("data-api".equals(plantCrudService.currentMode())) plantCrudService.health();
            else accessService.healthCheck();
            return request.createResponseBuilder(HttpStatus.OK).header("Content-Type","application/json")
                    .body(Map.of("status","UP","accessMode",accessService.currentMode(),"plantCrudMode",plantCrudService.currentMode(),"timestamp",Instant.now().toString())).build();
        } catch (Exception ex) {
            context.getLogger().severe("Health error: " + ex.getMessage());
            return request.createResponseBuilder(HttpStatus.SERVICE_UNAVAILABLE).header("Content-Type","application/json")
                    .body(Map.of("status","DOWN","accessMode",accessService.currentMode(),"plantCrudMode",plantCrudService.currentMode(),"timestamp",Instant.now().toString())).build();
        }
    }
}
