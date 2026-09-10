package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.application.query.OrganizationSummary;

import java.util.*;

public interface OrganizationQueryPort {

    List<OrganizationSummary> findAll(Boolean active);

    Optional<OrganizationSummary> findOrganizationById(long id);
}