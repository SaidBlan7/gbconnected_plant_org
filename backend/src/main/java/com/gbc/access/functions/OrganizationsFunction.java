package com.gbc.access.functions;

import com.gbc.access.model.CallerIdentity;
import com.gbc.access.security.CallerIdentityResolver;
import com.gbc.access.service.AccessService;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Optional;

@Component
public class OrganizationsFunction {

    @Autowired
    private CallerIdentityResolver identityResolver;

    @Autowired
    private AccessService accessService;

    @FunctionName("getMyOrganizations")
    public HttpResponseMessage execute(
            @HttpTrigger(
                    name = "request",
                    methods = {HttpMethod.GET},
                    authLevel = AuthorizationLevel.ANONYMOUS,
                    route = "me/organizations"
            ) HttpRequestMessage<Optional<String>> request,
            ExecutionContext context
    ) {
        try {
            CallerIdentity user = identityResolver.resolve(request);
            var organizations = accessService.getOrganizations(user.tenantId(), user.objectId());

            return request.createResponseBuilder(HttpStatus.OK)
                    .header("Content-Type", "application/json")
                    .body(organizations)
                    .build();
        } catch (SecurityException ex) {
            return request.createResponseBuilder(HttpStatus.UNAUTHORIZED)
                    .header("Content-Type", "application/json")
                    .body(Map.of("error", "Unauthorized"))
                    .build();
        } catch (Exception ex) {
            context.getLogger().severe("Organizations error: " + ex.getMessage());
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .header("Content-Type", "application/json")
                    .body(Map.of("error", "Unable to load organizations"))
                    .build();
        }
    }
}
