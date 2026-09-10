package com.gbconnected.catalogs.appservice.web;
import com.gbconnected.catalogs.application.OrganizationNotFoundException; 
import com.gbconnected.catalogs.application.port.out.OrganizationQueryPort; 
import com.gbconnected.catalogs.application.query.OrganizationSummary; 
import java.util.List; 
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Qualifier;
@RestController 
@RequestMapping({"/api/v1/organizations","/api/organizations"}) 
public class OrganizationController {
    private final OrganizationQueryPort q;
    public OrganizationController(
        @Qualifier("organizations") OrganizationQueryPort q) {
    this.q = q;
}
    @GetMapping 
    List<OrganizationSummary> list(@RequestParam(required=false)Boolean active){
        return q.findAll(active);
    }
    @GetMapping("/{id}") 
    OrganizationSummary get(@PathVariable long id){
        return q.findOrganizationById(id).orElseThrow(()->new OrganizationNotFoundException(id));}
    }
