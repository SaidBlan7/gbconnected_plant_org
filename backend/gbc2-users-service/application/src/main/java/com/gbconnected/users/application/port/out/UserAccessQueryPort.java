package com.gbconnected.users.application.port.out;

import com.gbconnected.users.application.query.*;

import java.util.*;
import java.util.UUID;

public interface UserAccessQueryPort {

    List<UserOrganizationSummary> organizations(
            UUID tenantId,
            UUID objectId
    );

    List<UserPlantSummary> plants(
            UUID tenantId,
            UUID objectId,
            long organizationId
    );
}