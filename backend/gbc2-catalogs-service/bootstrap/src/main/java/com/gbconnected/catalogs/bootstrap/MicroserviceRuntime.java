package com.gbconnected.catalogs.bootstrap;

import com.gbconnected.catalogs.adapter.memory.InMemoryCatalogRepository;
import com.gbconnected.catalogs.adapter.postgres.DatabaseSettings;
import com.gbconnected.catalogs.adapter.postgres.JdbcCatalogQueryAdapter;
import com.gbconnected.catalogs.adapter.postgres.JdbcPlantRepository;
import com.gbconnected.catalogs.adapter.postgres.JdbcProductQueryAdapter;
import com.gbconnected.catalogs.adapter.postgres.JdbcProductRepository;
import com.gbconnected.catalogs.adapter.postgres.PooledDataSourceFactory;
import com.gbconnected.catalogs.application.command.PlantCommandService;
import com.gbconnected.catalogs.application.command.PlantCommandUseCase;
import com.gbconnected.catalogs.application.command.ProductCommandService;
import com.gbconnected.catalogs.application.command.ProductCommandUseCase;
import com.gbconnected.catalogs.application.port.out.DatabaseHealthPort;
import com.gbconnected.catalogs.application.port.out.OrganizationQueryPort;
import com.gbconnected.catalogs.application.port.out.PlantQueryPort;
import com.gbconnected.catalogs.application.port.out.PlantRepository;
import com.gbconnected.catalogs.application.port.out.ProductQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductReferenceQueryPort;
import com.gbconnected.catalogs.application.port.out.ProductRepository;
import com.zaxxer.hikari.HikariDataSource;
import java.util.Map;

public final class MicroserviceRuntime implements AutoCloseable {
    private final PlantCommandUseCase plantCommands;
    private final ProductCommandUseCase productCommands;
    private final OrganizationQueryPort organizations;
    private final PlantQueryPort plants;
    private final ProductQueryPort products;
    private final ProductReferenceQueryPort productReferences;
    private final DatabaseHealthPort health;
    private final AutoCloseable closeable;

    private MicroserviceRuntime(
            PlantCommandUseCase plantCommands,
            ProductCommandUseCase productCommands,
            OrganizationQueryPort organizations,
            PlantQueryPort plants,
            ProductQueryPort products,
            ProductReferenceQueryPort productReferences,
            DatabaseHealthPort health,
            AutoCloseable closeable) {
        this.plantCommands = plantCommands;
        this.productCommands = productCommands;
        this.organizations = organizations;
        this.plants = plants;
        this.products = products;
        this.productReferences = productReferences;
        this.health = health;
        this.closeable = closeable;
    }

    public static MicroserviceRuntime fromEnvironment(Map<String, String> env) {
        DatabaseSettings settings = DatabaseSettings.from(env);
        PlantRepository plantRepository;
        ProductRepository productRepository;
        OrganizationQueryPort organizationQueries;
        PlantQueryPort plantQueries;
        ProductQueryPort productQueries;
        ProductReferenceQueryPort referenceQueries;
        DatabaseHealthPort health;
        AutoCloseable closeable = () -> {};

        switch (settings.mode()) {
            case "memory" -> {
                var store = new InMemoryCatalogRepository();
                plantRepository = store;
                productRepository = store;
                organizationQueries = store;
                plantQueries = store;
                productQueries = store;
                referenceQueries = store;
                health = store;
            }
            case "postgres-password" -> {
                HikariDataSource dataSource = PooledDataSourceFactory.createPasswordDataSource(settings);
                plantRepository = new JdbcPlantRepository(dataSource);
                productRepository = new JdbcProductRepository(dataSource);
                var catalogQueries = new JdbcCatalogQueryAdapter(dataSource);
                var productCatalogQueries = new JdbcProductQueryAdapter(dataSource);
                organizationQueries = catalogQueries;
                plantQueries = catalogQueries;
                productQueries = productCatalogQueries;
                referenceQueries = productCatalogQueries;
                health = catalogQueries;
                closeable = dataSource;
            }
            case "lakebase-oauth" -> {
                HikariDataSource dataSource = PooledDataSourceFactory.createLakebaseOAuthDataSource(settings, env);
                plantRepository = new JdbcPlantRepository(dataSource);
                productRepository = new JdbcProductRepository(dataSource);
                var catalogQueries = new JdbcCatalogQueryAdapter(dataSource);
                var productCatalogQueries = new JdbcProductQueryAdapter(dataSource);
                organizationQueries = catalogQueries;
                plantQueries = catalogQueries;
                productQueries = productCatalogQueries;
                referenceQueries = productCatalogQueries;
                health = catalogQueries;
                closeable = dataSource;
            }
            default -> throw new IllegalArgumentException(
                    "Unsupported GBC_PERSISTENCE_MODE: " + settings.mode());
        }

        return new MicroserviceRuntime(
                new PlantCommandService(plantRepository),
                new ProductCommandService(productRepository, referenceQueries),
                organizationQueries,
                plantQueries,
                productQueries,
                referenceQueries,
                health,
                closeable);
    }

    public PlantCommandUseCase plantCommands() { return plantCommands; }
    public ProductCommandUseCase productCommands() { return productCommands; }
    public OrganizationQueryPort organizations() { return organizations; }
    public PlantQueryPort plants() { return plants; }
    public ProductQueryPort products() { return products; }
    public ProductReferenceQueryPort productReferences() { return productReferences; }
    public void healthCheck() { health.check(); }

    @Override
    public void close() throws Exception {
        closeable.close();
    }
}
