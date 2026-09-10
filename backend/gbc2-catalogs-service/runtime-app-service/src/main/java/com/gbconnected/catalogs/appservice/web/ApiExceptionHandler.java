package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.application.*;
import com.gbconnected.catalogs.domain.DomainValidationException;

import jakarta.servlet.http.HttpServletRequest;

import java.net.URI;

import org.springframework.http.*;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

@RestControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler({
            PlantNotFoundException.class,
            OrganizationNotFoundException.class
    })
    ProblemDetail nf(RuntimeException e, HttpServletRequest r) {
        return p(
                HttpStatus.NOT_FOUND,
                "Resource not found",
                e.getMessage(),
                r
        );
    }

    @ExceptionHandler({
            DomainValidationException.class,
            MethodArgumentNotValidException.class,
            IllegalArgumentException.class
    })
    ProblemDetail bad(Exception e, HttpServletRequest r) {
        return p(
                HttpStatus.BAD_REQUEST,
                "Invalid request",
                e.getMessage(),
                r
        );
    }

    @ExceptionHandler(DuplicatePlantException.class)
    ProblemDetail dup(Exception e, HttpServletRequest r) {
        return p(
                HttpStatus.CONFLICT,
                "Duplicate plant",
                e.getMessage(),
                r
        );
    }

    private ProblemDetail p(
            HttpStatus s,
            String t,
            String d,
            HttpServletRequest r
    ) {
        ProblemDetail p = ProblemDetail.forStatusAndDetail(
                s,
                d == null ? "Request failed" : d
        );

        p.setTitle(t);
        p.setType(URI.create("urn:gbc2:error:" + s.value()));
        p.setProperty("path", r.getRequestURI());

        return p;
    }
}