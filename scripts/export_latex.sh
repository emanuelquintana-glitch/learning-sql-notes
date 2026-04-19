#!/usr/bin/env bash
# ============================================================
# scripts/export_latex.sh
# Exporta los .org a .tex en latex/
# Requiere: pandoc
# ============================================================
set -e

REPO="$(cd "$(dirname "$0")/.." && pwd)"
ORG_DIR="$HOME/org/libros/Lenguajes_de_Programacion"

BEAULIEU_ORG="$ORG_DIR/learning-sql-generate-manipulate-and-retrieve-data.org"
VIESCAS_ORG="$ORG_DIR/sql-queries-for-mere-mortals-pearson-ucertify-course-access.org"

export_org_to_tex() {
    local src="$1"
    local dest="$2"

    [[ ! -f "$src" ]] && { echo "  AVISO: $src no encontrado"; return; }

    mkdir -p "$(dirname "$dest")"
    pandoc "$src" --from org --to latex --output "$dest" --wrap=none 2>/dev/null
    echo "  ✓ $(basename "$src") → $(basename "$dest")"
}

echo "=== Exportando org → LaTeX ==="
export_org_to_tex "$BEAULIEU_ORG"  "$REPO/latex/beaulieu/notas.tex"
export_org_to_tex "$VIESCAS_ORG"   "$REPO/latex/viescas/notas.tex"
export_org_to_tex "$ORSEG_DIR/using-sqlite-small-fast-reliable-choose-any-three.org" "$REPO/latex/kreibich/notas.tex"
echo "=== Export LaTeX completo ==="
