#!/usr/bin/env bash
# =============================================================
# init_bank.sh — Inicializa la base de datos bancaria en DuckDB
# Uso: bash scripts/init_bank.sh   (desde la raíz del proyecto)
# =============================================================

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCHEMA="$REPO_ROOT/src/sql/beaulieu/01/bank_schema_duckdb.sql"
DB="$REPO_ROOT/databases/practice/bank.duckdb"
VENV_DUCK="$REPO_ROOT/.venv/bin/duckdb"

# ── 1. Buscar el ejecutable duckdb ─────────────────────────────
if command -v duckdb &>/dev/null; then
    DUCKDB="duckdb"
elif [[ -x "$VENV_DUCK" ]]; then
    DUCKDB="$VENV_DUCK"
else
    echo "ERROR: no se encontró el binario 'duckdb'."
    echo "  Opciones:"
    echo "    a) Agrégalo al PATH: export PATH=\"\$PATH:$REPO_ROOT/.venv/bin\""
    echo "    b) Instala duckdb CLI: https://duckdb.org/docs/installation"
    exit 1
fi

echo "→ Usando: $DUCKDB ($("$DUCKDB" --version 2>&1 | head -1))"

# ── 2. Eliminar BD anterior si existe ─────────────────────────
if [[ -f "$DB" ]]; then
    echo "→ Eliminando BD existente: $DB"
    rm -f "$DB"
fi

# ── 3. Crear la BD cargando el schema ─────────────────────────
echo "→ Cargando schema: $SCHEMA"
"$DUCKDB" "$DB" < "$SCHEMA"

# ── 4. Verificar filas en cada tabla ──────────────────────────
echo ""
echo "✓ Base de datos lista en: $DB"
echo ""
"$DUCKDB" "$DB" "
SELECT
    table_name,
    estimated_size AS filas
FROM duckdb_tables()
ORDER BY table_name;
"
