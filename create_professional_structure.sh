#!/bin/bash

# ============================================================================
# Script para crear estructura profesional de Learning SQL Notes
# Autor: Emanuel
# ============================================================================

# Colores para salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir encabezados
print_header() {
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║ $1${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════╝${NC}"
}

# Función para imprimir mensajes de éxito
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Función para imprimir mensajes de información
print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

# Función para imprimir mensajes de advertencia
print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Función para imprimir mensajes de error
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Función para crear directorio con verificación
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_success "Directorio creado: $1"
    else
        print_info "Directorio ya existe: $1"
    fi
}

# Función para crear archivo con contenido
create_file() {
    local file_path="$1"
    local content="$2"
    
    if [ ! -f "$file_path" ]; then
        echo "$content" > "$file_path"
        print_success "Archivo creado: $file_path"
    else
        print_info "Archivo ya existe: $file_path"
    fi
}

# ============================================================================
# INICIO DEL SCRIPT
# ============================================================================

print_header "🏗️  CREANDO ESTRUCTURA PROFESIONAL PARA LEARNING SQL NOTES"

# ----------------------------------------------------------------------------
# 1. ARCHIVOS EN RAIZ
# ----------------------------------------------------------------------------
print_header "1. Creando archivos en directorio raíz"

# .gitignore
create_file ".gitignore" '
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# R
.Rproj.user
.Rhistory
.RData
.Ruserdata

# Java
*.class
*.jar
*.war
*.ear
hs_err_pid*
target/
.gradle/
build/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnp.*

# Database
*.db
*.sqlite
*.sqlite3
*.db-journal

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Logs
*.log
logs/

# Temp
tmp/
temp/
*.tmp
*.temp

# Documentation
_site/
_site/*
.docs/
.cache/

# Quarto
_quarto/
*.aux
*.log
*.out
*.toc

# LaTeX
*.aux
*.bbl
*.blg
*.fdb_latexmk
*.fls
*.log
*.out
*.synctex.gz
*.toc
*.xdv

# Jupyter
.ipynb_checkpoints/

# Docker
*.tar.gz
'

# pyproject.toml
create_file "pyproject.toml" '[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "learning-sql-notes"
version = "0.1.0"
description = "Comprehensive SQL learning with multiple programming language integrations"
readme = "README.md"
requires-python = ">=3.8"
license = {text = "MIT"}
authors = [
    {name = "Emanuel", email = "emanuel@example.com"}
]
keywords = ["sql", "database", "learning", "python", "r", "java", "javascript", "cpp", "c"]
classifiers = [
    "Development Status :: 3 - Alpha",
    "Intended Audience :: Education",
    "Topic :: Database",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.8",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
]

[project.urls]
Homepage = "https://github.com/emanuel/learning-sql-notes"
Repository = "https://github.com/emanuel/learning-sql-notes.git"
"Bug Tracker" = "https://github.com/emanuel/learning-sql-notes/issues"

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov>=4.0",
    "black>=23.0",
    "isort>=5.0",
    "flake8>=6.0",
    "mypy>=1.0",
    "pre-commit>=3.0",
]

database = [
    "sqlalchemy>=2.0",
    "psycopg2-binary>=2.9",
    "mysql-connector-python>=8.0",
    "pandas>=2.0",
    "sqlite-utils>=3.0",
]

docs = [
    "jupyter>=1.0",
    "quarto>=1.0",
    "sphinx>=7.0",
    "myst-parser>=2.0",
]

[tool.black]
line-length = 88
target-version = ["py38"]

[tool.isort]
profile = "black"
line_length = 88

[tool.mypy]
python_version = "3.8"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = "-v --cov=src --cov-report=term-missing"
'

# requirements.txt
create_file "requirements.txt" '# Dependencias principales
sqlalchemy>=2.0.0
pandas>=2.0.0
numpy>=1.24.0
jupyter>=1.0.0
quarto>=1.0.0

# Conectores de base de datos
psycopg2-binary>=2.9.0
mysql-connector-python>=8.0.0
sqlite-utils>=3.0.0

# Utilidades
python-dotenv>=1.0.0
rich>=13.0.0
typer>=0.9.0

# Desarrollo
pytest>=7.0.0
black>=23.0.0
flake8>=6.0.0
'

# package.json
create_file "package.json" '{
  "name": "learning-sql-notes",
  "version": "0.1.0",
  "description": "SQL learning repository with multiple programming language integrations",
  "main": "src/javascript/index.js",
  "scripts": {
    "start": "node src/javascript/index.js",
    "dev": "nodemon src/javascript/index.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/javascript/",
    "lint:fix": "eslint src/javascript/ --fix",
    "format": "prettier --write src/javascript/",
    "build": "npm run lint && npm run test"
  },
  "keywords": [
    "sql",
    "database",
    "learning",
    "javascript",
    "nodejs"
  ],
  "author": "Emanuel <emanuel@example.com>",
  "license": "MIT",
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  },
  "devDependencies": {
    "jest": "^29.0.0",
    "eslint": "^8.0.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-jest": "^27.0.0",
    "prettier": "^3.0.0",
    "nodemon": "^3.0.0"
  },
  "dependencies": {
    "mysql2": "^3.0.0",
    "pg": "^8.0.0",
    "sequelize": "^6.0.0",
    "sqlite3": "^5.0.0",
    "express": "^4.0.0",
    "dotenv": "^16.0.0"
  }
}'

# Makefile
create_file "Makefile" '.PHONY: help setup install databases start stop test lint format docs clean

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
'

# Dockerfile
create_file "Dockerfile" 'FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    sqlite3 \
    postgresql-client \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Copiar archivos de dependencias
COPY requirements.txt .
COPY package.json .
COPY pyproject.toml .

# Instalar Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -e ".[dev,database,docs]"

# Instalar Node.js dependencies
RUN npm install

# Copiar código fuente
COPY src/ ./src/
COPY docs/ ./docs/
COPY notebooks/ ./notebooks/
COPY databases/ ./databases/
COPY exercises/ ./exercises/
COPY tests/ ./tests/

# Crear usuario no-root
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Exponer puertos
EXPOSE 8888  # Jupyter
EXPOSE 8080  # Aplicación web

# Comando por defecto
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
'

# ----------------------------------------------------------------------------
# 2. CONFIGURACIONES
# ----------------------------------------------------------------------------
print_header "2. Creando configuraciones"

create_dir ".github/workflows"
create_dir "config/database"
create_dir "config/environments"

# GitHub Actions - CI
create_file ".github/workflows/ci.yml" 'name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.8", "3.9", "3.10", "3.11"]
        node-version: ["16", "18", "20"]

    services:
      mysql:
        image: mysql:8.0
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: test_db
        ports:
          - 3306:3306
        options: --health-cmd="mysqladmin ping" --health-interval=10s --health-timeout=5s --health-retries=3

      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: test_db
        ports:
          - 5432:5432
        options: --health-cmd="pg_isready -U postgres" --health-interval=10s --health-timeout=5s --health-retries=3

    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Set up Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -e ".[dev,database]"
        npm install
    
    - name: Lint Python
      run: |
        python -m flake8 src/ tests/
        python -m black --check src/ tests/
    
    - name: Lint JavaScript
      run: cd src/javascript && npm run lint
    
    - name: Test Python
      run: python -m pytest tests/ -v --cov=src --cov-report=xml
    
    - name: Test JavaScript
      run: cd src/javascript && npm test
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
        flags: unittests
        name: codecov-umbrella
'

# GitHub Actions - Docs
create_file ".github/workflows/docs.yml" 'name: Deploy Documentation

on:
  push:
    branches: [ main ]
    paths:
      - "docs/**"
      - ".github/workflows/docs.yml"

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      
    steps:
    - uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: "3.11"
    
    - name: Install Quarto
      uses: quarto-dev/quarto-actions/setup@v2
    
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
        pip install -e ".[docs]"
    
    - name: Render and Publish
      uses: quarto-dev/quarto-actions/publish@v2
      with:
        target: gh-pages
        path: docs
'

# Configuraciones de base de datos
create_file "config/database/mysql.cnf" '[client]
host=localhost
port=3306
user=student
password=student123
database=learning_sql

[mysql]
default-character-set=utf8mb4

[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
default-storage-engine=INNODB
'

create_file "config/database/postgresql.conf" '# Configuración PostgreSQL para desarrollo
host=localhost
port=5432
user=student
password=postgres123
database=learning_sql

# Configuraciones de conexión
client_encoding=utf8
timezone=UTC

# Configuraciones de performance (desarrollo)
shared_buffers=128MB
work_mem=4MB
maintenance_work_mem=64MB
'

create_file "config/database/sqlite.config" '[sqlite]
# Configuración SQLite
database=databases/sqlite/learning.db
journal_mode=WAL
synchronous=NORMAL
foreign_keys=ON

[backup]
# Configuración de backup
backup_dir=databases/backups/
retention_days=7
'

# Variables de entorno
create_file "config/environments/development.env" '# Entorno de desarrollo
DEBUG=true
LOG_LEVEL=DEBUG

# Bases de datos
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=student
MYSQL_PASSWORD=student123
MYSQL_DATABASE=learning_sql_dev

POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=student
POSTGRES_PASSWORD=postgres123
POSTGRES_DATABASE=learning_sql_dev

SQLITE_PATH=databases/sqlite/learning_dev.db

# Aplicación
APP_PORT=5000
APP_HOST=0.0.0.0
SECRET_KEY=dev_secret_key_change_in_production

# Características
ENABLE_SWAGGER=true
ENABLE_DEBUG_TOOLBAR=true
'

create_file "config/environments/production.env" '# Entorno de producción
DEBUG=false
LOG_LEVEL=INFO

# Bases de datos (configurar con variables reales)
MYSQL_HOST=${MYSQL_HOST}
MYSQL_PORT=${MYSQL_PORT}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}

POSTGRES_HOST=${POSTGRES_HOST}
POSTGRES_PORT=${POSTGRES_PORT}
POSTGRES_USER=${POSTGRES_USER}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_DATABASE=${POSTGRES_DATABASE}

# Seguridad
SECRET_KEY=${SECRET_KEY}
ALLOWED_HOSTS=localhost,127.0.0.1

# Performance
WORKERS=4
THREADS=2
'

# ----------------------------------------------------------------------------
# 3. BASES DE DATOS
# ----------------------------------------------------------------------------
print_header "3. Creando estructura de bases de datos"

# Directorios de bases de datos
create_dir "databases/schemas/sakila"
create_dir "databases/schemas/chinook"
create_dir "databases/schemas/northwind"
create_dir "databases/migrations"
create_dir "databases/seeds/development"
create_dir "databases/seeds/test"
create_dir "databases/scripts"
create_dir "databases/backups"
create_dir "databases/sqlite"

# Migraciones
create_file "databases/migrations/V1__initial.sql" '-- Migración inicial
-- Crea las tablas base del sistema

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de cursos
CREATE TABLE IF NOT EXISTS courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    difficulty ENUM("beginner", "intermediate", "advanced") DEFAULT "beginner",
    duration_hours INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_difficulty (difficulty)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de ejercicios
CREATE TABLE IF NOT EXISTS exercises (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    solution TEXT,
    difficulty ENUM("easy", "medium", "hard") DEFAULT "medium",
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    INDEX idx_course_difficulty (course_id, difficulty)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
'

create_file "databases/migrations/V2__add_indexes.sql" '-- Migración V2: Agregar índices para optimización

-- Índices para la tabla users
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_updated_at ON users(updated_at);

-- Índices para la tabla courses
CREATE INDEX idx_courses_created_at ON courses(created_at);
CREATE INDEX idx_courses_duration ON courses(duration_hours);

-- Índices para la tabla exercises
CREATE INDEX idx_exercises_created_at ON exercises(created_at);
CREATE FULLTEXT INDEX idx_exercises_search ON exercises(title, description);

-- Tabla de logs para auditoría
CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(50) NOT NULL,
    table_name VARCHAR(50),
    record_id INT,
    changes JSON,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_user (user_id),
    INDEX idx_audit_action (action),
    INDEX idx_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
'

create_file "databases/migrations/V3__stored_procedures.sql" '-- Migración V3: Procedimientos almacenados y funciones

DELIMITER $$

-- Procedimiento para obtener estadísticas de usuario
CREATE PROCEDURE GetUserStatistics(IN useid INT)
BEGIN
    SELECT 
        u.username,
        u.email,
        COUNT(DISTINCT e.id) as total_exercises,
        COUNT(DISTINCT c.id) as total_courses,
        MIN(e.created_at) as first_exercise_date,
        MAX(e.created_at) as last_exercise_date
    FROM users u
    LEFT JOIN exercises e ON e.id IN (SELECT id FROM exercises WHERE created_by = user_id)
    LEFT JOIN courses c ON c.id IN (SELECT course_id FROM exercises WHERE created_by = user_id)
    WHERE u.id = user_id
    GROUP BY u.id;
END$$

2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_difficulty DECIMAL(3,2);
    
    SELECT AVG(
        CASE difficulty
            WHEN "easy" THEN 1
            WHEN "medium" THEN 2
            WHEN "hard" THEN 3
            ELSE 0
        END
    ) INTO avg_difficulty
    FROM exercises
    WHERE course_id = course_id_param;
    
    RETURN COALESCE(avg_difficulty, 0);
END$$

-- Trigger para actualizar timestamp
CREATE TRIGGER before_user_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;
'

# Scripts de utilidad
create_file "databases/scripts/backup.sh" '#!/bin/bash

# Script de backup para bases de datos
# Autor: Learning SQL Notes

set -e  # Salir en error

# Colores
RED="\\033[0;31m"
GREEN="\\033[0;32m"
YELLOW="\\033[1;33m"
NC="\\033[0m" # No Color

# Configuración
BACKUP_DIR="databases/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RETENTION_DAYS=7

# Crear directorio de backups si no existe
mkdir -p "$BACKUP_DIR"

echo -e "${YELLOW}Iniciando backup de bases de datos...${NC}"

# Backup de MySQL
if command -v mysqldump &> /dev/null; then
    echo -e "${GREEN}Realizando backup de MySQL...${NC}"
    mysqldump --single-transaction --routines --triggers \
        -h localhost -P 3306 -u student -pstudent123 \
        learning_sql > "$BACKUP_DIR/mysql_backup_$TIMESTAMP.sql"
    
    # Comprimir
    gzip -f "$BACKUP_DIR/mysql_backup_$TIMESTAMP.sql"
    echo -e "✓ Backup MySQL completado: $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql.gz"
else
    echo -e "${RED}mysqldump no encontrado, omitiendo MySQL${NC}"
fi

# Backup de PostgreSQL
if command -v pg_dump &> /dev/null; then
    echo -e "${GREEN}Realizando backup de PostgreSQL...${NC}"
    PGPASSWORD="postgres123" pg_dump -h localhost -p 5432 -U student \
        -d learning_sql > "$BACKUP_DIR/postgres_backup_$TIMESTAMP.sql"
    
    # Comprimir
    gzip -f "$BACKUP_DIR/postgres_baup_$TIMESTAMP.sql"
    echo -e "✓ Backup PostgreSQL completado: $BACKUP_DIR/postgres_backup_$TIMESTAMP.sql.gz"
else
    echo -e "${RED}pg_dump no encontrado, omitiendo PostgreSQL${NC}"
fi

# Backup de SQLite
if [ -f "databases/sqlite/learning.db" ]; then
    echo -e "${GREEN}Realizando backup de SQLite...${NC}"
    sqlite3 databases/sqlite/learning.db ".backup '$BACKUP_DIR/sqlite_backup_$TIMESTAMP.db'"
    echo -e "✓ Backup SQLite completado: $BACKUP_DIR/sqlite_backup_$TIMESTAMP.db"
fi

# Limpiar backups antiguos
echo -e "${YELLOW}Limpiando backups antiguos (más de $RETENTION_DAYS días)...${NC}"
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -type f -name "*.db" -mtime +$RETENTION_DAYS -delete

echo -e "${GREEN}✅ Proceso de backup completado${NC}"
echo -e "${YELLOW}Backups guardados en: $BACKUP_DIR${NC}"
'

create_file "databases/scripts/restore.sh" '#!/bin/bash

# Script para restaurar bases de datos desde backup
# Uso: ./restore.sh [backup_timestamp]

set -e

# Colores
RED="\\033[0;31m"
GREEN="\\033[0;32m"
YELLOW="\\033[1;33m"
NC="\\033[0m"

BACKUP_DIR="databases/backups"

if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Backups disponibles:${NC}"
    ls -1 "$BACKUP_DIR"/*.gz "$BACKUP_DIR"/*.db 2>/dev/null | xargs -n1 basename | sort -u
    echo ""
    echo -e "Uso: $0 [backup_timestamp]"
    echo -e "Ejemplo: $0 20240101_120000"
    exit 1
fi

TIMESTAMP=$1
echo -e "${YELLOW}Restaurando desde backup: $TIMESTAMP${NC}"

# Restaurar MySQL
MYSQL_BACKUP="$BACKUP_DIR/mysql_backup_$TIMESTAMP.sql.gz"
if [ -f "$MYSQL_BACKUP" ]; then
    echo -e "${GREEN}Restaurando MySQL...${NC}"
    gunzip -c "$MYSQL_BACKUP" | mysql -h localhost -P 3306 -u student -pstudent123 learning_sql
    echo -e "✓ MySQL restaurado"
else
    echo -e "${RED}Backup de MySQL no encontrado: $MYSQL_BACKUP${NC}"
fi

# Restaurar PostgreSQL
POSTGRES_BACKUP="$BACKUP_DIR/postgres_backup_$TIMESTAMP.sql.gz"
if [ -f "$POSTGRES_BACKUP" ]; then
    echo -e "${GREEN}Restaurando PostgreSQL...${NC}"
    gunzip -c "$POSTGRES_BACKUP" | PGPASSWORD="postgres123" psql -h localhost -p 5432 -U student -d learning_sql
    echo -e "✓ PostgreSQL restaurado"
else
    echo -e "${RED}Backup de PostgreSQL no encontrado: $POSTGRES_BACKUP${NC}"
fi

# Restaurar SQLite
SQLITE_BACKUP="$BACKUP_DIR/sqlite_backup_$TIMESTAMP.db"
if [ -f "$SQLITE_BACKUP" ]; then
    echo -e "${GREEN}Restaurando SQLite...${NC}"
    cp "$SQLITE_BACKUP" "databases/sqlite/learning.db"
    echo -e "✓ SQLite restaurado"
fi

echo -e "${GREEN}✅ Restauración completada${NC}"
'

create_file "databases/scripts/performance_test.sh" '#!/bin/bash

# Script para pruebas de rendimiento de bases de datos

set -e

# Colores
GREEN="\\033[0;32m"
YELLOW="\\033[1;33m"
RED="\\033[0;31m"
NC="\\033[0m"

echo -e "${YELLOW}Iniciando pruebas de rendimiento...${NC}"

# Crear archivo de resultados
RESULTS_FILE="databases/performance/results_$(date +%Y%m%d_%H%M%S).txt"
mkdir -p databases/performance
echo "Performance Test Results - $(date)" > "$RESULTS_FILE"
echo "=====================================" >> "$RESULTS_FILE"

# Test MySQL
echo -e "${GREEN}Probando MySQL...${NC}"
if command -v mysql &> /dev/null; then
    START_TIME=$(date +%s%N)
    for i in {1..100}; do
        mysql -h localhost -P 3306 -u student -pstudent123 -e "SELECT 1" learning_sql > /dev/null
    done
    END_TIME=$(date +%s%N)
    MYSQL_TIME=$((($END_TIME - $START_TIME) / 1000000))
    echo "MySQL: 100 queries en ${MYSQL_TIME}ms" >> "$RESULTS_FILE"
    echo -e "✓ MySQL: ${MYSQL_TIME}ms"
else
    echo -e "${RED}MySQL no disponible${NC}"
fi

# Test PostgreSQL
echo -e "${GREEN}Probando PostgreSQL...${NC}"
if command -v psql &> /dev/null; then
    START_TIME=$(date +%s%N)
    for i in {1..100}; do
        PGPASSWORD="postgres123" psql -h localhost -p 5432 -U student -d learning_sql -c "SELECT 1" > /dev/null
    done
    END_TIME=$(date +%s%N)
    PSQL_TIME=$((($END_TIME - $START_TIME) / 1000000))
    echo "PostgreSQL: 100 queries en ${PSQL_TIME}ms" >> "$RESULTS_FILE"
    echo -e "✓ PostgreSQL: ${PSQL_TIME}ms"
else
    echo -e "${RED}PostgreSQL no disponible${NC}"
fi

# Test SQLite
echo -e "${GREEN}Probando SQLite...${NC}"
if command -v sqlite3 &> /dev/null && -f "databases/sqlite/learning.db" ]; then
    START_TIME=$(date +%s%N)
    for i in {1..100}; do
        sqlite3 databases/sqlite/learning.db "SELECT 1" > /dev/null
    done
    END_TIME=$(date +%s%N)
    SQLITE_TIME=$((($END_TIME - $START_TIME) / 1000000))
    echo "SQLite: 100 queries en ${SQLITE_TIME}ms" >> "$RESULTS_FILE"
    echo -e "✓ SQLite: ${SQLITE_TIME}ms"
else
    echo -e "${RED}SQLite no disponible${NC}"
fi

echo "" >> "$RESULTS_FILE"
echo -e "${GREEN}✅ Pruebas completadas${NC}"
echo -e "${YELLOW}Resultados guardados en: $RESULTS_FILE${NC}"
'

# Esquema de ejemplo - Sakila
create_file "databases/schemas/sakila/create_tables.sql" '-- Sakila Database Schema
-- Based on MySQL Sample Database

DROP DATABASE IF EXISTS sakila;
CREATE DATABASE sakila;
USE sakila;

-- Table: actor
CREATE TABLE actor (
    actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id),
    KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film
CREATE TABLE film (
    film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR DEFAULT NULL,
    language_id TINYINT UNSIGNED NOT NULL,
    original_language_id TINYINT UNSIGNED DEFAULT NULL,
    rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT UNSIGNED DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM("G","PG","PG-13","R","NC-17") DEFAULT "G",
    special_features SET("Trailers","Commentaries","Deleted Scenes","Behind the Scenes") DEFAULT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (film_id),
    KEY idx_title (title),
    KEY idx_fk_language_id (language_id),
    KEY idx_fk_original_language_id (original_language_id),
    CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film_actor
CREATE TABLE film_actor (
    actor_id SMALLINT UNSIGNED NOT NULL,
    film_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    KEY idx_fk_film_id (film_id),
    CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: category
CREATE TABLE category (
    category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film_category
CREATE TABLE film_category (
    film_id SMALLINT UNSIGNED NOT NULL,
    category_id TINYINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (film_id, category_id),
    CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: language
CREATE TABLE language (
    language_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name CHAR(20) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (language_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: inventory
CREATE TABLE inventory (
    inventory_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    film_id SMALLINT UNSIGNED NOT NULL,
    store_id TINYINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (inventory_id),
    KEY idx_fk_film_id (film_id),
    KEY idx_store_id_film_id (store_id, film_id),
    CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: store
CREATE TABLE store (
    store_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_staff_id TINYINT UNSIGNED NOT NULL,
    address_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEF_id),
    KEY idx_fk_address_id (address_id),
    CONSTRAINT fk_store_staff FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
'

# ----------------------------------------------------------------------------
# 4. ESTRUCTURA SRC (CÓDIGO FUENTE)
# ----------------------------------------------------------------------------
print_header "4. Creando estructura de código fuente (src/)"

# SQL
create_dir "src/sql/basics/01_select"
create_dir "src/sql/basics/02_filter"
create_dir "src/sql/basics/03_joins"
create_dir "src/sql/advanced/window_functions"
create_dir "src/sql/advanced/recursive_ctes"
create_dir "src/sql/advanced/query_optimization"
create_dir "src/sql/patterns/star_schema"
create_dir "src/sql/patterns/snowflake"
create_dir "src/sql/patterns/data_vault"
create_dir "src/sql/dbms_specific/mysql"
create_dir "src/sql/dbms_specific/postgresql"
create_dir "src/sql/dbms_specific/sqlite"
create_dir "src/sql/dbms_specific/oracle"

# Python
create_dir "src/python/database/sqlalchemy"
create_dir "src/python/database/psycopg2"
create_dir "src/python/database/mysql-connector"
create_dir "src/python/database/sqlite3"
create_dir "src/python/data_analysis/pandas"
create_dir "src/python/data_analysis/polars"
create_dir "src/python/web_frameworks/django"
create_dir "src/python/web_frameworks/flask"
create_dir "src/python/etl"

# R
create_dir "src/r/database"
create_dir "src/r/analysis/tidyverse"
create_dir "src/r/analysis/data.table"
create_dir "src/r/reports/rmarkdown"
create_dir "src/r/reports/quarto"

# Java
create_dir "src/java/jdbc"
create_dir "src/java/jpa/entities"
create_dir "src/java/jpa/repositories"
create_dir "src/java/jpa/queries"
create_dir "src/java/spring/spring-data-jpa"
create_dir "src/java/spring/spring-jdbc"

# JavaScript
create_dir "src/javascript/nodejs/mysql2"
create_dir "src/javascript/nodejs/pg"
create_dir "src/javascript/nodejs/sequelize"
create_dir "src/javascript/browser/indexeddb"
create_dir "src/javascript/browser/websql"
create_dir "src/javascript/frameworks/express"
create_dir "src/javascript/frameworks/nextjs"

# C++
create_dir "src/cpp/connectors/mysql-connector-cpp"
create_dir "src/cpp/connectors/pqxx"
create_dir "src/cpp/examples"

# C
create_dir "src/c/libpq"
create_dir "src/c/sqlite3"

# Crear archivos de ejemplo para SQL
create_file "src/sql/basics/01_select/examples.sql" '-- Ejemplos básicos de SELECT
-- Aprendiendo SQL - Capítulo 3

-- 1. SELECT simple
SELECT * FROM employees;

-- 2. Seleccionar columnas específicas
SELECT first_name, last_name, email 
FROM employees;

-- 3. Alias de columnas
SELECT 
    first_name AS nombre,
 last_name AS apellido,
    salary AS salario
FROM employees;

-- 4. Expresiones en SELECT
SELECT 
    first_name,
    last_name,
    salary,
    salary * 1.10 AS nuevo_salario
FROM employees;

-- 5. Funciones en SELECT
SELECT 
    UPPER(first_name) AS nombre_mayusculas,
    LOWER(last_name) AS apellido_minusculas,
    CONCAT(first_name, " ", last_name) AS nombre_completo,
    LENGTH(email) AS longitud_email
FROM employees;

-- 6. SELECT DISTINCT (valores únicos)
SELECT DISTINCT department_id FROM employees;

-- 7. SELECT con ORDER BY
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- 8. SELECT con LIMIT
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- 9. SELECT con OFFSET (paginación)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10 OFFSET 10;  -- Página 2

-- 10. SELECT con todas las cláusulas
SELECT 
    department_id,
    COUNT(*) AS total_empleados,
    AVG(salary) AS salario_promedio,
    MAX(salary) AS salario_maximo,
    MIN(salary) AS salario_minimo
FROM employees
WHERE salary > 30000
GROUP BY department_id
HAVING COUNT(*) > 5
ORDER BY salario_promedio DESC
LIMIT 5;
'

# Crear archivos de ejemplo para Python
create_file "src/python/database/sqlalchemy/models.py" '"""
Modelos SQLAlchemy para Learning SQL Notes
"""

from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, ForeignKey, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.sql import func
from datetime import datetime
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

# Base para modelos
Base = declarative_base()

class User(Base):
    """Modelo de usuario"""
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    full_name = Column(String(100))
    password_hash = Column(String(255))
    is_active = Column(Integer, default=1)
    created_at = Column(DateTime, default=func.ship("Exercise", back_populates="user")
    courses = relationship("UserCourse", back_populates="user")
    
    def __repr__(self):
        return f"<User(username={self.username}, email={self.email})>"

class Course(Base):
    """Modelo de curso"""
    __tablename__ = "courses"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(200), nullable=False)
    description = Column(Text)
    difficulty = Column(String(20), default="beginner")
    duration_hours = Column(Integer)
    created_at = Column(DateTime, default=func.now())
    
    # Relaciones
    exercises = relationship("Exercise", back_populates="course")
    user_courses = relationship("UserCourse", back_populates="course")
    
    def __repr__(self):
        return f"<Course(title={self.title}, difficulty={self.difficulty})>"

class Exercise(Base):
    """Modelo de ejercicio"""
    __tablename__ = "exercises"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    title = Column(String(200), nullable=False)
    description = Column(Text)
    solution = Column(Text)
    difficulty = Column(String(20), default="medium")
    created_at = Column(DateTime, default=func.now())
    
    # Relaciones
    course = relationship("Course", back_populates="exercises")
    user = relationship("User", back_populates="exercises")
    
    def __repr__(self):
        return f"<Exerciscursos"""
    __tablename__ = "user_courses"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    course_id = Column(Integer, ForeignKey("courses.id"), nullable=False)
    enrollment_date = Column(DateTime, default=func.now())
    completion_date = Column(DateTime)
    progress = Column(Float, default=0.0)
    
    # Relaciones
    user = relationship("User", back_populates="courses")
    course = relationship("Course", back_populates="user_courses")
    
    def __repr__(self):
        return f"<UserCourse(user_id={self.user_id}, course_id={self.course_id})>"

# Configuración de la base de datos
def get_database_url():
    """Obtener URL de base de datos desde variables de entorno"""
    db_type = os.getenv("DB_TYPE", "sqlite")
    
    if db_type == "mysql":
        return f"mysql+mysqlconnector://{os.getenv('MYSQL_USER')}:{os.getenv('MYSQL_PASSWORD')}@{os.getenv('MYSQL_HOST')}:{os.getenv('MYSQL_PORT')}/{os.getenv('MYSQL_DATABASE')}"
    elif db_type == "postgresql":
        return f"postgresql+psycopg2://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}/{os.getenv('POSTGRES_DATABASE')}"
    else:
        # SQLite por defecto
        return "sqlite:///databases/sqlite/learning.db"

# Crear engine y sesión
engine = create_engine(get_database_url(), echo=False)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def init_database():
    """Inicializar la base de datos creando las tablas"""
    Base.metadata.create_all(bind=engine)
    print("✅ Base de datos inicializada")

def get_session():
    """Obtener sesión de base de datos"""
    session = SessionLocal()
    try:
        yield session
    finally:
        session.close()

if __name__ == "__main__":
    init_database()
'

# ----------------------------------------------------------------------------
# 5. DOCUMENTACIÓN
# ----------------------------------------------------------------------------
print_header "5. Creando estructura de documentación"

# Mantener tus archivos actuales de docs/ y moverlos a la nueva estructura si es necesario
print_info "Manteniendo estructura actual de docs/"

# Crear directorios adicionales para docs
create_dir "docs/api/sql"
create_dir "docs/api/python"
create_dir "docs/api/rest"
create_dir "docs/tutorials/getting_started"
create_dir "docs/tutorials/advanced_queries"
create_dir "docs/tutorials/performance_tuning"
create_dir "docs/translations/es"
create_dir "docs/translations/pt"

# Actualizar _quarto.yml si existe
if [ -f "docs/_quarto.yml" ]; then
    print_info "Archivo _quarto.yml ya existe, manteniendo"
else
    create_file "docs/_quarto.yml" 'project:
  type: website
  output-dir: _site

website:
  title: "Learning SQL Notes"
  description: "Documentación completa para aprender SQL y su integración con múltiples lenguajes"
  navbar:
    left:
      - href: index.qmd
        text: Inicio
      - href: chapters/01/01.qmd
        text: Capítulos
      - href: tutorials/getting_started/index.qmd
        text: Tutoriales
      - href: api/sql/index.qmd
        text: API
      - href: https://github.com/emanuel/learning-sql-notes
        text: GitHub
        icon: github

format:
  html:
    thecosmo
    css: styles.css
    toc: true
    toc-depth: 3
    code-link: true
    code-overflow: wrap
    
  pdf:
    documentclass: article
    papersize: letter
    
execute:
  echo: false
  warning: false
  freeze: auto

bibliography: references.bib

crossref:
  chapters: true
  sections: true
  tables: true
  figures: true'
fi

# ----------------------------------------------------------------------------
# 6. EJERCICIOS
# ----------------------------------------------------------------------------
print_header "6. Creando estructura de ejercicios"

# SQL Exercises
create_dir "exercises/sql/basic/01_select_statements"
create_dir "exercises/sql/basic/02_filtering_data"
create_dir "exercises/sql/intermediate/joins"
create_dir "exercises/sql/intermediate/subqueries"
create_dir "exercises/sql/intermediate/aggregation"
create_dir "exercises/sql/advanced/window_functions"
create_dir "exercises/sql/advanced/recursive_queries"
create_dir "exercises/sql/advanced/query_optimization"
create_dir "exercises/sql/projectmplo
create_file "exercises/sql/basic/01_select_statements/problem.md" '# Ejercicio 1: Consultas SELECT Básicas

## Objetivo
Practicar el uso de la cláusula SELECT para recuperar datos de una base de datos.

## Base de Datos
Utilizarás la base de datos `employees` con las siguientes tablas:

### Tabla: employees
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    job_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    department_id INT
);
```

### Tabla: departments
```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);
```

## Ejercicios

### 1. Consulta Simple
Selecciona todos los empleados de la tabla `employees`.

**Pista:** Usa `SELECT *`

### 2. Columnas Específicas
Muestra slo el nombre, apellido y email de todos los empleados.

### 3. Ordenar Resultados
Lista todos los empleados ordenados por apellido en orden ascendente.

### 4. Filtrar por Fecha
Encuentra todos los empleados contratados después del 1 de enero de 2020.

### 5. Filtrar por Salario
Selecciona empleados con salario mayor a 50000.


# ----------------------------------------------------------------------------
# 9. HERRAMIENTAS
# ----------------------------------------------------------------------------
print_header "9. Creando estructura de herramientas"

create_dir "tools/database"
create_dir "tools/documentation"
create_dir "tools/deployment"

# Herramienta de ejemplo
create_file "tools/database/query_analyzer.py" '#!/usr/bin/env python3
"""
Analizador de consultas SQL
Herramienta para analizar y optimizar consultas SQL
"""

import sqlparse
from sqlparse.sql import Statement
from sqlparse.tokens import Keyword, DML
import re
from typing import List, Dict, Any
from dataclasses import dataclass
from rich.console import Console
from rich.table import Table
from rich import print as rprint
import argparse

console = Console()

@dataclass
class QueryAnalysis:
    """Resultados del análisis de una consulta"""
    query: str
    tokens: int
    statements: int
    keywords: List[str]
    tables: List[str]
    complexity_score: float
    suggestions: List[str]
    execution_time: float = 0.0

class QueryAnalyzer:
    """Analizador de consultas SQL"""
    
    def __init__(self):
        self.complex_keywords = {
            "JOIN", "SUBQUERY", "UNION", "INTERSECT", "EXCEPT",
            "WINDOW", "PARTITION BY", "ORDER BY", "GROUP BY",
            "HAVING", "DISTINCT", "OVER"
        }
    
    def analyze(self, query: str) -> QueryAnalysis:
        """Analizar una consulta SQL"""
        
        # Parsear la consulta
        parsed = sqlparse.parse(query)
        statements = list(parsed)
        
        # Extraer tokens
        all_tokens = []
        for stmt in statements:
            all_tokens.extend(list(stmt.flatten()))
        
        # Encontrar palabras clave
        keywords = []
        for token in all_tokens:
            if token.ttype is Keyword:
                keywords.append(str(token).upper())
        
        # Encontrar tablas (simplificado)
        tables = self._extract_tables(query)
        
        # Calcular complejidad
        complexity = self._calculate_complexity(query, keywords)
        
        # Generar sugerencias
        suggestions = self._generate_suggestions(query, complexity, tables)
        
        return QueryAnalysis(
            query=query,
            tokens=len(all_tokens),
            statements=len(statements),
            keywords=list(set(keywords)),
            tables=tables,
            complexity_score=complexity,
            suggestions=suggestions
        )
    
    def _extract_tables(self, query: str) -> List[str]:
        """Extraer nombres de tablas de la consulta"""
        # Expresión regular simple para encontrar FROM y JOIN
        table_pattern = r"(?:FROM|JOIN)\s+(\w+)"
        matches = re.findall(table_pattern, query, re.IGNORECASE)
        return list(set(matches))
    
    def _calculate_complexity(self, query: str, keywords: List[str]) -> float:
        """Calcular puntuación de complejidad"""
        score = 0.0
        
        # Base por longitud
        score += len(query) / 1000
        
        # Por palabras clave complejas
        complex_count = sum(1 for kw in keywords if kw in self.complex_keywords)
        score += complex_count * 0.5
        
        # Por subconsultas
        subquery_count = query.count("SELECT") - 1
        if subquery_count > 0:
            score += subquery_count * 0.7
        
        # Por joins
        join_count = keywords.count("JOIN")
        score += join_count * 0.3
        
        return round(score, 2)
    
    def _generate_suggestions(self, query: str, complexity: float, tables: List[str]) -> List[str]:
        """Generar sugerencias de optimización"""
        suggestions = []
        
        if complexity > 3.0:
            suggestions.append("Considera dividir esta consulta en múltiples consultas más simples")
        
        if "SELECT *" in query.upper():
            suggestions.append("Especifica las columnas necesarias en lugar de usar SELECT *")
        
        if len(tables) > 5:
            suggestions.append("Muchas tablas en JOIN, considera revisar el diseño del esquema")
        
        if "WHERE" in query.upper() and "LIKE" in query.upper() and "%" in query:
            suggestions.append("Usar LIKE con % al inicio puede ser lento, considera full-text search")
        
        if not suggestions:
            suggestions.append("Consulta bien optimizada")
        
        return suggestions
    
    def display_analysis(self, analysis: QueryAnalysis):
        """Mostrar análisis en formato tabular"""
        
        table = Table(title="Análisis de Consulta SQL")
        table.add_column("Métrica", style="cyan")
        table.add_column("Valor", style="green")
        
        table.add_row("Longitud (caracteres)", str(len(analysis.query)))
        table.add_row("Tokens", str(analysis.tokens))
        table.add_row("Statements", str(analysis.statements))
        table.add_row("Tablas", ", ".join(analysis.tables) if analysis.tables else "Ninguna")
        table.add_row("Complejidad", str(analysis.complexity_score))
        table.add_row("Palabras Clave", ", ".join(analysis.keywords))
        
        console.print(table)
        
        # Sugerencias
        if analysis.sugysis.suggestions, 1):
                console.print(f"  {i}. {suggestion}")

def main():
    """Función principal"""
    parser = argparse.ArgumentParser(description="Analizador de consultas SQL")
    parser.add_argument("query", nargs="?", help="Consulta SQL a analizar")
    parser.add_argument("-f", "--file", help="Archivo con consultas SQL")
    parser.add_argument("-v", "--verbose", action="store_true", help="Modo verbose")
    
    args = parser.parse_args()
    
    analyzer = QueryAnalyzer()
    
    if args.file:
        with open(args.file, "r") as f:
            queries = f.read()
            analysis = analyzer.analyze(queries)
            analyzer.display_analysis(analysis)
    elif args.query:
        analysis = analyzer.analyze(args.query)
        analyzer.display_analysis(analysis)
    else:
        # Modo interactivo
        console.print("[bold cyan]Analizador de Consultas SQL[/bold cyan]")
        console.print("Escribe tu consulta SQL (termina con ; y línea vacía):")
        
        lines = []
        while True:
            try:
                line = input()
                if line.strip() == "" and len(lines) > 0:
                    break
                lines.append(line)
            except EOFError:
                break
        
        query = "\n".join(lines)
        if query.strip():
            analysis = analyzer.analyze(query)
            analyzer.display_analysis(analysis)
        else:
            console.print("[red]No se proporcionó consulta[/red]")

if __name__ == "__main__":
    main()
'

# ----------------------------------------------------------------------------
# 10. ASSETS
# ----------------------------------------------------------------------------
print_header "10. Creando estructura de assets"

create_dir "assetsimages/er_diagrams"
create_dir "assets/images/query_plans"
create_dir "assets/images/screenshots"
create_dir "assets/data/raw"
create_dir "assets/data/processed"
create_dir "assets/data/samples"

# Mover diagrams existentes a assets/
print_info "Moviendo diagrams/ existente a assets/diagrams/"
if [ -d "diagrams" ]; then
    mv diagrams/* assets/diagrams/ 2>/dev/null || true
    rmdir diagrams 2>/dev/null || true
fi

# Crear diagrama de ejemplo
create_file "assets/diagrams/erd/sakila.erd" 'erDiagram
    actor {
        int actor_id PK
        string first_name
        string last_name
        timestamp last_update
    }
    
    film {
        int film_id PK
        string title
        text description
        year release_year
        int language_id FK
        int original_language_id FK
        int rental_duration
        decimal rental_rate
        int length
        decimal replacement_cost
        enum rating
        set special_features
        timestamp last_update
    }
    
    film_actor {
          string name
        timestamp last_update
    }
    
    film_category {
        int film_id FK
        int category_id FK
        timestamp last_update
    }
    
    language {
        int language_id PK
        string name
        timestamp last_update
    }
    
    actor ||--o{ film_actor : performs
    film ||--o{ film_actor : features
    film ||--o{ film_category : categorized
    category ||--o{ film_category : includes
    language ||--o{ film : in_language
    language ||--o{ film : original_language
'

# ----------------------------------------------------------------------------
# 11. LIMPIEZA Y ORGANIZACIÓN FINAL
# ----------------------------------------------------------------------------
print_header "11. Limpieza y organización final"

# Dar permisos de ejecución a scripts
chmod +x databases/scripts/*.sh 2>/dev/null || true
chmod +x tools/database/*.py 2>/dev/null || true
chmod +x setup_learning_sql.sh 2>/dev/null || true

# Mover archivos existentes a ubicaciones apropiadas
print_info "Organizando archivos existentes..."

# Mover sqlite3 si es un archivo ejecutable
if [ -f "sqlite3" ]; then
    mv sqlite3 tools/ 2>/dev/null || true
    print_success "Movido sqlite3 a tools/"
fi

# Verificar estructura LaTeX existente
if [ -d "latex" ]; then
    print_success "Estructura LaTeX mantenida en latex/"
fi

# ----------------------------------------------------------------------------
# RESUMEN FINAL
# ----------------------------------------------------------------------------
print_header "✅ ESTRUCTURA COMPLETADA"

echo -e "${GREEN}Se ha creado exitosamente la estructura profesional con:${NC}"
echo ""
echo -e "${YELLOW}�� Directorios creados:${NC}"
echo "  • .github/workflows/       (CI/CD)"
echo "  • config/                   (Configuraciones)"
echo "  • databases/               (Esquemas y migraciones)"
echo "  • src/                     (Código multi-lenguaje)"
echo "  • exercises/               (Ejercicios organizados)"
echo "  • notebooks/               (Jupyter notebooks)"
echo "  • tests/                   (Tests automatizados)"
echo "  • tools/                   (Herramientas)"
echo "  • assets/                  (Recursos)"
echo ""
echo -e "${YELLOW}📄 Archivos creados:${NC}"
echo "  • .gitignore               (Archivos a ignorar)"
echo "  • pyproject.toml          (Config Python moderna)"
echo "  • package.json            (Config JavaScript)"
echo "  • Makefile                (Comandos automatizados)"
echo "  • requirements.txt        (Dependencias Python)"
echo "  • Dockerfile              (Contenedor unificado)"
echo "  • 20+ archivos de ejemplo y configuración"
echo ""
echo -e "${YELLOW}🚀 Próximos pasos:${NC}"
echo "  1. Revisar la estructura creada"
echo "  2. Ejecutar: chmod +x create_professional_structure.sh"
echo "  3. Actualizar README.md con tu información"
echo "  4. Configurar tus credenciales en config/environments/"
echo "  5. Iniciar con: make setup && make databases"
echo ""
echo -e "${GREEN}¡Estructura lista para desarrollo profesional! 🎉${NC}"
