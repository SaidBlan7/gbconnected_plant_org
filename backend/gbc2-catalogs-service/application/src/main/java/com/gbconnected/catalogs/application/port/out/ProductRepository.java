package com.gbconnected.catalogs.application.port.out;

import com.gbconnected.catalogs.application.command.AuditContext;
import com.gbconnected.catalogs.application.command.RejectedProductAudit;
import com.gbconnected.catalogs.domain.Product;
import java.util.Optional;

public interface ProductRepository {
    Product insert(Product product, AuditContext audit);
    Optional<Product> findProductAggregateById(long id);
    Product update(Product previous, Product product, AuditContext audit);
    boolean hasActiveDefault(long doughId, Long excludingProductId);
    void recordRejectedAudit(RejectedProductAudit audit);
}
