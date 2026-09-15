package com.gbconnected.catalogs.application.command;

import com.gbconnected.catalogs.domain.Product;

public interface ProductCommandUseCase {
    Product create(CreateProductCommand command);
    Product replace(long id, ReplaceProductCommand command);
    Product patch(long id, PatchProductCommand command);
}
