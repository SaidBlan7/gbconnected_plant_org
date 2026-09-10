package com.gbconnected.catalogs.bootstrap;
import com.gbconnected.catalogs.adapter.memory.InMemoryCatalogRepository;
import com.gbconnected.catalogs.adapter.postgres.*;
import com.gbconnected.catalogs.application.command.*;
import com.gbconnected.catalogs.application.port.out.*;
import com.zaxxer.hikari.HikariDataSource;
import java.util.Map;
public final class MicroserviceRuntime implements AutoCloseable {
 private final PlantCommandUseCase commands; private final OrganizationQueryPort organizations; private final PlantQueryPort plants; private final DatabaseHealthPort health; private final AutoCloseable closeable;
 private MicroserviceRuntime(PlantCommandUseCase c,OrganizationQueryPort o,PlantQueryPort p,DatabaseHealthPort h,AutoCloseable x){commands=c;organizations=o;plants=p;health=h;closeable=x;}
 public static MicroserviceRuntime fromEnvironment(Map<String,String> env){DatabaseSettings s=DatabaseSettings.from(env); PlantRepository repo; OrganizationQueryPort oq; PlantQueryPort pq; DatabaseHealthPort hp; AutoCloseable close=()->{};
  switch(s.mode()){
   case "memory" -> {var store=new InMemoryCatalogRepository(); repo=store;oq=store;pq=store;hp=store;}
   case "postgres-password" -> {HikariDataSource ds=PooledDataSourceFactory.createPasswordDataSource(s); repo=new JdbcPlantRepository(ds);var q=new JdbcCatalogQueryAdapter(ds);oq=q;pq=q;hp=q;close=ds;}
   case "lakebase-oauth" -> {HikariDataSource ds=PooledDataSourceFactory.createLakebaseOAuthDataSource(s,env); repo=new JdbcPlantRepository(ds);var q=new JdbcCatalogQueryAdapter(ds);oq=q;pq=q;hp=q;close=ds;}
   default -> throw new IllegalArgumentException("Unsupported GBC_PERSISTENCE_MODE: "+s.mode());
  }
  return new MicroserviceRuntime(new PlantCommandService(repo),oq,pq,hp,close);
 }
 public PlantCommandUseCase plantCommands(){return commands;} public OrganizationQueryPort organizations(){return organizations;} public PlantQueryPort plants(){return plants;} public void healthCheck(){health.check();}
 public void close() throws Exception{closeable.close();}
}
