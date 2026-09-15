package com.gbconnected.catalogs.functions;

import com.gbconnected.catalogs.application.CatalogReferenceException;
import com.gbconnected.catalogs.application.DefaultProductConflictException;
import com.gbconnected.catalogs.application.DuplicateProductException;
import com.gbconnected.catalogs.application.ProductNotFoundException;
import com.gbconnected.catalogs.application.command.AuditContext;
import com.gbconnected.catalogs.application.command.CreateProductCommand;
import com.gbconnected.catalogs.application.command.PatchProductCommand;
import com.gbconnected.catalogs.application.command.ProductLineCommand;
import com.gbconnected.catalogs.application.command.ReplaceProductCommand;
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
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public class ProductCatalogFunctions {
    private static final String CORRELATION_HEADER = "X-Correlation-Id";

    @FunctionName("catalogs-products-list-create")
    public HttpResponseMessage products(
            @HttpTrigger(
                    name = "req",
                    methods = {HttpMethod.GET, HttpMethod.POST},
                    route = "v1/products",
                    authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            if (request.getHttpMethod() == HttpMethod.GET) {
                Map<String, String> q = request.getQueryParameters();
                return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.products().findAll(
                        parseLongNullable(q.get("organizationId"), "organizationId"),
                        parseLongNullable(q.get("plantId"), "plantId"),
                        parseLongNullable(q.get("lineId"), "lineId"),
                        parseLongNullable(q.get("doughId"), "doughId"),
                        parseBoolean(q.get("active"), "active"),
                        parseBoolean(q.get("semiFinished"), "semiFinished"),
                        q.get("search")));
            }

            ProductFunctionRequest body = body(request);
            var created = FunctionRuntime.RUNTIME.productCommands().create(new CreateProductCommand(
                    required(body.organizationId, "organizationId"),
                    required(body.oracleItemCode, "oracleItemCode"),
                    body.erpName,
                    required(body.productName, "productName"),
                    body.completionSubinventory,
                    required(body.baseDoughId, "baseDoughId"),
                    bool(body.defaultItem, false),
                    bool(body.semiFinished, false),
                    body.semiFinishedUom,
                    bool(body.lidDesignWasteEnabled, false),
                    body.lidDesignWasteWeightKg,
                    bool(body.edgeDesignWasteEnabled, false),
                    body.edgeDesignWasteWeightKg,
                    bool(body.active, true),
                    lines(body.lineConfigurations),
                    audit(request)));
            return json(request, HttpStatus.CREATED,
                    FunctionRuntime.RUNTIME.products().findProductById(created.id()).orElseThrow());
        } catch (DuplicateProductException | DefaultProductConflictException ex) {
            return error(request, HttpStatus.CONFLICT, ex.getMessage());
        } catch (IllegalArgumentException | DomainValidationException | CatalogReferenceException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-products-by-id")
    public HttpResponseMessage product(
            @HttpTrigger(
                    name = "req",
                    methods = {HttpMethod.GET, HttpMethod.PUT, HttpMethod.PATCH},
                    route = "v1/products/{id}",
                    authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            @BindingName("id") String rawId,
            ExecutionContext context) {
        try {
            long id = parseLong(rawId, "id");
            if (request.getHttpMethod() == HttpMethod.GET) {
                return FunctionRuntime.RUNTIME.products().findProductById(id)
                        .map(value -> json(request, HttpStatus.OK, value))
                        .orElseGet(() -> error(request, HttpStatus.NOT_FOUND, "Product not found"));
            }

            ProductFunctionRequest body = body(request);
            if (request.getHttpMethod() == HttpMethod.PUT) {
                FunctionRuntime.RUNTIME.productCommands().replace(id, new ReplaceProductCommand(
                        required(body.organizationId, "organizationId"),
                        required(body.oracleItemCode, "oracleItemCode"),
                        body.erpName,
                        required(body.productName, "productName"),
                        body.completionSubinventory,
                        required(body.baseDoughId, "baseDoughId"),
                        bool(body.defaultItem, false),
                        bool(body.semiFinished, false),
                        body.semiFinishedUom,
                        bool(body.lidDesignWasteEnabled, false),
                        body.lidDesignWasteWeightKg,
                        bool(body.edgeDesignWasteEnabled, false),
                        body.edgeDesignWasteWeightKg,
                        bool(body.active, true),
                        lines(body.lineConfigurations),
                        audit(request)));
            } else {
                FunctionRuntime.RUNTIME.productCommands().patch(id, new PatchProductCommand(
                        body.organizationId,
                        body.oracleItemCode,
                        body.erpName,
                        body.productName,
                        body.completionSubinventory,
                        body.baseDoughId,
                        body.defaultItem,
                        body.semiFinished,
                        body.semiFinishedUom,
                        body.lidDesignWasteEnabled,
                        body.lidDesignWasteWeightKg,
                        body.edgeDesignWasteEnabled,
                        body.edgeDesignWasteWeightKg,
                        body.active,
                        body.lineConfigurations == null ? null : lines(body.lineConfigurations),
                        audit(request)));
            }
            return json(request, HttpStatus.OK,
                    FunctionRuntime.RUNTIME.products().findProductById(id).orElseThrow());
        } catch (ProductNotFoundException ex) {
            return error(request, HttpStatus.NOT_FOUND, ex.getMessage());
        } catch (DuplicateProductException | DefaultProductConflictException ex) {
            return error(request, HttpStatus.CONFLICT, ex.getMessage());
        } catch (IllegalArgumentException | DomainValidationException | CatalogReferenceException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-doughs-list")
    public HttpResponseMessage doughs(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "v1/doughs", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            Map<String, String> q = request.getQueryParameters();
            return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.productReferences().findDoughs(
                    parseLongNullable(q.get("organizationId"), "organizationId"),
                    parseLongNullable(q.get("lineId"), "lineId"),
                    parseBoolean(q.get("active"), "active")));
        } catch (IllegalArgumentException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-production-lines-list")
    public HttpResponseMessage lines(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "v1/production-lines", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            Map<String, String> q = request.getQueryParameters();
            return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.productReferences().findLines(
                    parseLongNullable(q.get("plantId"), "plantId"),
                    parseLongNullable(q.get("organizationId"), "organizationId"),
                    parseBoolean(q.get("active"), "active")));
        } catch (IllegalArgumentException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    @FunctionName("catalogs-container-uoms-list")
    public HttpResponseMessage containerUoms(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, route = "v1/container-uoms", authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            Map<String, String> q = request.getQueryParameters();
            return json(request, HttpStatus.OK, FunctionRuntime.RUNTIME.productReferences().findContainerUoms(
                    parseLongNullable(q.get("plantId"), "plantId"),
                    q.get("level"),
                    parseBoolean(q.get("active"), "active")));
        } catch (IllegalArgumentException ex) {
            return error(request, HttpStatus.BAD_REQUEST, ex.getMessage());
        }
    }

    private ProductFunctionRequest body(HttpRequestMessage<Optional<String>> request) {
        String payload = request.getBody()
                .orElseThrow(() -> new IllegalArgumentException("Request body is required"));
        ProductFunctionRequest value = FunctionJson.GSON.fromJson(payload, ProductFunctionRequest.class);
        if (value == null) throw new IllegalArgumentException("Request body is required");
        return value;
    }

    private List<ProductLineCommand> lines(List<ProductFunctionRequest.Line> values) {
        if (values == null || values.isEmpty()) {
            throw new IllegalArgumentException("lineConfigurations is required");
        }
        return values.stream().map(value -> new ProductLineCommand(
                required(value.lineId, "lineId"),
                value.integrationItemCode,
                required(value.hourlyProductionRate, "hourlyProductionRate"),
                required(value.primaryUomId, "primaryUomId"),
                required(value.packagesPerUom, "packagesPerUom"),
                required(value.piecesPerPackage, "piecesPerPackage"),
                value.secondaryUomId,
                value.uomsPerSecondaryContainer,
                required(value.targetWeightPackageGrams, "targetWeightPackageGrams").movePointLeft(3),
                bool(value.active, true))).toList();
    }

    private AuditContext audit(HttpRequestMessage<?> request) {
        String source = header(request, "X-GBC-Source-Type");
        String actor = header(request, "X-GBC-Actor");
        if (actor == null || actor.isBlank()) actor = "AZURE_FUNCTION";
        return new AuditContext(source, actor, correlationId(request));
    }

    private String header(HttpRequestMessage<?> request, String name) {
        return request.getHeaders().entrySet().stream()
                .filter(entry -> entry.getKey().equalsIgnoreCase(name))
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse(null);
    }

    private long required(Long value, String name) {
        if (value == null) throw new IllegalArgumentException(name + " is required");
        return value;
    }

    private String required(String value, String name) {
        if (value == null || value.isBlank()) throw new IllegalArgumentException(name + " is required");
        return value;
    }

    private BigDecimal required(BigDecimal value, String name) {
        if (value == null) throw new IllegalArgumentException(name + " is required");
        return value;
    }

    private boolean bool(Boolean value, boolean defaultValue) {
        return value == null ? defaultValue : value;
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

    private Boolean parseBoolean(String value, String name) {
        if (value == null || value.isBlank()) return null;
        if ("true".equalsIgnoreCase(value)) return true;
        if ("false".equalsIgnoreCase(value)) return false;
        throw new IllegalArgumentException(name + " must be true or false");
    }

    private String correlationId(HttpRequestMessage<?> request) {
        String existing = header(request, CORRELATION_HEADER);
        return existing == null || existing.isBlank() ? UUID.randomUUID().toString() : existing;
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
