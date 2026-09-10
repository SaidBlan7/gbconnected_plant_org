package com.gbconnected.catalogs.domain;

import java.time.Instant;

public final class Plant {
    private final Long id;
    private final long organizationId;
    private final String plantCode;
    private final String plantName;
    private final String erpPlantCode;
    private final String countryCode;
    private final String regionCode;
    private final String address;
    private final String timezoneName;
    private final String languageCode;
    private final boolean active;
    private final Instant createdAt;
    private final Instant updatedAt;

    private Plant(Long id,long organizationId,String plantCode,String plantName,String erpPlantCode,String countryCode,String regionCode,String address,String timezoneName,String languageCode,boolean active,Instant createdAt,Instant updatedAt){
        if(organizationId<=0) throw new DomainValidationException("organizationId must be positive");
        this.id=id; this.organizationId=organizationId; this.plantCode=req(plantCode,"plantCode",50); this.plantName=req(plantName,"plantName",200);
        this.erpPlantCode=opt(erpPlantCode,100); this.countryCode=opt(countryCode,20); this.regionCode=opt(regionCode,50); this.address=opt(address,500);
        this.timezoneName=req(timezoneName,"timezoneName",100); this.languageCode=opt(languageCode,20); this.active=active;
        this.createdAt=createdAt; this.updatedAt=updatedAt;
    }
    public static Plant create(long organizationId,String plantCode,String plantName,String erpPlantCode,String countryCode,String regionCode,String address,String timezoneName,String languageCode,boolean active){
        return new Plant(null,organizationId,plantCode,plantName,erpPlantCode,countryCode,regionCode,address,timezoneName,languageCode,active,null,null);
    }
    public static Plant rehydrate(long id,long organizationId,String plantCode,String plantName,String erpPlantCode,String countryCode,String regionCode,String address,String timezoneName,String languageCode,boolean active,Instant createdAt,Instant updatedAt){
        return new Plant(id,organizationId,plantCode,plantName,erpPlantCode,countryCode,regionCode,address,timezoneName,languageCode,active,createdAt,updatedAt);
    }
    public Plant replace(long organizationId,String plantCode,String plantName,String erpPlantCode,String countryCode,String regionCode,String address,String timezoneName,String languageCode,boolean active){
        requirePersistent(); return new Plant(id,organizationId,plantCode,plantName,erpPlantCode,countryCode,regionCode,address,timezoneName,languageCode,active,createdAt,updatedAt);
    }
    public Plant patch(Long organizationId,String plantCode,String plantName,String erpPlantCode,String countryCode,String regionCode,String address,String timezoneName,String languageCode,Boolean active){
        requirePersistent(); return new Plant(id, organizationId==null?this.organizationId:organizationId, plantCode==null?this.plantCode:plantCode, plantName==null?this.plantName:plantName,
          erpPlantCode==null?this.erpPlantCode:erpPlantCode, countryCode==null?this.countryCode:countryCode, regionCode==null?this.regionCode:regionCode, address==null?this.address:address,
          timezoneName==null?this.timezoneName:timezoneName, languageCode==null?this.languageCode:languageCode, active==null?this.active:active, createdAt, updatedAt);
    }
    private void requirePersistent(){ if(id==null) throw new IllegalStateException("Plant must be persisted first"); }
    private static String req(String v,String field,int max){ if(v==null||v.isBlank()) throw new DomainValidationException(field+" is required"); String n=v.trim(); if(n.length()>max) throw new DomainValidationException(field+" exceeds "+max+" characters"); return n; }
    private static String opt(String v,int max){ if(v==null) return null; String n=v.trim(); if(n.isEmpty()) return null; if(n.length()>max) throw new DomainValidationException("value exceeds "+max+" characters"); return n; }
    public Long id(){return id;} public long organizationId(){return organizationId;} public String plantCode(){return plantCode;} public String plantName(){return plantName;} public String erpPlantCode(){return erpPlantCode;} public String countryCode(){return countryCode;} public String regionCode(){return regionCode;} public String address(){return address;} public String timezoneName(){return timezoneName;} public String languageCode(){return languageCode;} public boolean active(){return active;} public Instant createdAt(){return createdAt;} public Instant updatedAt(){return updatedAt;}
}
