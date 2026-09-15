package com.gbconnected.catalogs.adapter.memory;

import com.gbconnected.catalogs.application.DefaultProductConflictException;
import com.gbconnected.catalogs.application.DuplicatePlantException;
import com.gbconnected.catalogs.application.DuplicateProductException;
import com.gbconnected.catalogs.application.command.AuditContext;
import com.gbconnected.catalogs.application.command.RejectedProductAudit;
import com.gbconnected.catalogs.application.port.out.DatabaseHealthPort;
import com.gbconnected.catalogs.application.port.out.OrganizationQueryPort;
import com.gbconnected.catalogs.application.port.out.PlantQueryPort;
import com.gbconnected.catalogs.application.port.out.PlantRepository;
import com.gbconnected.catalogs.application.port.out.ProductQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductReferenceQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductRepository;
import com.gbconnected.catalogs.application.query.ContainerUomOption;
import com.gbconnected.catalogs.application.query.DoughOption;
import com.gbconnected.catalogs.application.query.OrganizationSummary;
import com.gbconnected.catalogs.application.query.PlantSummary;
import com.gbconnected.catalogs.application.query.ProductLineSummary;
import com.gbconnected.catalogs.application.query.ProductSummary;
import com.gbconnected.catalogs.application.query.ProductionLineOption;
import com.gbconnected.catalogs.domain.Plant;
import com.gbconnected.catalogs.domain.Product;
import com.gbconnected.catalogs.domain.ProductLineConfiguration;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

public final class InMemoryCatalogRepository implements
        OrganizationQueryPort,
        PlantQueryPort,
        PlantRepository,
        ProductQueryPort,
        ProductReferenceQueryPort,
        ProductRepository,
        DatabaseHealthPort {

    private final Map<Long, OrganizationSummary> orgs = new LinkedHashMap<>();
    private final Map<Long, Plant> plants = new ConcurrentHashMap<>();
    private final Map<Long, DoughOption> doughs = new LinkedHashMap<>();
    private final Map<Long, ProductionLineOption> lines = new LinkedHashMap<>();
    private final Map<Long, ContainerUomOption> uoms = new LinkedHashMap<>();
    private final Map<Long, Product> products = new ConcurrentHashMap<>();
    private final List<RejectedProductAudit> rejectedAudits = new ArrayList<>();

    private final AtomicLong plantIds = new AtomicLong(4);
    private final AtomicLong productIds = new AtomicLong(1);

    public InMemoryCatalogRepository() {
        Instant now = Instant.now();
        orgs.put(1L, new OrganizationSummary(1, "MX", "Organización México", true, now, now));
        orgs.put(2L, new OrganizationSummary(2, "US", "Organización Estados Unidos", true, now, now));

        plants.put(1L, Plant.rehydrate(1, 1, "TOL", "Planta Toluca", null, "MX", null, null,
                "America/Mexico_City", "es-MX", true, now, now));
        plants.put(2L, Plant.rehydrate(2, 1, "PUE", "Planta Puebla", null, "MX", null, null,
                "America/Mexico_City", "es-MX", true, now, now));
        plants.put(3L, Plant.rehydrate(3, 2, "TX", "Planta Texas", null, "US", null, null,
                "America/Chicago", "en-US", true, now, now));

        lines.put(1L, new ProductionLineOption(1, 1, 1, "MAIZ1", "MAIZ 1", true));
        lines.put(2L, new ProductionLineOption(2, 1, 1, "MAIZ2", "MAIZ 2", true));
        lines.put(3L, new ProductionLineOption(3, 1, 1, "MAIZ3", "MAIZ 3", true));
        lines.put(4L, new ProductionLineOption(4, 2, 1, "PUE1", "Puebla 1", true));
        lines.put(5L, new ProductionLineOption(5, 3, 2, "TX1", "Texas 1", true));

        doughs.put(1L, new DoughOption(1, 1, "SU104240", "MASA TAKIS", true));
        doughs.put(2L, new DoughOption(2, 1, "SU104241", "MASA PAN BLANCO", true));
        doughs.put(3L, new DoughOption(3, 2, "US100001", "DOUGH TEXAS", true));

        uoms.put(1L, new ContainerUomOption(1, 1, "COR", "Corrugado", "PRIMARY", true, "CONFIGURATOR"));
        uoms.put(2L, new ContainerUomOption(2, 1, "TINA", "Tina", "PRIMARY", true, "CONFIGURATOR"));
        uoms.put(3L, new ContainerUomOption(3, 1, "PALLET", "Tarima", "SECONDARY", true, "CONFIGURATOR"));
        uoms.put(4L, new ContainerUomOption(4, 2, "BOX", "Caja", "PRIMARY", true, "CONFIGURATOR"));
        uoms.put(5L, new ContainerUomOption(5, 2, "PALLET", "Tarima", "SECONDARY", true, "CONFIGURATOR"));
        uoms.put(6L, new ContainerUomOption(6, 3, "BOX", "Box", "PRIMARY", true, "CONFIGURATOR"));
        uoms.put(7L, new ContainerUomOption(7, 3, "PALLET", "Pallet", "SECONDARY", true, "CONFIGURATOR"));
    }

    @Override
    public List<OrganizationSummary> findAll(Boolean active) {
        return orgs.values().stream().filter(o -> active == null || o.active() == active).toList();
    }

    @Override
    public Optional<OrganizationSummary> findOrganizationById(long id) {
        return Optional.ofNullable(orgs.get(id));
    }

    @Override
    public List<PlantSummary> findAll(Long organizationId, Boolean active) {
        return plants.values().stream()
                .filter(p -> organizationId == null || p.organizationId() == organizationId)
                .filter(p -> active == null || p.active() == active)
                .sorted(Comparator.comparing(Plant::plantName))
                .map(this::plantSummary)
                .toList();
    }

    @Override
    public Optional<PlantSummary> findPlantById(long id) {
        return Optional.ofNullable(plants.get(id)).map(this::plantSummary);
    }

    @Override
    public Plant insert(Plant p) {
        if (plants.values().stream().anyMatch(x -> x.organizationId() == p.organizationId()
                && x.plantCode().equalsIgnoreCase(p.plantCode()))) {
            throw new DuplicatePlantException(
                    "A plant with the same organizationId and plantCode already exists", null);
        }
        long id = plantIds.getAndIncrement();
        Instant now = Instant.now();
        Plant n = Plant.rehydrate(id, p.organizationId(), p.plantCode(), p.plantName(), p.erpPlantCode(),
                p.countryCode(), p.regionCode(), p.address(), p.timezoneName(), p.languageCode(),
                p.active(), now, now);
        plants.put(id, n);
        return n;
    }

    @Override
    public Optional<Plant> findAggregateById(long id) {
        return Optional.ofNullable(plants.get(id));
    }

    @Override
    public Plant update(Plant p) {
        Instant now = Instant.now();
        Plant n = Plant.rehydrate(p.id(), p.organizationId(), p.plantCode(), p.plantName(), p.erpPlantCode(),
                p.countryCode(), p.regionCode(), p.address(), p.timezoneName(), p.languageCode(),
                p.active(), p.createdAt(), now);
        plants.put(p.id(), n);
        return n;
    }

    @Override
    public boolean delete(long id) {
        return plants.remove(id) != null;
    }

    @Override
    public synchronized Product insert(Product product, AuditContext audit) {
        ensureProductCodeUnique(product, null);
        if (product.defaultItem() && hasActiveDefault(product.baseDoughId(), null)) {
            throw new DefaultProductConflictException(product.baseDoughId());
        }
        long id = productIds.getAndIncrement();
        Instant now = Instant.now();
        Product persisted = persisted(product, id, now, now);
        products.put(id, persisted);
        return persisted;
    }

    @Override
    public Optional<Product> findProductAggregateById(long id) {
        return Optional.ofNullable(products.get(id));
    }

    @Override
    public synchronized Product update(Product previous, Product product, AuditContext audit) {
        ensureProductCodeUnique(product, product.id());
        if (product.defaultItem() && hasActiveDefault(product.baseDoughId(), product.id())) {
            throw new DefaultProductConflictException(product.baseDoughId());
        }
        Product persisted = persisted(product, product.id(), previous.createdAt(), Instant.now());
        products.put(product.id(), persisted);
        return persisted;
    }

    @Override
    public boolean hasActiveDefault(long doughId, Long excludingProductId) {
        return products.values().stream().anyMatch(p -> p.active()
                && p.defaultItem()
                && p.baseDoughId() == doughId
                && (excludingProductId == null || !excludingProductId.equals(p.id())));
    }

    @Override
    public synchronized void recordRejectedAudit(RejectedProductAudit audit) {
        rejectedAudits.add(audit);
    }

    @Override
    public List<ProductSummary> findAll(
            Long organizationId,
            Long plantId,
            Long lineId,
            Long doughId,
            Boolean active,
            Boolean semiFinished,
            String search) {
        String needle = search == null ? null : search.trim().toLowerCase(Locale.ROOT);
        return products.values().stream()
                .filter(p -> organizationId == null || p.organizationId() == organizationId)
                .filter(p -> doughId == null || p.baseDoughId() == doughId)
                .filter(p -> active == null || p.active() == active)
                .filter(p -> semiFinished == null || p.semiFinished() == semiFinished)
                .filter(p -> lineId == null || p.lineConfigurations().stream()
                        .anyMatch(l -> l.lineId() == lineId && l.active()))
                .filter(p -> plantId == null || p.lineConfigurations().stream()
                        .filter(ProductLineConfiguration::active)
                        .map(l -> lines.get(l.lineId()))
                        .anyMatch(l -> l != null && l.plantId() == plantId))
                .filter(p -> needle == null || needle.isBlank()
                        || p.oracleItemCode().toLowerCase(Locale.ROOT).contains(needle)
                        || (p.erpName() != null && p.erpName().toLowerCase(Locale.ROOT).contains(needle))
                        || p.productName().toLowerCase(Locale.ROOT).contains(needle))
                .sorted(Comparator.comparing(Product::productName))
                .map(this::productSummary)
                .toList();
    }

    @Override
    public Optional<ProductSummary> findProductById(long id) {
        return Optional.ofNullable(products.get(id)).map(this::productSummary);
    }

    @Override
    public List<DoughOption> findDoughs(Long organizationId, Long lineId, Boolean active) {
        return doughs.values().stream()
                .filter(d -> organizationId == null || d.organizationId() == organizationId)
                .filter(d -> active == null || d.active() == active)
                .filter(d -> lineId == null || d.organizationId() == lineOrganization(lineId))
                .sorted(Comparator.comparing(DoughOption::doughName))
                .toList();
    }

    @Override
    public Optional<DoughOption> findDoughById(long id) {
        return Optional.ofNullable(doughs.get(id));
    }

    @Override
    public List<ProductionLineOption> findLines(Long plantId, Long organizationId, Boolean active) {
        return lines.values().stream()
                .filter(l -> plantId == null || l.plantId() == plantId)
                .filter(l -> organizationId == null || l.organizationId() == organizationId)
                .filter(l -> active == null || l.active() == active)
                .sorted(Comparator.comparing(ProductionLineOption::lineName))
                .toList();
    }

    @Override
    public Optional<ProductionLineOption> findLineById(long id) {
        return Optional.ofNullable(lines.get(id));
    }

    @Override
    public List<ContainerUomOption> findContainerUoms(Long plantId, String level, Boolean active) {
        return uoms.values().stream()
                .filter(u -> plantId == null || u.plantId() == plantId)
                .filter(u -> level == null || level.isBlank() || u.containerLevel().equalsIgnoreCase(level))
                .filter(u -> active == null || u.active() == active)
                .sorted(Comparator.comparing(ContainerUomOption::displayName))
                .toList();
    }

    @Override
    public Optional<ContainerUomOption> findContainerUomById(long id) {
        return Optional.ofNullable(uoms.get(id));
    }

    @Override
    public void check() {
        // Memory mode is always available.
    }

    private void ensureProductCodeUnique(Product product, Long excludingId) {
        boolean duplicate = products.values().stream().anyMatch(p ->
                p.organizationId() == product.organizationId()
                        && p.oracleItemCode().equalsIgnoreCase(product.oracleItemCode())
                        && (excludingId == null || !excludingId.equals(p.id())));
        if (duplicate) {
            throw new DuplicateProductException(
                    "A product with the same organizationId and oracleItemCode already exists", null);
        }
    }

    private long lineOrganization(long lineId) {
        ProductionLineOption line = lines.get(lineId);
        return line == null ? -1 : line.organizationId();
    }

    private PlantSummary plantSummary(Plant p) {
        return new PlantSummary(p.id(), p.organizationId(), p.plantCode(), p.plantName(), p.erpPlantCode(),
                p.countryCode(), p.regionCode(), p.address(), p.timezoneName(), p.languageCode(),
                p.active(), p.createdAt(), p.updatedAt());
    }

    private Product persisted(Product p, long id, Instant created, Instant updated) {
        return Product.rehydrate(id, p.organizationId(), p.oracleItemCode(), p.erpName(), p.productName(),
                p.completionSubinventory(), p.baseDoughId(), p.defaultItem(), p.semiFinished(),
                p.semiFinishedUom(), p.lidDesignWasteEnabled(), p.lidDesignWasteWeightKg(),
                p.edgeDesignWasteEnabled(), p.edgeDesignWasteWeightKg(), p.active(),
                p.lineConfigurations(), created, updated);
    }

    private ProductSummary productSummary(Product p) {
        DoughOption dough = doughs.get(p.baseDoughId());
        List<ProductLineSummary> configs = p.lineConfigurations().stream()
                .map(this::lineSummary)
                .toList();
        return new ProductSummary(
                p.id(),
                p.organizationId(),
                p.oracleItemCode(),
                p.erpName(),
                p.productName(),
                p.completionSubinventory(),
                p.baseDoughId(),
                dough == null ? null : dough.doughCode(),
                dough == null ? null : dough.doughName(),
                p.defaultItem(),
                p.semiFinished(),
                p.semiFinishedUom(),
                p.lidDesignWasteEnabled(),
                p.lidDesignWasteWeightKg(),
                p.edgeDesignWasteEnabled(),
                p.edgeDesignWasteWeightKg(),
                p.active(),
                configs,
                p.createdAt(),
                p.updatedAt());
    }

    private ProductLineSummary lineSummary(ProductLineConfiguration c) {
        ProductionLineOption line = lines.get(c.lineId());
        ContainerUomOption primary = uoms.get(c.primaryUomId());
        ContainerUomOption secondary = c.secondaryUomId() == null ? null : uoms.get(c.secondaryUomId());
        BigDecimal grams = c.targetWeightPackageKg().multiply(BigDecimal.valueOf(1000));
        return new ProductLineSummary(
                c.lineId(),
                line == null ? 0 : line.plantId(),
                line == null ? null : line.lineCode(),
                line == null ? null : line.lineName(),
                c.integrationItemCode(),
                c.hourlyProductionRate(),
                c.primaryUomId(),
                primary == null ? null : primary.code(),
                primary == null ? null : primary.displayName(),
                c.packagesPerUom(),
                c.piecesPerPackage(),
                c.piecesPerPrimaryContainer(),
                c.secondaryUomId(),
                secondary == null ? null : secondary.code(),
                secondary == null ? null : secondary.displayName(),
                c.uomsPerSecondaryContainer(),
                c.packagesPerSecondaryContainer(),
                c.piecesPerSecondaryContainer(),
                c.targetWeightPackageKg(),
                grams,
                c.active());
    }
}
