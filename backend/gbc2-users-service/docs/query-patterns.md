# Query patterns

Usuarios es actualmente query-only. Las lecturas de permisos usan un QueryService pequeño porque combinan la identidad del caller con el puerto de acceso. No existe command-side todavía porque `backend(2)` no incluía alta/baja de asignaciones de usuario.
