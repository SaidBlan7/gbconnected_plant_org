package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.application.command.AuditContext;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.MDC;
import org.springframework.security.core.Authentication;

final class RequestAuditContext {
    private static final String SOURCE_HEADER = "X-GBC-Source-Type";
    private static final String ACTOR_HEADER = "X-GBC-Actor";

    private RequestAuditContext() {}

    static AuditContext from(Authentication authentication, HttpServletRequest request) {
        String actor = null;
        if (authentication != null
                && authentication.isAuthenticated()
                && authentication.getName() != null
                && !"anonymousUser".equals(authentication.getName())) {
            actor = authentication.getName();
        }
        if (actor == null || actor.isBlank()) actor = request.getHeader(ACTOR_HEADER);
        if (actor == null || actor.isBlank()) actor = "LOCAL_DEV";

        String source = request.getHeader(SOURCE_HEADER);
        String correlationId = MDC.get("correlationId");
        return new AuditContext(source, actor, correlationId);
    }
}
