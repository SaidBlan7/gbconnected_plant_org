package com.gbconnected.users.appservice.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.UUID;

import org.slf4j.MDC;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class CorrelationIdFilter extends OncePerRequestFilter {

    protected void doFilterInternal(
            HttpServletRequest q,
            HttpServletResponse p,
            FilterChain c
    ) throws ServletException, IOException {

        String id = q.getHeader("X-Correlation-Id");

        if (id == null || id.isBlank()) {
            id = UUID.randomUUID().toString();
        }

        p.setHeader("X-Correlation-Id", id);
        MDC.put("correlationId", id);

        try {
            c.doFilter(q, p);
        } finally {
            MDC.remove("correlationId");
        }
    }
}