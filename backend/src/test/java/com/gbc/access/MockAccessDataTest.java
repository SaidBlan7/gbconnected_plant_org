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
                .containsExactly("1");

        assertThat(data.getPlants(tid, oid, "1"))
                .extracting("id")
                .containsExactly("1", "2");

        assertThat(data.getPlants(tid, oid, "org-us")).isEmpty();
    }
}
