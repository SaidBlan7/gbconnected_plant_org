package com.gbconnected.catalogs.functions;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.BindingName;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;
import java.util.Optional;

public class LegacyCatalogFunctions {
    private final CatalogFunctions delegate = new CatalogFunctions();

    @FunctionName("catalogs-organizations-list-legacy")
    public HttpResponseMessage organizations(
            @HttpTrigger(name="req", methods={HttpMethod.GET}, route="organizations", authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.organizations(request, context);
    }

    @FunctionName("catalogs-organizations-get-legacy")
    public HttpResponseMessage organization(
            @HttpTrigger(name="req", methods={HttpMethod.GET}, route="organizations/{id}", authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, @BindingName("id") String id, ExecutionContext context) {
        return delegate.organization(request, id, context);
    }

    @FunctionName("catalogs-plants-list-create-legacy")
    public HttpResponseMessage plants(
            @HttpTrigger(name="req", methods={HttpMethod.GET,HttpMethod.POST}, route="plants", authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.plants(request, context);
    }

    @FunctionName("catalogs-plants-by-id-legacy")
    public HttpResponseMessage plant(
            @HttpTrigger(name="req", methods={HttpMethod.GET,HttpMethod.PUT,HttpMethod.PATCH,HttpMethod.DELETE}, route="plants/{id}", authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, @BindingName("id") String id, ExecutionContext context) {
        return delegate.plant(request, id, context);
    }

    @FunctionName("catalogs-health-legacy")
    public HttpResponseMessage health(
            @HttpTrigger(name="req", methods={HttpMethod.GET}, route="health/lakebase", authLevel=AuthorizationLevel.ANONYMOUS)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.health(request, context);
    }
}
