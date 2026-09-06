package com.gbc.access.functions;

import com.gbc.access.service.PlantCrudService;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Optional;

@Component
public class CoreOrganizationsFunction {
    private final PlantCrudService service;
    public CoreOrganizationsFunction(PlantCrudService service){this.service=service;}

    @FunctionName("listCoreOrganizations")
    public HttpResponseMessage execute(
            @HttpTrigger(name="request", methods={HttpMethod.GET}, authLevel=AuthorizationLevel.ANONYMOUS, route="organizations")
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context) {
        try {
            Boolean active = parseBoolean(request.getQueryParameters().get("active"));
            return request.createResponseBuilder(HttpStatus.OK).header("Content-Type","application/json").body(service.organizations(active)).build();
        } catch (IllegalArgumentException ex) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body(Map.of("error",ex.getMessage())).build();
        } catch (Exception ex) {
            context.getLogger().severe("Organizations CRUD read error: "+ex.getMessage());
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error","Unable to load core organizations")).build();
        }
    }

    @FunctionName("getCoreOrganizationById")
    public HttpResponseMessage byId(
            @HttpTrigger(name="request", methods={HttpMethod.GET}, authLevel=AuthorizationLevel.ANONYMOUS, route="organizations/{organizationId}")
            HttpRequestMessage<Optional<String>> request,
            @BindingName("organizationId") String organizationId,
            ExecutionContext context) {
        try {
            long id = Long.parseLong(organizationId);
            return service.organization(id)
                    .map(value -> request.createResponseBuilder(HttpStatus.OK).header("Content-Type","application/json").body(value).build())
                    .orElseGet(() -> request.createResponseBuilder(HttpStatus.NOT_FOUND).body(Map.of("error","Organization not found")).build());
        } catch (NumberFormatException ex) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body(Map.of("error","organizationId must be numeric")).build();
        } catch (Exception ex) {
            context.getLogger().severe("Organization by-id error: " + ex.getMessage());
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error","Unable to load core organization")).build();
        }
    }

    private Boolean parseBoolean(String value){
        if(value==null||value.isBlank()) return null;
        if("true".equalsIgnoreCase(value)) return true;
        if("false".equalsIgnoreCase(value)) return false;
        throw new IllegalArgumentException("active must be true or false");
    }
}
