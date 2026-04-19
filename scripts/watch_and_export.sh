#!/usr/bin/env bash
# ============================================================
# scripts/watch_and_export.sh
#
# Watcher: detecta cambios en ~/org/libros/ y exporta
# automáticamente org → qmd por capítulo.
#
# Requiere: inotifywait (inotify-tools), pandoc
# Gentoo: emerge dev-util/inotify-tools
#
# Uso:
#   bash scripts/watch_and_export.sh          # modo interactivo
#   bash scripts/watch_and_export.sh --daemon # modo background
#
# Para detener el daemon:
#   kill $(cat /tmp/sql-notes-watcher.pid)
# ============================================================

set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
ORG_DIR="$HOME/org/libros/Lenguajes_de_Programacion"
DOCS_DIR="$REPO/docs"
QUARTO_YML="$DOCS_DIR/_quarto.yml"
LOG="$REPO/scripts/watcher.log"

# Mapeo libro → directorio docs
declare -A LIBRO_MAP=(
    ["learning-sql-generate-manipulate-and-retrieve-data"]="beaulieu"
    ["sql-queries-for-mere-mortals-pearson-ucertify-course-access"]="viescas"
    ["using-sqlite-small-fast-reliable-choose-any-three"]="kreibich"
)

declare -A LIBRO_TITULO=(
    ["learning-sql-generate-manipulate-and-retrieve-data"]="Learning SQL — Beaulieu (2020)"
    ["sql-queries-for-mere-mortals-pearson-ucertify-course-access"]="SQL Queries for Mere Mortals — Viescas (2018)"
    ["using-sqlite-small-fast-reliable-choose-any-three"]="Using SQLite — Kreibich (2010)"
)

# ── Verificar dependencias ──────────────────────────────────
check_deps() {
    local missing=()
    command -v inotifywait &>/dev/null || missing+=("inotify-tools")
    command -v pandoc      &>/dev/null || missing+=("pandoc")
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "ERROR: Faltan dependencias: ${missing[*]}"
        echo "  Gentoo: emerge dev-util/inotify-tools app-text/pandoc"
        exit 1
    fi
}

# ── Exportar un .org a .qmd ────────────────────────────────
export_org_to_qmd() {
    local src="$1"
    local dest="$2"
    local title="$3"

    [[ ! -f "$src" ]] && return

    mkdir -p "$(dirname "$dest")"

    local tmpfile
    tmpfile=$(mktemp)

    # Cabecera YAML Quarto
    cat > "$tmpfile" << YAML
---
title: "$title"
date: "$(date +%Y-%m-%d)"
format:
  html:
    toc: true
    toc-depth: 3
    code-fold: false
  pdf:
    toc: true
---

YAML

    # Exportar org → markdown y append
    pandoc "$src" \
        --from org \
        --to markdown \
        --wrap=none \
        2>/dev/null >> "$tmpfile" || true

    mv "$tmpfile" "$dest"
    echo "[$(date +%H:%M:%S)] ✓ exportado: $(basename "$src") → $(basename "$dest")" | tee -a "$LOG"
}

# ── Detectar capítulo desde nombre de archivo org ─────────
# Convención: notas_cap01.org, cap02_selects.org, 03_joins.org, etc.
# Si no tiene número → va a notas.qmd (resumen general)
detect_chapter() {
    local filename="$1"
    if [[ "$filename" =~ ([0-9]{2}) ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "00"
    fi
}

# ── Regenerar _quarto.yml automáticamente ──────────────────
regenerate_quarto_yml() {
    local tmpyml
    tmpyml=$(mktemp)

    cat > "$tmpyml" << 'HEADER'
project:
  type: book
  output-dir: _site

book:
  title: "Learning SQL Notes"
  author: "Emanuel Quintana"
  date: "AUTO"
  repo-url: https://github.com/emanuelquintana-glitch/learning-sql-notes
  repo-actions: [edit, issue]
  chapters:
    - index.qmd
HEADER

    # Reemplazar fecha
    sed -i "s/AUTO/$(date +%Y-%m-%d)/" "$tmpyml"

    # Para cada libro, encontrar .qmd existentes y agregarlos
    declare -A PARTES=(
        ["beaulieu"]="Learning SQL (Beaulieu 2020)"
        ["viescas"]="SQL Queries for Mere Mortals (Viescas 2018)"
        ["kreibich"]="Using SQLite (Kreibich 2010)"
    )

    for libro in beaulieu viescas kreibich; do
        local titulo="${PARTES[$libro]}"
        local libro_dir="$DOCS_DIR/$libro"

        # Encontrar todos los .qmd del libro, ordenados
        local qmds=()
        while IFS= read -r -d '' f; do
            # Ruta relativa desde docs/
            local rel="${f#$DOCS_DIR/}"
            qmds+=("$rel")
        done < <(find "$libro_dir" -name "*.qmd" -print0 2>/dev/null | sort -z)

        if [[ ${#qmds[@]} -gt 0 ]]; then
            echo "    - part: \"$titulo\"" >> "$tmpyml"
            echo "      chapters:" >> "$tmpyml"
            for qmd in "${qmds[@]}"; do
                echo "        - $qmd" >> "$tmpyml"
            done
        fi
    done

    # Formato
    cat >> "$tmpyml" << 'FORMAT'

format:
  html:
    theme: cosmo
    toc: true
    toc-depth: 3
    number-sections: true
    highlight-style: github
    code-copy: true
  pdf:
    documentclass: scrbook
    papersize: letter
    toc: true
    number-sections: true
FORMAT

    mv "$tmpyml" "$QUARTO_YML"
    echo "[$(date +%H:%M:%S)] ✓ _quarto.yml actualizado" | tee -a "$LOG"
}

# ── Procesar un archivo org modificado ────────────────────
process_org_file() {
    local org_file="$1"
    local basename
    basename=$(basename "$org_file" .org)

    # Determinar a qué libro pertenece
    local libro_key=""
    local libro_dir=""
    local titulo=""

    for key in "${!LIBRO_MAP[@]}"; do
        if [[ "$basename" == "$key" ]]; then
            libro_key="$key"
            libro_dir="${LIBRO_MAP[$key]}"
            titulo="${LIBRO_TITULO[$key]}"
            break
        fi
    done

    if [[ -z "$libro_key" ]]; then
        # Intentar detectar por contenido del path
        for key in "${!LIBRO_MAP[@]}"; do
            if [[ "$org_file" == *"$key"* ]]; then
                libro_key="$key"
                libro_dir="${LIBRO_MAP[$key]}"
                titulo="${LIBRO_TITULO[$key]}"
                break
            fi
        done
    fi

    [[ -z "$libro_dir" ]] && {
        echo "[$(date +%H:%M:%S)] SKIP: no se reconoce el libro para $basename" >> "$LOG"
        return
    }

    # Exportar el org principal del libro → notas.qmd
    local dest="$DOCS_DIR/$libro_dir/notas.qmd"
    export_org_to_qmd "$org_file" "$dest" "$titulo"

    # Regenerar _quarto.yml con los nuevos archivos
    regenerate_quarto_yml
}

# ── Exportación inicial completa ───────────────────────────
initial_export() {
    echo "[$(date +%H:%M:%S)] === Exportación inicial ===" | tee -a "$LOG"
    for key in "${!LIBRO_MAP[@]}"; do
        local src="$ORG_DIR/${key}.org"
        local dest="$DOCS_DIR/${LIBRO_MAP[$key]}/notas.qmd"
        local titulo="${LIBRO_TITULO[$key]}"
        export_org_to_qmd "$src" "$dest" "$titulo"
    done
    regenerate_quarto_yml
    echo "[$(date +%H:%M:%S)] === Exportación inicial completa ===" | tee -a "$LOG"
}

# ── Loop principal del watcher ─────────────────────────────
watch_loop() {
    echo "[$(date +%H:%M:%S)] Observando $ORG_DIR ..." | tee -a "$LOG"
    echo "[$(date +%H:%M:%S)] Log en: $LOG"

    inotifywait \
        --monitor \
        --recursive \
        --event close_write,moved_to \
        --format '%w%f' \
        "$ORG_DIR" \
    2>/dev/null | while read -r changed_file; do

        # Solo procesar archivos .org
        [[ "$changed_file" != *.org ]] && continue

        echo "[$(date +%H:%M:%S)] Cambio detectado: $changed_file" | tee -a "$LOG"

        # Pequeña pausa para que Emacs termine de escribir
        sleep 0.5

        process_org_file "$changed_file"

        echo "[$(date +%H:%M:%S)] ─────────────────────────────" | tee -a "$LOG"
    done
}

# ── Main ───────────────────────────────────────────────────
main() {
    check_deps

    echo "" > "$LOG"
    echo "[$(date +%H:%M:%S)] === SQL Notes Watcher iniciado ===" | tee -a "$LOG"

    # Exportación inicial
    initial_export

    if [[ "${1:-}" == "--daemon" ]]; then
        echo "[$(date +%H:%M:%S)] Ejecutando en background..."
        watch_loop &
        echo $! > /tmp/sql-notes-watcher.pid
        echo "PID: $! — Para detener: kill \$(cat /tmp/sql-notes-watcher.pid)"
    else
        watch_loop
    fi
}

main "${@}"
