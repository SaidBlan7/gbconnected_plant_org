package com.gbconnected.users.functions;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.BindingName;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;
import java.util.Optional;

/** Temporary aliases for consumers of backend(2). Canonical routes are /api/v1/*. */
public class LegacyUserFunctions {
    private final UserFunctions delegate = new UserFunctions();

    @FunctionName("users-me-organizations-legacy")
    public HttpResponseMessage organizations(
            @HttpTrigger(name="req",methods={HttpMethod.GET},route="me/organizations",authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.orgs(request, context);
    }

    @FunctionName("users-me-plants-legacy")
    public HttpResponseMessage plants(
            @HttpTrigger(name="req",methods={HttpMethod.GET},route="me/organizations/{organizationId}/plants",authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, @BindingName("organizationId") String organizationId, ExecutionContext context) {
        return delegate.plants(request, organizationId, context);
    }

    @FunctionName("users-whoami-legacy")
    public HttpResponseMessage whoami(
            @HttpTrigger(name="req",methods={HttpMethod.GET},route="debug/whoami",authLevel=AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.who(request, context);
    }

    @FunctionName("users-health-legacy")
    public HttpResponseMessage health(
            @HttpTrigger(name="req",methods={HttpMethod.GET},route="health/lakebase",authLevel=AuthorizationLevel.ANONYMOUS)
            HttpRequestMessage<Optional<String>> request, ExecutionContext context) {
        return delegate.health(request, context);
    }
}
