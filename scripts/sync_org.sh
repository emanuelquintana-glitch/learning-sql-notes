#!/usr/bin/env bash
# ============================================================
# scripts/sync_org.sh
# Exporta los .org de ~/org/libros/ a .qmd en docs/
# Requiere: pandoc
# ============================================================
set -e

REPO="$(cd "$(dirname "$0")/.." && pwd)"
ORG_DIR="$HOME/org/libros/Lenguajes_de_Programacion"
DOCS_DIR="$REPO/docs"

BEAULIEU_ORG="$ORG_DIR/learning-sql-generate-manipulate-and-retrieve-data.org"
VIESCAS_ORG="$ORG_DIR/sql-queries-for-mere-mortals-pearson-ucertify-course-access.org"

echo "=== Sincronizando org → qmd ==="

export_org_to_qmd() {
    local src="$1"
    local dest="$2"
    local title="$3"

    if [[ ! -f "$src" ]]; then
        echo "  AVISO: $src no encontrado, omitiendo"
        return
    fi

    mkdir -p "$(dirname "$dest")"

    # Exportar con pandoc: org → markdown (compatible con Quarto)
    pandoc "$src" \
        --from org \
        --to markdown \
        --output "$dest" \
        --wrap=none \
        2>/dev/null || {
        echo "  ERROR exportando $src"
        return
    }

    # Añadir cabecera YAML de Quarto al inicio
    local tmpfile=$(mktemp)
    cat > "$tmpfile" << YAML
---
title: "$title"
date: "$(date +%Y-%m-%d)"
format:
  html:
    toc: true
    toc-depth: 3
  pdf:
    toc: true
---

YAML
    cat "$dest" >> "$tmpfile"
    mv "$tmpfile" "$dest"

    echo "  ✓ $(basename "$src") → $(basename "$dest")"
}

# Exportar cada libro
export_org_to_qmd \
    "$BEAULIEU_ORG" \
    "$DOCS_DIR/beaulieu/notas.qmd" \
    "Learning SQL — Beaulieu (2020)"

export_org_to_qmd \
    "$VIESCAS_ORG" \
    "$DOCS_DIR/viescas/notas.qmd" \
    "SQL Queries for Mere Mortals — Viescas (2018)"

# Crear índice _quarto.yml si no existe
if [[ ! -f "$DOCS_DIR/_quarto.yml" ]]; then
    cat > "$DOCS_DIR/_quarto.yml" << QUARTO
project:
  type: book
  output-dir: _site

book:
  title: "Learning SQL Notes"
  author: "Emanuel Quintana"
  date: "$(date +%Y-%m-%d)"
  chapters:
    - index.qmd
    - part: "Learning SQL (Beaulieu)"
      chapters:
        - beaulieu/notas.qmd
    - part: "SQL Queries for Mere Mortals (Viescas)"
      chapters:
        - viescas/notas.qmd

format:
  html:
    theme: cosmo
    toc: true
  pdf:
    documentclass: scrbook
QUARTO
    echo "  ✓ _quarto.yml creado"
fi

# Crear index.qmd si no existe
if [[ ! -f "$DOCS_DIR/index.qmd" ]]; then
    cat > "$DOCS_DIR/index.qmd" << INDEX
---
title: "Learning SQL Notes"
---

Notas de estudio de SQL siguiendo dos libros principales.

## Libros

- **Learning SQL** — Alan Beaulieu (2020, O'Reilly)
- **SQL Queries for Mere Mortals** — John Viescas (2018, Addison-Wesley)

## Cómo usar estas notas

Las notas se toman en Emacs (org-roam) y se exportan automáticamente
a este libro con `bash scripts/sync_org.sh`.
INDEX
    echo "  ✓ index.qmd creado"
fi

echo ""
export_org_to_qmd \
    "$ORG_DIR/using-sqlite-small-fast-reliable-choose-any-three.org" \
    "$DOCS_DIR/kreibich/notas.qmd" \
    "Using SQLite — Kreibich (2010)"

echo "=== Sync completo ==="
echo "Para renderizar: cd docs && quarto render"
