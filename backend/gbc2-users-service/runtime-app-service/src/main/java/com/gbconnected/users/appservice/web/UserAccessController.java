package com.gbconnected.users.appservice.web;

import com.gbconnected.users.appservice.security.CallerIdentityResolver;
import com.gbconnected.users.application.query.*;
import com.gbconnected.users.domain.UserIdentity;

import java.util.*;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping({"/api/v1", "/api"})
public class UserAccessController {

    private final UserAccessQueryService q;
    private final CallerIdentityResolver ids;

    public UserAccessController(
            UserAccessQueryService q,
            CallerIdentityResolver ids
    ) {
        this.q = q;
        this.ids = ids;
    }

    @GetMapping("/me/organizations")
    List<UserOrganizationSummary> orgs(Authentication a) {
        return q.organizations(ids.resolve(a));
    }

    @GetMapping("/me/organizations/{organizationId}/plants")
    List<UserPlantSummary> plants(
            @PathVariable long organizationId,
            Authentication a
    ) {
        return q.plants(
                ids.resolve(a),
                organizationId
        );
    }

    @GetMapping("/debug/whoami")
    UserIdentity who(Authentication a) {
        return ids.resolve(a);
    }
}