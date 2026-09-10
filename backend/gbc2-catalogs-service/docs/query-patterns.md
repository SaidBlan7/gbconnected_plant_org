# Query patterns

Los GET son consultas nivel 1 de la plantilla: runtime -> QueryPort -> proyección SQL. El CRUD de plantas es nivel 3: runtime -> CommandUseCase -> dominio -> Repository. No se rehidrata el agregado para lecturas simples.
