package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.application.query.ProductSummary;
import java.util.List;
import java.util.Optional;

public interface ProductQueryPort {
    List<ProductSummary> findAll(
            Long organizationId,
            Long plantId,
            Long lineId,
            Long doughId,
            Boolean active,
            Boolean semiFinished,
            String search);

    Optional<ProductSummary> findProductById(long id);
}
