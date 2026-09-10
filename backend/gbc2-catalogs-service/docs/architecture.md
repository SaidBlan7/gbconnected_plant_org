# Catalogs architecture

```text
GET organization/plant -> QueryPort -> JdbcCatalogQueryAdapter -> core.*
POST/PUT/PATCH/DELETE plant -> PlantCommandUseCase -> Plant domain -> PlantRepository -> core.plant
```

`domain` no depende de Spring, Azure ni JDBC. `application` define casos de uso y puertos. `adapter-postgres` contiene JDBC/Hikari y Lakebase OAuth. `bootstrap` hace el wiring independiente del runtime. App Service y Functions son adaptadores de entrada distintos.
