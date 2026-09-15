package com.gbconnected.catalogs.application.command;

import com.gbconnected.catalogs.application.CatalogReferenceException;
import com.gbconnected.catalogs.application.DefaultProductConflictException;
import com.gbconnected.catalogs.application.ProductNotFoundException;
import com.gbconnected.catalogs.application.port.out.ProductReferenceQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductRepository;
import com.gbconnected.catalogs.domain.DomainValidationException;
import com.gbconnected.catalogs.domain.Product;
import com.gbconnected.catalogs.domain.ProductLineConfiguration;
import java.util.List;
import java.util.Objects;

public final class ProductCommandService implements ProductCommandUseCase {
    private final ProductRepository repository;
    private final ProductReferenceQueryPort references;

    public ProductCommandService(ProductRepository repository, ProductReferenceQueryPort references) {
        this.repository = Objects.requireNonNull(repository);
        this.references = Objects.requireNonNull(references);
    }

    @Override
    public Product create(CreateProductCommand command) {
        Objects.requireNonNull(command);
        AuditContext audit = audit(command.audit());
        try {
            Product product = Product.create(
                    command.organizationId(),
                    command.oracleItemCode(),
                    command.erpName(),
                    command.productName(),
                    command.completionSubinventory(),
                    command.baseDoughId(),
                    command.defaultItem(),
                    command.semiFinished(),
                    command.semiFinishedUom(),
                    command.lidDesignWasteEnabled(),
                    command.lidDesignWasteWeightKg(),
                    command.edgeDesignWasteEnabled(),
                    command.edgeDesignWasteWeightKg(),
                    command.active(),
                    lines(command.lineConfigurations()));
            validateReferences(product);
            ensureDefaultAvailable(product, null);
            return repository.insert(product, audit);
        } catch (RuntimeException ex) {
            rejected(null, command.organizationId(), command.oracleItemCode(), ex, audit);
            throw ex;
        }
    }

    @Override
    public Product replace(long id, ReplaceProductCommand command) {
        Objects.requireNonNull(command);
        Product current = repository.findProductAggregateById(id)
                .orElseThrow(() -> new ProductNotFoundException(id));
        AuditContext audit = audit(command.audit());
        try {
            Product product = current.replace(
                    command.organizationId(),
                    command.oracleItemCode(),
                    command.erpName(),
                    command.productName(),
                    command.completionSubinventory(),
                    command.baseDoughId(),
                    command.defaultItem(),
                    command.semiFinished(),
                    command.semiFinishedUom(),
                    command.lidDesignWasteEnabled(),
                    command.lidDesignWasteWeightKg(),
                    command.edgeDesignWasteEnabled(),
                    command.edgeDesignWasteWeightKg(),
                    command.active(),
                    lines(command.lineConfigurations()));
            validateReferences(product);
            ensureDefaultAvailable(product, id);
            return repository.update(current, product, audit);
        } catch (RuntimeException ex) {
            rejected(id, current.organizationId(), current.oracleItemCode(), ex, audit);
            throw ex;
        }
    }

    @Override
    public Product patch(long id, PatchProductCommand command) {
        Objects.requireNonNull(command);
        Product current = repository.findProductAggregateById(id)
                .orElseThrow(() -> new ProductNotFoundException(id));
        AuditContext audit = audit(command.audit());
        try {
            Product product = current.patch(
                    command.organizationId(),
                    command.oracleItemCode(),
                    command.erpName(),
                    command.productName(),
                    command.completionSubinventory(),
                    command.baseDoughId(),
                    command.defaultItem(),
                    command.semiFinished(),
                    command.semiFinishedUom(),
                    command.lidDesignWasteEnabled(),
                    command.lidDesignWasteWeightKg(),
                    command.edgeDesignWasteEnabled(),
                    command.edgeDesignWasteWeightKg(),
                    command.active(),
                    command.lineConfigurations() == null ? null : lines(command.lineConfigurations()));
            validateReferences(product);
            ensureDefaultAvailable(product, id);
            return repository.update(current, product, audit);
        } catch (RuntimeException ex) {
            rejected(id, current.organizationId(), current.oracleItemCode(), ex, audit);
            throw ex;
        }
    }

    private void ensureDefaultAvailable(Product product, Long excludingProductId) {
        if (product.active()
                && product.defaultItem()
                && repository.hasActiveDefault(product.baseDoughId(), excludingProductId)) {
            throw new DefaultProductConflictException(product.baseDoughId());
        }
    }

    private void validateReferences(Product product) {
        var dough = references.findDoughById(product.baseDoughId())
                .orElseThrow(() -> new CatalogReferenceException(
                        "baseDoughId " + product.baseDoughId() + " does not exist"));
        if (dough.organizationId() != product.organizationId()) {
            throw new CatalogReferenceException("The selected dough does not belong to the product organization");
        }
        if (product.active() && !dough.active()) {
            throw new CatalogReferenceException("An active product cannot use an inactive dough");
        }

        for (ProductLineConfiguration config : product.lineConfigurations()) {
            var line = references.findLineById(config.lineId())
                    .orElseThrow(() -> new CatalogReferenceException(
                            "lineId " + config.lineId() + " does not exist"));
            if (line.organizationId() != product.organizationId()) {
                throw new CatalogReferenceException(
                        "lineId " + config.lineId() + " does not belong to the product organization");
            }
            if (config.active() && !line.active()) {
                throw new CatalogReferenceException("An active product-line configuration cannot use an inactive line");
            }

            var primary = references.findContainerUomById(config.primaryUomId())
                    .orElseThrow(() -> new CatalogReferenceException(
                            "primaryUomId " + config.primaryUomId() + " does not exist"));
            if (primary.plantId() != line.plantId()) {
                throw new CatalogReferenceException("Primary UOM must belong to the same plant as the line");
            }
            if (!"PRIMARY".equalsIgnoreCase(primary.containerLevel())) {
                throw new CatalogReferenceException("primaryUomId must have containerLevel PRIMARY");
            }
            if (config.active() && !primary.active()) {
                throw new CatalogReferenceException("An active configuration cannot use an inactive primary UOM");
            }

            if (config.secondaryUomId() != null) {
                var secondary = references.findContainerUomById(config.secondaryUomId())
                        .orElseThrow(() -> new CatalogReferenceException(
                                "secondaryUomId " + config.secondaryUomId() + " does not exist"));
                if (secondary.plantId() != line.plantId()) {
                    throw new CatalogReferenceException("Secondary UOM must belong to the same plant as the line");
                }
                if (!"SECONDARY".equalsIgnoreCase(secondary.containerLevel())) {
                    throw new CatalogReferenceException("secondaryUomId must have containerLevel SECONDARY");
                }
                if (config.active() && !secondary.active()) {
                    throw new CatalogReferenceException("An active configuration cannot use an inactive secondary UOM");
                }
            }
        }
    }

    private List<ProductLineConfiguration> lines(List<ProductLineCommand> lines) {
        if (lines == null) return null;
        return lines.stream().map(ProductLineCommand::toDomain).toList();
    }

    private AuditContext audit(AuditContext value) {
        return value == null ? new AuditContext("SYSTEM", "SYSTEM", null) : value;
    }

    private void rejected(
            Long productId,
            long organizationId,
            String itemCode,
            RuntimeException ex,
            AuditContext audit) {
        String code;
        String event;
        if (ex instanceof DefaultProductConflictException) {
            code = "DEFAULT_PRODUCT_CONFLICT";
            event = "DEFAULT_CONFLICT";
        } else if (ex instanceof DomainValidationException) {
            code = "INVALID_PRODUCT_CONFIGURATION";
            event = "VALIDATION_REJECTED";
        } else if (ex instanceof CatalogReferenceException) {
            code = "INVALID_CATALOG_REFERENCE";
            event = "VALIDATION_REJECTED";
        } else {
            return;
        }
        try {
            repository.recordRejectedAudit(new RejectedProductAudit(
                    productId,
                    organizationId,
                    null,
                    itemCode,
                    event,
                    code,
                    ex.getMessage(),
                    audit));
        } catch (RuntimeException ignored) {
            // Rejected-attempt auditing must not hide the original validation error.
        }
    }
}
