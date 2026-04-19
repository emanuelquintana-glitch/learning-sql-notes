#!/usr/bin/env bash
# ============================================================
# reorganizar_sql_repo.sh
# Reorganiza learning-sql-notes y conecta con ~/org/libros/
# Ejecutar desde: ~/repos/github/learning-sql-notes/
# ============================================================
set -e

REPO="$(pwd)"
ORG_LIBROS="$HOME/org/libros/Lenguajes_de_Programacion"
LEARNING_SQL_ORG="$ORG_LIBROS/learning-sql-generate-manipulate-and-retrieve-data.org"
MERE_MORTALS_ORG="$ORG_LIBROS/sql-queries-for-mere-mortals-pearson-ucertify-course-access.org"

echo "=== Reorganizando $REPO ==="

# ── 1. Limpiar estructura anterior innecesaria ──────────────
echo "[1/5] Limpiando archivos generados/duplicados..."
rm -f create_professional_structure.sh \
      create_professional_structure.sh.backup \
      create_rstudio_project.sh \
      fix_and_complete_structure.sh \
      setup_learning_sql.sh \
      setup_r_environment.R \
      setup_r_project.R \
      package.json \
      pyproject.toml \
      LICENSE.html \
      README.html \
      Dockerfile \
      docker-compose.yml

rm -rf docker/ R/

# ── 2. Crear estructura limpia ──────────────────────────────
echo "[2/5] Creando estructura de directorios..."

# Org: symlinks a los archivos reales de org-roam
mkdir -p org/

# Quarto: exportaciones de los org
mkdir -p docs/beaulieu/{01..18}
mkdir -p docs/viescas/{01..18}
mkdir -p docs/shared

# SQL: código por capítulo, por libro
mkdir -p src/sql/beaulieu/{01..18}
mkdir -p src/sql/viescas/{01..18}
mkdir -p src/sql/shared

# Ejercicios
mkdir -p exercises/beaulieu/{01..18}
mkdir -p exercises/viescas/{01..18}

# LaTeX: un directorio por libro
mkdir -p latex/beaulieu/chapters/{01..18}
mkdir -p latex/viescas/chapters/{01..18}

# Datos: bases de datos de práctica
mkdir -p databases/sakila
mkdir -p databases/practice

# Scripts de utilidad
mkdir -p scripts/

# ── 3. Symlinks org → ~/org/libros/ ────────────────────────
echo "[3/5] Creando symlinks a org-roam..."

# Symlink a los .org reales (fuente de verdad)
ln -sf "$LEARNING_SQL_ORG" \
    "$REPO/org/beaulieu_learning_sql.org" 2>/dev/null || \
    echo "  AVISO: $LEARNING_SQL_ORG no encontrado"

ln -sf "$MERE_MORTALS_ORG" \
    "$REPO/org/viescas_mere_mortals.org" 2>/dev/null || \
    echo "  AVISO: $MERE_MORTALS_ORG no encontrado"

# ── 4. Crear .gitignore actualizado ────────────────────────
echo "[4/5] Actualizando .gitignore..."
cat > .gitignore << 'GITIGNORE'
# Python
__pycache__/
*.pyc
.venv/
*.egg-info/

# R
.Rhistory
.RData
.Rproj.user/

# LaTeX
*.aux *.log *.out *.toc *.synctex.gz
*.fls *.fdb_latexmk

# Quarto
_site/
.quarto/
*_files/

# Bases de datos locales
*.db
*.sqlite
*.duckdb

# Symlinks a org (la fuente real está en ~/org)
# Los .org en org/ son symlinks — no trackear su contenido
# (se trackea el symlink en sí)

# OS
.DS_Store
Thumbs.db
GITIGNORE

# ── 5. Crear README limpio ──────────────────────────────────
echo "[5/5] Actualizando README..."
cat > README.md << 'README'
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
README

echo ""
echo "=== Listo ==="
echo "Estructura creada. Próximo paso:"
echo "  bash scripts/sync_org.sh"
