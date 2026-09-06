package com.gbc.access;

import com.gbc.access.model.PlantCreateRequest;
import com.gbc.access.model.PlantUpdateRequest;
import com.gbc.access.service.MockCoreData;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class MockCoreDataTest {
    @Test
    void supportsPlantCrud() {
        MockCoreData data = new MockCoreData();
        var created = data.create(new PlantCreateRequest(1L,"QRO","Planta Querétaro","México",null,"America/Mexico_City",null,null,"Querétaro","Querétaro",true,"GBC_CONFIGURADOR"), "tester");
        assertThat(data.plant(created.plantId())).isPresent();
        var patched = data.patch(created.plantId(), new PlantUpdateRequest(null,null,"Planta QRO",null,null,null,null,null,null,null,false,null), "tester");
        assertThat(patched).isPresent();
        assertThat(patched.orElseThrow().plantName()).isEqualTo("Planta QRO");
        assertThat(patched.orElseThrow().active()).isFalse();
        assertThat(data.delete(created.plantId())).isTrue();
        assertThat(data.plant(created.plantId())).isEmpty();
    }
}
