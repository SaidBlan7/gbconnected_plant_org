package com.gbconnected.users.application.query;

import com.gbconnected.users.application.port.out.UserAccessQueryPort;
import com.gbconnected.users.domain.UserIdentity;

import java.util.*;

public final class UserAccessQueryService {

    private final UserAccessQueryPort q;

    public UserAccessQueryService(UserAccessQueryPort q) {
        this.q = Objects.requireNonNull(q);
    }

    public List<UserOrganizationSummary> organizations(UserIdentity u) {
        Objects.requireNonNull(u);

        return q.organizations(
                u.tenantId(),
                u.objectId()
        );
    }

    public List<UserPlantSummary> plants(
            UserIdentity u,
            long organizationId
    ) {
        Objects.requireNonNull(u);

        if (organizationId <= 0) {
            throw new IllegalArgumentException(
                    "organizationId must be positive"
            );
        }

        return q.plants(
                u.tenantId(),
                u.objectId(),
                organizationId
        );
    }
}