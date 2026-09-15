package com.gbconnected.catalogs.appservice.web;

import com.gbconnected.catalogs.application.port.out.ProductReferenceQueryPort;
import com.gbconnected.catalogs.application.query.ContainerUomOption;
import com.gbconnected.catalogs.application.query.DoughOption;
import com.gbconnected.catalogs.application.query.ProductionLineOption;
import java.util.List;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class ProductReferenceController {
    private final ProductReferenceQueryPort references;

    public ProductReferenceController(@Qualifier("productReferences") ProductReferenceQueryPort references) {
        this.references = references;
    }

    @GetMapping("/doughs")
    List<DoughOption> doughs(
            @RequestParam(required = false) Long organizationId,
            @RequestParam(required = false) Long lineId,
            @RequestParam(required = false) Boolean active) {
        return references.findDoughs(organizationId, lineId, active);
    }

    @GetMapping("/production-lines")
    List<ProductionLineOption> lines(
            @RequestParam(required = false) Long plantId,
            @RequestParam(required = false) Long organizationId,
            @RequestParam(required = false) Boolean active) {
        return references.findLines(plantId, organizationId, active);
    }

    @GetMapping("/container-uoms")
    List<ContainerUomOption> containerUoms(
            @RequestParam(required = false) Long plantId,
            @RequestParam(required = false) String level,
            @RequestParam(required = false) Boolean active) {
        return references.findContainerUoms(plantId, level, active);
    }
}
