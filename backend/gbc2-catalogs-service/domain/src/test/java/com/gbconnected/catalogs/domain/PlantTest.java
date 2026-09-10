package com.gbconnected.catalogs.domain;
import static org.junit.jupiter.api.Assertions.*; import org.junit.jupiter.api.Test;
class PlantTest { @Test void createsValidPlant(){var p=Plant.create(1,"TOL","Planta Toluca",null,"MX",null,null,"America/Mexico_City","es-MX",true);assertEquals("TOL",p.plantCode());assertTrue(p.active());} @Test void rejectsMissingTimezone(){assertThrows(DomainValidationException.class,()->Plant.create(1,"TOL","Toluca",null,"MX",null,null," ",null,true));}}
