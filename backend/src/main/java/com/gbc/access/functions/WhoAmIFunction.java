package com.gbc.access.functions;

import com.gbc.access.model.CallerIdentity;
import com.gbc.access.security.CallerIdentityResolver;
import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Optional;

@Component
public class WhoAmIFunction {

    @Autowired
    private CallerIdentityResolver identityResolver;

    @FunctionName("whoAmI")
    public HttpResponseMessage execute(
            @HttpTrigger(
                    name = "request",
                    methods = {HttpMethod.GET},
                    authLevel = AuthorizationLevel.ANONYMOUS,
                    route = "debug/whoami"
            ) HttpRequestMessage<Optional<String>> request,
            ExecutionContext context
    ) {
        try {
            CallerIdentity user = identityResolver.resolve(request);
            return request.createResponseBuilder(HttpStatus.OK)
                    .header("Content-Type", "application/json")
                    .body(user)
                    .build();
        } catch (SecurityException ex) {
            return request.createResponseBuilder(HttpStatus.UNAUTHORIZED)
                    .header("Content-Type", "application/json")
                    .body(Map.of("error", "Unauthorized"))
                    .build();
        } catch (Exception ex) {
            context.getLogger().severe("WhoAmI error: " + ex.getMessage());
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Unable to resolve identity"))
                    .build();
        }
    }
}
