# Users architecture

```text
HTTP identity -> UserIdentity
GET /me/organizations -> UserAccessQueryService -> UserAccessQueryPort -> JDBC join app_security + core
GET /me/.../plants  -> UserAccessQueryService -> UserAccessQueryPort -> JDBC join app_security + core
```

El dominio no conoce HTTP, Entra, Spring, Azure ni JDBC. La resolución concreta de identidad vive en cada runtime de entrada. La lectura de permisos vive en el adaptador PostgreSQL/Lakebase.
