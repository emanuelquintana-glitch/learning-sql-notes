.PHONY: help setup install databases start stop test lint format docs clean

# Variables
DOCKER_COMPOSE := docker-compose
PYTHON := python3
NPM := npm
QUARTO := quarto

# Colores
GREEN := \\033[0;32m
YELLOW := \\033[1;33m
RED := \\033[0;31m
NC := \\033[0m

help:
	@echo ""
	@echo "$(YELLOW)Learning SQL Notes - Makefile$(NC)"
	@echo "$(YELLOW)================================$(NC)"
	@echo ""
	@echo "$(GREEN)Comandos disponibles:$(NC)"
	@echo ""
	@echo "  $(YELLOW)Configuración:$(NC)"
	@echo "    make setup           Configurar entorno de desarrollo completo"
	@echo "    make install         Instalar dependencias de todos los lenguajes"
	@echo ""
	@echo "  $(YELLOW)Base de Datos:$(NC)"
	@echo "    make databases       Iniciar bases de datos (Docker)"
	@echo "    make start           Iniciar todos los servicios"
	@echo "    make stop            Detener todos los servicios"
	@echo "    make db-status       Ver estado de las bases de datos"
	@echo ""
	@echo "  $(YELLOW)Desarrollo:$(NC)"
	@echo "    make test            Ejecutar todos los tests"
	@echo "    make test-python     Ejecutar tests de Python"
	@echo "    make test-js         Ejecutar tests de JavaScript"
	@echo "    make lint            Verificar estilo de código"
	@echo "    make format          Formatear código automáticamente"
	@echo ""
	@echo "  $(YELLOW)Documentación:$(NC)"
	@echo "    make docs            Generar documentación"
	@echo "    make serve-docs      Servir documentación localmente"
	@echo ""
	@echo "  $(YELLOW)Limpieza:$(NC)"
	@echo "    make clean           Limpiar archivos generados"
	@echo "    make clean-docker    Limpiar contenedores Docker"
	@echo "    make clean-all       Limpiar todo"
	@echo ""

setup:
	@echo "$(YELLOW)Configurando entorno de desarrollo...$(NC)"
	@echo "$(GREEN)1. Instalando dependencias Python...$(NC)"
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -e ".[dev,database,docs]"
	@echo "$(GREEN)2. Instalando dependencias JavaScript...$(NC)"
	$(NPM) install
	@echo "$(GREEN)3. Instalando pre-commit hooks...$(NC)"
	$(PYTHON) -m pip install pre-commit
	pre-commit install
	@echo "$(GREEN)✅ Entorno configurado correctamente$(NC)"

install:
	@echo "$(YELLOW)Instalando dependencias...$(NC)"
	$(PYTHON) -m pip install -r requirements.txt
	$(NPM) install
	@echo "$(GREEN)✅ Dependencias instaladas$(NC)"

databases:
	@echo "$(YELLOW)Iniciando bases de datos con Docker...$(NC)"
	$(DOCKER_COMPOSE) up -d mysql postgres adminer sqlite-browser
	@echo "$(GREEN)✅ Bases de datos iniciadas$(NC)"
	@echo "$(YELLOW)📊 Adminer: http://localhost:8080$(NC)"
	@echo "$(YELLOW)🐬 MySQL: localhost:3306$(NC)"
	@echo "$(YELLOW)🐘 PostgreSQL: localhost:5432$(NC)"

start: databases
	@echo "$(GREEN)✅ Todos los servicios iniciados$(NC)"

stop:
	@echo "$(YELLOW)Deteniendo servicios...$(NC)"
	$(DOCKER_COMPOSE) down
	@echo "$(GREEN)✅ Servicios detenidos$(NC)"

db-status:
	@echo "$(YELLOW)Estado de los contenedores:$(NC)"
	$(DOCKER_COMPOSE) ps

test:
	@echo "$(YELLOW)Ejecutando tests...$(NC)"
	@echo "$(GREEN)1. Tests Python:$(NC)"
	$(PYTHON) -m pytest tests/ -v --cov=src --cov-report=term-missing
	@echo "$(GREEN)2. Tests JavaScript:$(NC)"
	cd src/javascript && $(NPM) test

test-python:
	$(PYTHON) -m pytest tests/ -v

test-js:
	cd src/javascript && $(NPM) test

lint:
	@echo "$(YELLOW)Verificando estilo de código...$(NC)"
	@echo "$(GREEN)1. Python (flake8):$(NC)"
	$(PYTHON) -m flake8 src/ tests/
	@echo "$(GREEN)2. Python (black check):$(NC)"
	$(PYTHON) -m black --check src/ tests/
	@echo "$(GREEN)3. JavaScript (eslint):$(NC)"
	cd src/javascript && $(NPM) run lint

format:
	@echo "$(YELLOW)Formateando código...$(NC)"
	@echo "$(GREEN)1. Python (black):$(NC)"
	$(PYTHON) -m black src/ tests/
	@echo "$(GREEN)2. Python (isort):$(NC)"
	$(PYTHON) -m isort src/ tests/
	@echo "$(GREEN)3. JavaScript (prettier):$(NC)"
	cd src/javascript && $(NPM) run format

docs:
	@echo "$(YELLOW)Generando documentación...$(NC)"
	$(QUARTO) render docs/ --to html
	@echo "$(GREEN)✅ Documentación generada en docs/_site/$(NC)"

serve-docs:
	@echo "$(YELLOW)Sirviendo documentación en http://localhost:8088...$(NC)"
	$(QUARTO) preview docs/ --port 8088

clean:
	@echo "$(YELLOW)Limpiando archivos generados...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type f -name "*.log" -delete
	find . -type f -name "*.aux" -delete
	find . -type f -name "*.out" -delete
	find . -type f -name "*.toc" -delete
	find . -type f -name "*.synctex.gz" -delete
	rm -rf build/ dist/ *.egg-info/ .pytest_cache/ .coverage htmlcov/
	@echo "$(GREEN)✅ Limpieza completada$(NC)"

clean-docker:
	@echo "$(YELLOW)Limpiando contenedores Docker...$(NC)"
	$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "$(GREEN)✅ Contenedores limpiados$(NC)"

clean-all: clean clean-docker
	@echo "$(GREEN)✅ Limpieza completa$(NC)"

