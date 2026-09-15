package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.application.CatalogReferenceException;
import com.gbconnected.catalogs.application.DefaultProductConflictException;
import com.gbconnected.catalogs.application.DuplicatePlantException;
import com.gbconnected.catalogs.application.DuplicateProductException;
import com.gbconnected.catalogs.application.OrganizationNotFoundException;
import com.gbconnected.catalogs.application.PlantNotFoundException;
import com.gbconnected.catalogs.application.ProductNotFoundException;
import com.gbconnected.catalogs.domain.DomainValidationException;
import jakarta.servlet.http.HttpServletRequest;
import java.net.URI;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler({
            PlantNotFoundException.class,
            OrganizationNotFoundException.class,
            ProductNotFoundException.class
    })
    ProblemDetail notFound(RuntimeException exception, HttpServletRequest request) {
        return problem(HttpStatus.NOT_FOUND, "Resource not found", exception.getMessage(), request);
    }

    @ExceptionHandler({
            DomainValidationException.class,
            CatalogReferenceException.class,
            MethodArgumentNotValidException.class,
            IllegalArgumentException.class
    })
    ProblemDetail badRequest(Exception exception, HttpServletRequest request) {
        return problem(HttpStatus.BAD_REQUEST, "Invalid request", exception.getMessage(), request);
    }

    @ExceptionHandler(DuplicatePlantException.class)
    ProblemDetail duplicatePlant(Exception exception, HttpServletRequest request) {
        return problem(HttpStatus.CONFLICT, "Duplicate plant", exception.getMessage(), request);
    }

    @ExceptionHandler(DuplicateProductException.class)
    ProblemDetail duplicateProduct(Exception exception, HttpServletRequest request) {
        return problem(HttpStatus.CONFLICT, "Duplicate product", exception.getMessage(), request);
    }

    @ExceptionHandler(DefaultProductConflictException.class)
    ProblemDetail defaultConflict(Exception exception, HttpServletRequest request) {
        return problem(HttpStatus.CONFLICT, "Default product conflict", exception.getMessage(), request);
    }

    private ProblemDetail problem(
            HttpStatus status,
            String title,
            String detail,
            HttpServletRequest request) {
        ProblemDetail problem = ProblemDetail.forStatusAndDetail(
                status,
                detail == null ? "Request failed" : detail);
        problem.setTitle(title);
        problem.setType(URI.create("urn:gbc2:error:" + status.value()));
        problem.setProperty("path", request.getRequestURI());
        return problem;
    }
}
