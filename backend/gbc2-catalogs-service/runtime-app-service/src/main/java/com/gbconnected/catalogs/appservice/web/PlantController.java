package com.gbconnected.catalogs.appservice.web;
import com.gbconnected.catalogs.application.PlantNotFoundException; 
import com.gbconnected.catalogs.application.command.*; 
import com.gbconnected.catalogs.application.port.out.PlantQueryPort; 
import com.gbconnected.catalogs.application.query.PlantSummary; 
import jakarta.validation.Valid; 
import java.net.URI; 
import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.*; 
import org.springframework.web.bind.annotation.*;
@RestController
@RequestMapping({"/api/v1/plants","/api/plants"}) 
public class PlantController {
    private final PlantQueryPort q;
    private final PlantCommandUseCase c;
    public PlantController(
        @Qualifier("plants") PlantQueryPort q,
        PlantCommandUseCase c) {
    this.q = q;
    this.c = c;
}
 @GetMapping 
 List<PlantSummary> list(@RequestParam(required=false)Long organizationId,@RequestParam(required=false)Boolean active){
    return q.findAll(organizationId,active);
}
 @GetMapping("/{id}") 
 PlantSummary get(@PathVariable long id){
    return q.findPlantById(id).orElseThrow(()->new PlantNotFoundException(id));
}
 @PostMapping ResponseEntity<PlantHttpResponse> create(@Valid @RequestBody PlantHttpRequest r){
    var p=c.create(new CreatePlantCommand(r.organizationId(),r.plantCode(),r.plantName(),r.erpPlantCode(),r.countryCode(),r.regionCode(),r.address(),r.timezoneName(),r.languageCode(),r.active()==null||r.active()));return ResponseEntity.created(URI.create("/api/v1/plants/"+p.id())).body(PlantHttpResponse.from(p));
}
 @PutMapping("/{id}") PlantHttpResponse replace(@PathVariable long id,@Valid @RequestBody PlantHttpRequest r){
    return PlantHttpResponse.from(c.replace(id,new ReplacePlantCommand(r.organizationId(),r.plantCode(),r.plantName(),r.erpPlantCode(),r.countryCode(),r.regionCode(),r.address(),r.timezoneName(),r.languageCode(),r.active()==null||r.active())));
}
 @PatchMapping("/{id}") PlantHttpResponse patch(@PathVariable long id,@Valid @RequestBody PatchPlantHttpRequest r){
    return PlantHttpResponse.from(c.patch(id,new PatchPlantCommand(r.organizationId(),r.plantCode(),r.plantName(),r.erpPlantCode(),r.countryCode(),r.regionCode(),r.address(),r.timezoneName(),r.languageCode(),r.active())));
}
 @DeleteMapping("/{id}") ResponseEntity<Void> delete(@PathVariable long id){
    c.delete(id);return ResponseEntity.noContent().build();
}
}
