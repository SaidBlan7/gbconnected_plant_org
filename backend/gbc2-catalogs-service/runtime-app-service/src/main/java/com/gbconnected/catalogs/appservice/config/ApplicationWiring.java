package com.gbconnected.catalogs.appservice.config;

import com.gbconnected.catalogs.application.command.PlantCommandUseCase;
import com.gbconnected.catalogs.application.port.out.OrganizationQueryPort;
import com.gbconnected.catalogs.application.port.out.PlantQueryPort;
import com.gbconnected.catalogs.bootstrap.MicroserviceRuntime;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ApplicationWiring {

    @Bean(destroyMethod = "close")
    MicroserviceRuntime runtime() {
        return MicroserviceRuntime.fromEnvironment(System.getenv());
    }

    @Bean
    PlantCommandUseCase plantCommands(MicroserviceRuntime runtime) {
        return runtime.plantCommands();
    }

    @Bean("organizations")
    OrganizationQueryPort organizations(MicroserviceRuntime runtime) {
        return runtime.organizations();
    }

    @Bean("plants")
    PlantQueryPort plants(MicroserviceRuntime runtime) {
        return runtime.plants();
    }
}