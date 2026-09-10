package com.gbconnected.users.appservice.web;

import jakarta.servlet.http.HttpServletRequest;

import java.net.URI;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

@RestControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler({IllegalArgumentException.class})
    ProblemDetail bad(Exception e, HttpServletRequest r) {
        return p(
                HttpStatus.BAD_REQUEST,
                "Invalid request",
                e.getMessage(),
                r
        );
    }

    @ExceptionHandler(SecurityException.class)
    ProblemDetail unauth(Exception e, HttpServletRequest r) {
        return p(
                HttpStatus.UNAUTHORIZED,
                "Unauthorized",
                "Unable to resolve caller identity",
                r
        );
    }

    private ProblemDetail p(
            HttpStatus s,
            String t,
            String d,
            HttpServletRequest r
    ) {
        ProblemDetail p = ProblemDetail.forStatusAndDetail(s, d);

        p.setTitle(t);
        p.setType(URI.create("urn:gbc2:error:" + s.value()));
        p.setProperty("path", r.getRequestURI());

        return p;
    }
}