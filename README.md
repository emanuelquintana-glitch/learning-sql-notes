# Learning SQL Notes

Notas de estudio de SQL siguiendo dos libros principales.

## Libros

| Libro | Autor | Año |
|-------|-------|-----|
| Learning SQL | Alan Beaulieu | 2020 |
| SQL Queries for Mere Mortals | John Viescas | 2018 |

## Estructura

```
org/          ← symlinks a ~/org/libros/ (fuente de verdad en org-roam)
src/sql/      ← código SQL por capítulo y libro
exercises/    ← ejercicios resueltos
docs/         ← exports Quarto (HTML/PDF)
latex/        ← notas en LaTeX
databases/    ← bases de datos de práctica
scripts/      ← scripts de sincronización y export
```

## Flujo de trabajo

1. Leer PDF en Emacs → anotar con `, n a`
2. Notas se guardan en `~/org/libros/Lenguajes_de_Programacion/`
3. Symlinks en `org/` apuntan a esos archivos
4. `bash scripts/sync_org.sh` exporta `.org → .qmd`
5. `quarto render docs/` genera HTML/PDF

## Sincronización

```bash
bash scripts/sync_org.sh      # exportar org → qmd
bash scripts/export_latex.sh  # exportar org → tex
```
