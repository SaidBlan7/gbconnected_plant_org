package com.gbconnected.users.appservice.config;

import com.gbconnected.users.application.query.UserAccessQueryService;
import com.gbconnected.users.bootstrap.MicroserviceRuntime;

import org.springframework.context.annotation.*;

@Configuration
public class ApplicationWiring {

    @Bean(destroyMethod = "close")
    MicroserviceRuntime runtime() {
        return MicroserviceRuntime.fromEnvironment(System.getenv());
    }

    @Bean
    UserAccessQueryService access(MicroserviceRuntime r) {
        return r.userAccess();
    }
}