package com.gbconnected.catalogs.functions;

import com.gbconnected.catalogs.application.DuplicatePlantException;
import com.gbconnected.catalogs.application.PlantNotFoundException;
import com.gbconnected.catalogs.application.command.CreatePlantCommand;
import com.gbconnected.catalogs.application.command.PatchPlantCommand;
import com.gbconnected.catalogs.application.command.ReplacePlantCommand;
import com.gbconnected.catalogs.domain.DomainValidationException;
import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.HttpStatus;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.BindingName;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public class CatalogFunctions {
    private static final String CORRELATION_HEADER = "X-Correlation-Id";

    @FunctionName("catalogs-organizations-list")
    public HttpResponseMessage organizations(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "v1/organizations", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            Boolean active = parseBoolean(request.getQueryParameters().get("active"));
            return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.organizations().findAll(active));
        } catch (IllegalArgumentException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-organizations-get")
    public HttpResponseMessage organization(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "v1/organizations/{id}", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            @BindingName("id") String id,
            ExecutionContext context) {
        try {
            return FunctionRuntime.RUNTIME.organizations().findOrganizationById(parseLong(id, "id"))
                    .map(value -> json(request, HttpStatus.OK, value))
                    .orElseGet(() -> error(request, HttpStatus.NOT_FOUND, "Organization not found"));
        } catch (IllegalArgumentException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-plants-list-create")
    public HttpResponseMessage plants(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, route = "v1/plants", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            if (request.getHttpMethod() == HttpMethod.GET) {
                Long organizationId = parseLongNullable(request.getQueryParameters().get("organizationId"), "organizationId");
                Boolean active = parseBoolean(request.getQueryParameters().get("active"));
                return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.plants().findAll(organizationId, active));
            }

            PlantFunctionRequest body = body(request);
            var created = FunctionRuntime.RUNTIME.plantCommands().create(new CreatePlantCommand(
                    required(body.organizationId, "organizationId"),
                    body.plantCode,
                    body.plantName,
                    body.erpPlantCode,
                    body.countryCode,
                    body.regionCode,
                    body.address,
                    body.timezoneName,
                    body.languageCode,
                    body.active == null || body.active));
            return json(request, HttpStatus.CREATED, PlantFunctionResponse.from(created));
        } catch (DuplicatePlantException ex) {
            return error(request, HttpStatus.CONFLICT, ex.getMessage());
        } catch (IllegalArgumentException | DomainValidationException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-plants-by-id")
    public HttpResponseMessage plant(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.PUT, HttpMethod.PATCH, HttpMethod.DELETE}, route = "v1/plants/{id}", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            @BindingName("id") String rawId,
            ExecutionContext context) {
        try {
            long id = parseLong(rawId, "id");

            if (request.getHttpMethod() == HttpMethod.GET) {
                return FunctionRuntime.RUNTIME.plants().findPlantById(id)
                        .map(value -> json(request, HttpStatus.OK, value))
                        .orElseGet(() -> error(request, HttpStatus.NOT_FOUND, "Plant not found"));
            }

            if (request.getHttpMethod() == HttpMethod.DELETE) {
                FunctionRuntime.RUNTIME.plantCommands().delete(id);
                return request.createResponseBuilder(HttpStatus.NO_CONTENT)
                        .header(CORRELATION_HEADER, correlationId(request))
                        .build();
            }

            PlantFunctionRequest body = body(request);
            if (request.getHttpMethod() == HttpMethod.PUT) {
                var updated = FunctionRuntime.RUNTIME.plantCommands().replace(id, new ReplacePlantCommand(
                        required(body.organizationId, "organizationId"),
                        body.plantCode,
                        body.plantName,
                        body.erpPlantCode,
                        body.countryCode,
                        body.regionCode,
                        body.address,
                        body.timezoneName,
                        body.languageCode,
                        body.active == null || body.active));
                return json(request, HttpStatus.OK, PlantFunctionResponse.from(updated));
            }

            var updated = FunctionRuntime.RUNTIME.plantCommands().patch(id, new PatchPlantCommand(
                    body.organizationId,
                    body.plantCode,
                    body.plantName,
                    body.erpPlantCode,
                    body.countryCode,
                    body.regionCode,
                    body.address,
                    body.timezoneName,
                    body.languageCode,
                    body.active));
            return json(request, HttpStatus.OK, PlantFunctionResponse.from(updated));
        } catch (PlantNotFoundException ex) {
            return error(request, HttpStatus.NOT_FOUND, ex.getMessage());
        } catch (DuplicatePlantException ex) {
            return error(request, HttpStatus.CONFLICT, ex.getMessage());
        } catch (IllegalArgumentException | DomainValidationException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-health")
    public HttpResponseMessage health(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "health", authLevel = AuthorizationLevel.ANONYMOUS)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            FunctionRuntime.RUNTIME.healthCheck();
            return json(request, HttpStatus.OK, Map.of("status", "UP"));
        } catch (Exception ex) {
            return error(request, HttpStatus.SERVICE_UNAVAILABLE, "Database unavailable");
        }
    }

    private PlantFunctionRequest body(HttpRequestMessage<Optional<String>> request) {
        String payload = request.getBody().orElseThrow(() -> new IllegalArgumentException("Request body is required"));
        PlantFunctionRequest value = FunctionJson.GSON.fromJson(payload, PlantFunctionRequest.class);
        if (value == null) throw new IllegalArgumentException("Request body is required");
        return value;
    }

    private long required(Long value, String name) {
        if (value == null) throw new IllegalArgumentException(name + " is required");
        return value;
    }

    private long parseLong(String value, String name) {
        try {
            return Long.parseLong(value);
        } catch (Exception ex) {
            throw new IllegalArgumentException(name + " must be numeric");
        }
    }

    private Long parseLongNullable(String value, String name) {
        return value == null || value.isBlank() ? null : parseLong(value, name);
    }

    private Boolean parseBoolean(String value) {
        if (value == null || value.isBlank()) return null;
        if ("true".equalsIgnoreCase(value)) return true;
        if ("false".equalsIgnoreCase(value)) return false;
        throw new IllegalArgumentException("active must be true or false");
    }

    private String correlationId(HttpRequestMessage<?> request) {
        return request.getHeaders().entrySet().stream()
                .filter(entry -> entry.getKey().equalsIgnoreCase(CORRELATION_HEADER))
                .map(Map.Entry::getValue)
                .filter(value -> value != null && !value.isBlank())
                .findFirst()
                .orElseGet(() -> UUID.randomUUID().toString());
    }

    private HttpResponseMessage json(HttpRequestMessage<?> request, HttpStatus status, Object body) {
        return request.createResponseBuilder(status)
                .header("Content-Type", "application/json")
                .header(CORRELATION_HEADER, correlationId(request))
                .body(FunctionJson.GSON.toJson(body))
                .build();
    }

    private HttpResponseMessage error(HttpRequestMessage<?> request, HttpStatus status, String detail) {
        String correlationId = correlationId(request);
        return request.createResponseBuilder(status)
                .header("Content-Type", "application/problem+json")
                .header(CORRELATION_HEADER, correlationId)
                .body(FunctionJson.GSON.toJson(Map.of(
                        "status", status.value(),
                        "title", status.name(),
                        "detail", detail == null ? "Request failed" : detail,
                        "correlationId", correlationId)))
                .build();
    }
}
