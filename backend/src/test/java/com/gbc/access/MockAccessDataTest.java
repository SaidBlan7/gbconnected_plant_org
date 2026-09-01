package com.gbc.access;

import com.gbc.access.service.MockAccessData;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class MockAccessDataTest {

    @Test
    void demoUserOnlySeesMexicoAndAssignedPlants() {
        MockAccessData data = new MockAccessData();
        String tid = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa";
        String oid = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb";

        assertThat(data.getOrganizations(tid, oid))
                .extracting("id")
                .containsExactly("org-mx");

        assertThat(data.getPlants(tid, oid, "org-mx"))
                .extracting("id")
                .containsExactly("plant-tol", "plant-pue");

        assertThat(data.getPlants(tid, oid, "org-us")).isEmpty();
    }
}
