# ============================================================
# Makefile — learning-sql-notes
# Emanuel Quintana · 2026
#
# Uso rápido:
#   make sync       → exportar org → qmd
#   make render     → renderizar el libro Quarto
#   make publish    → sync + render + push a gh-pages
#   make watch      → watcher automático (inotifywait)
#   make watch-bg   → watcher en background
#   make stop-watch → detener el watcher
#   make db-init    → inicializar la base de datos bancaria
#   make db-reset   → borrar y recrear la BD
#   make status     → estado del proyecto
# ============================================================

SHELL := /bin/bash
.DEFAULT_GOAL := help

REPO_ROOT := $(shell pwd)
DOCS_DIR  := $(REPO_ROOT)/docs
DB        := $(REPO_ROOT)/databases/practice/bank.duckdb
SCHEMA    := $(REPO_ROOT)/src/sql/beaulieu/01/bank_schema_duckdb.sql

# ── Colores ────────────────────────────────────────────────
BOLD  := \033[1m
RESET := \033[0m
GREEN := \033[32m
BLUE  := \033[34m
CYAN  := \033[36m

.PHONY: help sync render publish watch watch-bg stop-watch \
        db-init db-reset db-query status clean

# ── Ayuda ──────────────────────────────────────────────────
help:
	@echo ""
	@echo "$(BOLD)learning-sql-notes$(RESET) — comandos disponibles:"
	@echo ""
	@echo "  $(CYAN)Notas y documentación$(RESET)"
	@echo "  $(GREEN)make sync$(RESET)        Exportar org-roam → qmd (una vez)"
	@echo "  $(GREEN)make render$(RESET)      Renderizar libro Quarto localmente"
	@echo "  $(GREEN)make publish$(RESET)     sync + render + publicar en gh-pages"
	@echo "  $(GREEN)make watch$(RESET)       Watcher automático org→qmd (foreground)"
	@echo "  $(GREEN)make watch-bg$(RESET)    Watcher automático org→qmd (background)"
	@echo "  $(GREEN)make stop-watch$(RESET)  Detener el watcher en background"
	@echo ""
	@echo "  $(CYAN)Base de datos$(RESET)"
	@echo "  $(GREEN)make db-init$(RESET)     Crear/inicializar banco.duckdb"
	@echo "  $(GREEN)make db-reset$(RESET)    Borrar y recrear la BD desde cero"
	@echo "  $(GREEN)make db-query$(RESET)    Abrir REPL DuckDB interactivo"
	@echo ""
	@echo "  $(CYAN)Utilidades$(RESET)"
	@echo "  $(GREEN)make status$(RESET)      Estado del proyecto"
	@echo "  $(GREEN)make clean$(RESET)       Limpiar archivos temporales"
	@echo ""

# ── Notas y documentación ──────────────────────────────────
sync:
	@echo "$(BOLD)→ Exportando org → qmd...$(RESET)"
	@bash scripts/sync_org.sh

render: sync
	@echo "$(BOLD)→ Renderizando Quarto...$(RESET)"
	@cd $(DOCS_DIR) && quarto render

publish: sync
	@echo "$(BOLD)→ Publicando en gh-pages...$(RESET)"
	@cd $(DOCS_DIR) && quarto publish gh-pages --no-prompt

watch:
	@echo "$(BOLD)→ Iniciando watcher (Ctrl+C para detener)...$(RESET)"
	@bash scripts/watch_and_export.sh

watch-bg:
	@echo "$(BOLD)→ Iniciando watcher en background...$(RESET)"
	@bash scripts/watch_and_export.sh --daemon
	@echo "  Log: scripts/watcher.log"

stop-watch:
	@if [ -f /tmp/sql-notes-watcher.pid ]; then \
	    kill $$(cat /tmp/sql-notes-watcher.pid) 2>/dev/null && \
	    echo "$(GREEN)✓ Watcher detenido$(RESET)" || \
	    echo "  (ya estaba detenido)"; \
	    rm -f /tmp/sql-notes-watcher.pid; \
	else \
	    echo "  No hay watcher activo"; \
	fi

# ── Base de datos ──────────────────────────────────────────
db-init:
	@echo "$(BOLD)→ Inicializando banco.duckdb...$(RESET)"
	@bash scripts/init_bank.sh

db-reset:
	@echo "$(BOLD)→ Recreando BD desde cero...$(RESET)"
	@rm -f $(DB)
	@bash scripts/init_bank.sh

db-query:
	@echo "$(BOLD)→ Abriendo DuckDB REPL...$(RESET)"
	@duckdb $(DB)

# ── Utilidades ─────────────────────────────────────────────
status:
	@echo ""
	@echo "$(BOLD)Estado del proyecto$(RESET)"
	@echo "──────────────────────────────"
	@echo ""
	@echo "$(CYAN)Symlinks org-roam:$(RESET)"
	@for f in org/*.org; do \
	    if [ -L "$$f" ] && [ -e "$$f" ]; then \
	        echo "  $(GREEN)✓$(RESET) $$f → $$(readlink $$f)"; \
	    elif [ -L "$$f" ]; then \
	        echo "  ✗ $$f → ROTO ($$(readlink $$f))"; \
	    fi; \
	done
	@echo ""
	@echo "$(CYAN)Base de datos:$(RESET)"
	@if [ -f "$(DB)" ]; then \
	    size=$$(du -sh $(DB) | cut -f1); \
	    echo "  $(GREEN)✓$(RESET) $(DB) ($$size)"; \
	    duckdb $(DB) "SELECT table_name, estimated_size AS filas FROM duckdb_tables() ORDER BY table_name;" 2>/dev/null || true; \
	else \
	    echo "  ✗ BD no inicializada — ejecuta: make db-init"; \
	fi
	@echo ""
	@echo "$(CYAN)Archivos qmd generados:$(RESET)"
	@find docs -name "*.qmd" | sort | while read f; do \
	    echo "  ✓ $$f"; \
	done
	@echo ""
	@echo "$(CYAN)Watcher:$(RESET)"
	@if [ -f /tmp/sql-notes-watcher.pid ] && kill -0 $$(cat /tmp/sql-notes-watcher.pid) 2>/dev/null; then \
	    echo "  $(GREEN)✓$(RESET) Activo (PID: $$(cat /tmp/sql-notes-watcher.pid))"; \
	    echo "  Log: scripts/watcher.log"; \
	else \
	    echo "  Inactivo — ejecuta: make watch-bg"; \
	fi
	@echo ""

clean:
	@echo "$(BOLD)→ Limpiando archivos temporales...$(RESET)"
	@rm -f scripts/watcher.log
	@rm -rf docs/_site
	@find . -name "*.aux" -o -name "*.log" -o -name "*.out" | xargs rm -f 2>/dev/null || true
	@echo "$(GREEN)✓ Limpio$(RESET)"
