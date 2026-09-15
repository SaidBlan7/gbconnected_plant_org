package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.application.ProductNotFoundException;
import com.gbconnected.catalogs.application.command.CreateProductCommand;
import com.gbconnected.catalogs.application.command.PatchProductCommand;
import com.gbconnected.catalogs.application.command.ProductCommandUseCase;
import com.gbconnected.catalogs.application.command.ProductLineCommand;
import com.gbconnected.catalogs.application.command.ReplaceProductCommand;
import com.gbconnected.catalogs.application.port.out.ProductQueryPort;
import com.gbconnected.catalogs.application.query.ProductSummary;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import java.math.BigDecimal;
import java.net.URI;
import java.util.List;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({"/api/v1/products", "/api/products"})
public class ProductController {
    private final ProductQueryPort queries;
    private final ProductCommandUseCase commands;

    public ProductController(
            @Qualifier("products") ProductQueryPort queries,
            ProductCommandUseCase commands) {
        this.queries = queries;
        this.commands = commands;
    }

    @GetMapping
    List<ProductSummary> list(
            @RequestParam(required = false) Long organizationId,
            @RequestParam(required = false) Long plantId,
            @RequestParam(required = false) Long lineId,
            @RequestParam(required = false) Long doughId,
            @RequestParam(required = false) Boolean active,
            @RequestParam(required = false) Boolean semiFinished,
            @RequestParam(required = false) String search) {
        return queries.findAll(organizationId, plantId, lineId, doughId, active, semiFinished, search);
    }

    @GetMapping("/{id}")
    ProductSummary get(@PathVariable long id) {
        return queries.findProductById(id).orElseThrow(() -> new ProductNotFoundException(id));
    }

    @PostMapping
    ResponseEntity<ProductSummary> create(
            @Valid @RequestBody ProductHttpRequest request,
            Authentication authentication,
            HttpServletRequest httpRequest) {
        var product = commands.create(new CreateProductCommand(
                request.organizationId(),
                request.oracleItemCode(),
                request.erpName(),
                request.productName(),
                request.completionSubinventory(),
                request.baseDoughId(),
                bool(request.defaultItem(), false),
                bool(request.semiFinished(), false),
                request.semiFinishedUom(),
                bool(request.lidDesignWasteEnabled(), false),
                request.lidDesignWasteWeightKg(),
                bool(request.edgeDesignWasteEnabled(), false),
                request.edgeDesignWasteWeightKg(),
                bool(request.active(), true),
                lines(request.lineConfigurations()),
                RequestAuditContext.from(authentication, httpRequest)));
        ProductSummary response = get(product.id());
        return ResponseEntity.created(URI.create("/api/v1/products/" + product.id())).body(response);
    }

    @PutMapping("/{id}")
    ProductSummary replace(
            @PathVariable long id,
            @Valid @RequestBody ProductHttpRequest request,
            Authentication authentication,
            HttpServletRequest httpRequest) {
        commands.replace(id, new ReplaceProductCommand(
                request.organizationId(),
                request.oracleItemCode(),
                request.erpName(),
                request.productName(),
                request.completionSubinventory(),
                request.baseDoughId(),
                bool(request.defaultItem(), false),
                bool(request.semiFinished(), false),
                request.semiFinishedUom(),
                bool(request.lidDesignWasteEnabled(), false),
                request.lidDesignWasteWeightKg(),
                bool(request.edgeDesignWasteEnabled(), false),
                request.edgeDesignWasteWeightKg(),
                bool(request.active(), true),
                lines(request.lineConfigurations()),
                RequestAuditContext.from(authentication, httpRequest)));
        return get(id);
    }

    @PatchMapping("/{id}")
    ProductSummary patch(
            @PathVariable long id,
            @Valid @RequestBody PatchProductHttpRequest request,
            Authentication authentication,
            HttpServletRequest httpRequest) {
        commands.patch(id, new PatchProductCommand(
                request.organizationId(),
                request.oracleItemCode(),
                request.erpName(),
                request.productName(),
                request.completionSubinventory(),
                request.baseDoughId(),
                request.defaultItem(),
                request.semiFinished(),
                request.semiFinishedUom(),
                request.lidDesignWasteEnabled(),
                request.lidDesignWasteWeightKg(),
                request.edgeDesignWasteEnabled(),
                request.edgeDesignWasteWeightKg(),
                request.active(),
                request.lineConfigurations() == null ? null : lines(request.lineConfigurations()),
                RequestAuditContext.from(authentication, httpRequest)));
        return get(id);
    }

    private List<ProductLineCommand> lines(List<ProductLineHttpRequest> values) {
        return values.stream().map(this::line).toList();
    }

    private ProductLineCommand line(ProductLineHttpRequest value) {
        BigDecimal kg = value.targetWeightPackageGrams().movePointLeft(3);
        return new ProductLineCommand(
                value.lineId(),
                value.integrationItemCode(),
                value.hourlyProductionRate(),
                value.primaryUomId(),
                value.packagesPerUom(),
                value.piecesPerPackage(),
                value.secondaryUomId(),
                value.uomsPerSecondaryContainer(),
                kg,
                bool(value.active(), true));
    }

    private boolean bool(Boolean value, boolean defaultValue) {
        return value == null ? defaultValue : value;
    }
}
