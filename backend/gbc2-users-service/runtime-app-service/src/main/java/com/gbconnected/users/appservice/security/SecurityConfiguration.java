package com.gbconnected.users.appservice.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {

    @Bean
    SecurityFilterChain chain(
            HttpSecurity h,
            @Value("${gbc.security.enabled:false}") boolean e
    ) throws Exception {

        h.csrf(c -> c.disable());

        if (!e) {
            return h
                    .authorizeHttpRequests(a -> a.anyRequest().permitAll())
                    .build();
        }

        h.authorizeHttpRequests(a -> a
                .requestMatchers(
                        "/actuator/health/**",
                        "/actuator/info",
                        "/api/v1/health/**",
                        "/api/health/**"
                ).permitAll()
                .requestMatchers(
                        "/api/v1/me/**",
                        "/api/v1/debug/whoami",
                        "/api/me/**",
                        "/api/debug/whoami"
                ).authenticated()
                .anyRequest().denyAll()
        );

        h.oauth2ResourceServer(o -> o.jwt(j -> {}));
        h.httpBasic(x -> x.disable());
        h.formLogin(x -> x.disable());

        return h.build();
    }
}