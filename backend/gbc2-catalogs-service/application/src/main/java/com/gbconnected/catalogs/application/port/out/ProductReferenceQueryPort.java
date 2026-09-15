package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.application.query.ContainerUomOption;
import com.gbconnected.catalogs.application.query.DoughOption;
import com.gbconnected.catalogs.application.query.ProductionLineOption;
import java.util.List;
import java.util.Optional;

public interface ProductReferenceQueryPort {
    List<DoughOption> findDoughs(Long organizationId, Long lineId, Boolean active);
    Optional<DoughOption> findDoughById(long id);

    List<ProductionLineOption> findLines(Long plantId, Long organizationId, Boolean active);
    Optional<ProductionLineOption> findLineById(long id);

    List<ContainerUomOption> findContainerUoms(Long plantId, String level, Boolean active);
    Optional<ContainerUomOption> findContainerUomById(long id);
}
