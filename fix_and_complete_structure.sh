#!/bin/bash

# ============================================================================
# Script para completar la estructura faltante y corregir problemas
# ============================================================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Completando estructura faltante...${NC}"

# ----------------------------------------------------------------------------
# 1. CORREGIR SCRIPT ORIGINAL (quitar la parte problemática)
# ----------------------------------------------------------------------------
echo -e "${YELLOW}1. Corrigiendo script original...${NC}"
# Eliminar la parte problemática del script anterior
if [ -f "create_professional_structure.sh" ]; then
    # Crear una copia de respaldo
    cp create_professional_structure.sh create_professional_structure.sh.backup
    
    # Eliminar las líneas problemáticas (ejercicios 7-10)
    head -n 1600 create_professional_structure.sh > temp.sh
    tail -n +1800 create_professional_structure.sh >> temp.sh
    mv temp.sh create_professional_structure.sh
    chmod +x create_professional_structure.sh
    echo -e "${GREEN}✓ Script corregido${NC}"
fi

# ----------------------------------------------------------------------------
# 2. COMPLETAR DIRECTORIOS FALTANTES
# ----------------------------------------------------------------------------
echo -e "${YELLOW}2. Creando directorios faltantes...${NC}"

# Assets
mkdir -p assets/images/er_diagrams
mkdir -p assets/images/query_plans
mkdir -p assets/images/screenshots
mkdir -p assets/data/raw
mkdir -p assets/data/processed
mkdir -p assets/data/samples
mkdir -p assets/diagrams/erd
mkdir -p assets/diagrams/flowcharts

echo -e "${GREEN}✓ Assets creados${NC}"

# Tests
mkdir -p tests/unit/sql
mkdir -p tests/unit/python
mkdir -p tests/unit/java
mkdir -p tests/integration/database_tests
mkdir -p tests/integration/api_tests
mkdir -p tests/performance/load_testing
mkdir -p tests/performance/query_benchmarks

echo -e "${GREEN}✓ Tests creados${NC}"

# Tools
mkdir -p tools/database
mkdir -p tools/documentation
mkdir -p tools/deployment

echo -e "${GREEN}✓ Tools creados${NC}"

# Notebooks
mkdir -p notebooks/sql
mkdir -p notebooks/python
mkdir -p notebooks/r

echo -e "${GREEN}✓ Notebooks creados${NC}"

# Exercises - proyectos
mkdir -p exercises/sql/projects/ecommerce
mkdir -p exercises/sql/projects/library
mkdir -p exercises/sql/projects/analytics

# Exercises - otros lenguajes
mkdir -p exercises/python/{basic,intermediate,advanced}
mkdir -p exercises/r/{basic,intermediate,advanced}
mkdir -p exercises/java/{basic,intermediate,advanced}
mkdir -p exercises/javascript/{basic,intermediate,advanced}
mkdir -p exercises/cpp/{basic,intermediate,advanced}
mkdir -p exercises/c/{basic,intermediate,advanced}

echo -e "${GREEN}✓ Ejercicios completados${NC}"

# .github
mkdir -p .github/workflows
echo -e "${GREEN}✓ GitHub workflows creados${NC}"

# ----------------------------------------------------------------------------
# 3. CREAR ARCHIVOS FALTANTES CRÍTICOS
# ----------------------------------------------------------------------------
echo -e "${YELLOW}3. Creando archivos faltantes críticos...${NC}"

# docker-compose.yml (si no existe)
if [ ! -f "docker-compose.yml" ]; then
    cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: learning-sql-mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: learning_sql
      MYSQL_USER: student
      MYSQL_PASSWORD: student123
      MYSQL_INITDB_SKIP_TZINFO: 1
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./databases/schemas:/docker-entrypoint-initdb.d
    command: 
      - --default-authentication-plugin=mysql_native_password
      - --character-set-server=utf8mb4
      - --collation-server=utf8mb4_unicode_ci
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      timeout: 20s
      retries: 10

  postgres:
    image: postgres:15-alpine
    container_name: learning-sql-postgres
    environment:
      POSTGRES_PASSWORD: postgres123
      POSTGRES_USER: student
      POSTGRES_DB: learning_sql
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./databases/schemas:/docker-entrypoint-initdb.d
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U student"]
      interval: 10s
      timeout: 5s
      retries: 5

  adminer:
    image: adminer
    container_name: learning-sql-adminer
    ports:
      - "8080:8080"
    depends_on:
      - mysql
      - postgres

volumes:
  mysql_data:
  postgres_data:
EOF
    echo -e "${GREEN}✓ docker-compose.yml creado${NC}"
fi

# README.md actualizado
cat > README.md << 'EOF'
# 🎓 Learning SQL & Programming Notes

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.8+-blue.svg)
![SQL](https://img.shields.io/badge/SQL-MySQL%20|%20PostgreSQL%20|%20SQLite-green)

Un repositorio profesional para aprender SQL y su integración con múltiples lenguajes de programación.

## 🚀 Características

- ✅ **SQL Completo**: Desde básico hasta avanzado
- ✅ **Multi-lenguaje**: Python, R, Java, JavaScript, C++, C
- ✅ **Entorno Dockerizado**: Bases de datos preconfiguradas
- ✅ **Ejercicios prácticos**: Con soluciones paso a paso
- ✅ **Documentación interactiva**: Con Quarto y Jupyter
- ✅ **Tests automatizados**: Para validar tu aprendizaje

## 📋 Prerrequisitos

- Docker y Docker Compose
- Git
- Python 3.8+ (opcional)

## 🛠️ Configuración Rápida

```bash
# 1. Clonar repositorio
git clone https://github.com/tu-usuario/learning-sql-notes.git
cd learning-sql-notes

# 2. Iniciar bases de datos
docker-compose up -d

# 3. Acceder a Adminer
# http://localhost:8080
# Sistema: MySQL
# Servidor: mysql
# Usuario: student
# Contraseña: student123
# Base de datos: learning_sql
```

## 📚 Estructura

```
learning-sql-notes/
├── src/           # Código fuente por lenguaje
├── docs/          # Documentación y capítulos
├── exercises/     # Ejercicios por nivel
├── databases/     # Schemas y migraciones
├── notebooks/     # Notebooks interactivos
├── tests/         # Tests automatizados
└── tools/         # Herramientas de desarrollo
```

## 🎯 Roadmap

### Nivel Básico
1. SQL Fundamentals
2. Joins Básicos
3. Agregaciones
4. Subconsultas

### Nivel Intermedio
1. Joins Avanzados
2. Window Functions
3. CTEs
4. Índices y Optimización

### Nivel Avanzado
1. Recursive CTEs
2. JSON en SQL
3. Full-Text Search
4. Partitioning

## 📖 Documentación

La documentación está en `docs/` y usa Quarto. Para generarla:

```bash
# Instalar Quarto (si no está instalado)
# Visita: https://quarto.org/docs/get-started/

# Generar documentación
quarto render docs/
```

## 🧪 Ejecutar Tests

```bash
# Tests unitarios
pytest tests/ -v

# Tests específicos de SQL
pytest tests/unit/sql/
```

## 🤝 Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia

MIT License - ver `LICENSE.md` para detalles.
EOF

echo -e "${GREEN}✓ README.md actualizado${NC}"

# ----------------------------------------------------------------------------
# 4. CREAR ARCHIVOS DE EJEMPLO FALTANTES
# ----------------------------------------------------------------------------
echo -e "${YELLOW}4. Creando archivos de ejemplo...${NC}"

# Ejercicio de ejemplo
cat > exercises/sql/basic/01_select_statements/problem.md << 'EOF'
# Ejercicio 1: Consultas SELECT Básicas

## Objetivo
Practicar el uso de la cláusula SELECT para recuperar datos.

## Base de Datos
Utilizarás la base de datos `employees`:

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT
);
```

## Ejercicios

1. Selecciona todos los empleados
2. Muestra nombre, apellido y email
3. Ordena por apellido ascendente
4. Filtra por fecha de contratación > 2020-01-01
5. Encuentra empleados con salario > 50000
6. Limita a 10 resultados
7. Muestra department_id únicos
8. Calcula salario anual (salario * 12)
9. Concatena nombre completo
10. Agrupa por departamento con conteo
EOF

echo -e "${GREEN}✓ Ejercicio de ejemplo creado${NC}"

# Notebook de ejemplo simple
cat > notebooks/sql/basics.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# SQL Basics Notebook\n",
    "\n",
    "Este notebook contiene ejemplos básicos de SQL."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Ejemplo básico\n",
    "import sqlite3\n",
    "\n",
    "# Conectar a SQLite\n",
    "conn = sqlite3.connect(\":memory:\")\n",
    "cursor = conn.cursor()\n",
    "\n",
    "# Crear tabla de ejemplo\n",
    "cursor.execute(\"\"\"\n",
    "CREATE TABLE employees (\n",
    "    id INTEGER PRIMARY KEY,\n",
    "    name TEXT,\n",
    "    department TEXT,\n",
    "    salary REAL\n",
    ")\n",
    "\"\"\")\n",
    "\n",
    "# Insertar datos\n",
    "employees = [\n",
    "    (1, 'Juan Pérez', 'IT', 50000),\n",
    "    (2, 'María García', 'HR', 45000),\n",
    "    (3, 'Carlos López', 'IT', 55000),\n",
    "    (4, 'Ana Martínez', 'Sales', 48000)\n",
    "]\n",
    "\n",
    "cursor.executemany(\"INSERT INTO employees VALUES (?, ?, ?, ?)\", employees)\n",
    "conn.commit()\n",
    "\n",
    "print(\"✅ Base de datos creada con datos de ejemplo\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

echo -e "${GREEN}✓ Notebook de ejemplo creado${NC}"

# Test de ejemplo
cat > tests/unit/python/test_basics.py << 'EOF'
"""
Tests básicos para Learning SQL Notes
"""

def test_addition():
    """Test básico de suma"""
    assert 1 + 1 == 2

def test_string():
    """Test básico de strings"""
    assert "hello".upper() == "HELLO"

def test_list():
    """Test básico de listas"""
    numbers = [1, 2, 3]
    assert len(numbers) == 3
    assert sum(numbers) == 6

if __name__ == "__main__":
    import pytest
    pytest.main([__file__, "-v"])
EOF

echo -e "${GREEN}✓ Test de ejemplo creado${NC}"

# Herramienta de ejemplo
cat > tools/database/simple_query.py << 'EOF'
#!/usr/bin/env python3
"""
Herramienta simple para ejecutar consultas SQL
"""

import sqlite3
import sys

def execute_query(query, db_path=":memory:"):
    """Ejecutar una consulta SQL"""
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute(query)
        
        if query.strip().upper().startswith("SELECT"):
            results = cursor.fetchall()
            return results
        else:
            conn.commit()
            return f"Query executed successfully. Rows affected: {cursor.rowcount}"
            
    except sqlite3.Error as e:
        return f"Error: {e}"
    finally:
        if conn:
            conn.close()

def main():
    """Función principal"""
    if len(sys.argv) < 2:
        print("Usage: python simple_query.py \"SQL_QUERY\" [database_file]")
        return
    
    query = sys.argv[1]
    db_path = sys.argv[2] if len(sys.argv) > 2 else ":memory:"
    
    result = execute_query(query, db_path)
    print(result)

if __name__ == "__main__":
    main()
EOF

chmod +x tools/database/simple_query.py
echo -e "${GREEN}✓ Herramienta de ejemplo creada${NC}"

# Archivo .gitignore adicional
cat >> .gitignore << 'EOF'

# Configuraciones locales
local.env
*.local

# Archivos temporales de desarrollo
*.swp
*.swo
*~
.DS_Store

# Output de notebooks
.ipynb_checkpoints/
__pycache__/

# Virtual environments
.venv/
venv/
env/

# Logs
*.log
logs/

# IDE
.vscode/
.idea/
*.iml
EOF

echo -e "${GREEN}✓ .gitignore actualizado${NC}"

# ----------------------------------------------------------------------------
# 5. MOVER DIAGRAMAS EXISTENTES
# ----------------------------------------------------------------------------
echo -e "${YELLOW}5. Moviendo diagramas existentes...${NC}"

# Mover diagrams/ a assets/diagrams/ si existe
if [ -d "diagrams" ]; then
    if [ ! -d "assets/diagrams" ]; then
        mkdir -p assets/diagrams
    fi
    mv diagrams/* assets/diagrams/ 2>/dev/null || true
    rmdir diagrams 2>/dev/null || true
    echo -e "${GREEN}✓ Diagramas movidos a assets/diagrams/${NC}"
fi

# Mover sqlite3 a tools/ si existe
if [ -f "sqlite3" ]; then
    mv sqlite3 tools/ 2>/dev/null || true
    echo -e "${GREEN}✓ sqlite3 movido a tools/${NC}"
fi

# ----------------------------------------------------------------------------
# 6. DAR PERMISOS DE EJECUCIÓN
# ----------------------------------------------------------------------------
echo -e "${YELLOW}6. Dando permisos de ejecución...${NC}"

chmod +x databases/scripts/*.sh 2>/dev/null || true
chmod +x tools/database/*.py 2>/dev/null || true
chmod +x setup_learning_sql.sh 2>/dev/null || true

echo -e "${GREEN}✓ Permisos asignados${NC}"

# ----------------------------------------------------------------------------
# 7. CREAR ARCHIVO .env DE EJEMPLO
# ----------------------------------------------------------------------------
echo -e "${YELLOW}7. Creando archivo .env de ejemplo...${NC}"

cat > .env.example << 'EOF'
# Configuración de desarrollo
DEBUG=true
ENVIRONMENT=development

# Base de datos MySQL
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=student
MYSQL_PASSWORD=student123
MYSQL_DATABASE=learning_sql

# Base de datos PostgreSQL
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=student
POSTGRES_PASSWORD=postgres123
POSTGRES_DATABASE=learning_sql

# SQLite
SQLITE_PATH=databases/sqlite/learning.db

# Aplicación
APP_PORT=5000
APP_SECRET=change_this_in_production

# Para usar: copiar a .env y modificar valores
EOF

echo -e "${GREEN}✓ .env.example creado${NC}"

# ----------------------------------------------------------------------------
# RESUMEN FINAL
# ----------------------------------------------------------------------------
echo -e "\n${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║ ✅ ESTRUCTURA COMPLETADA CON ÉXITO                       ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Estructura final:${NC}"
echo -e "${YELLOW}📁 Directorios creados/completados:${NC}"
echo "  • assets/              (imágenes, datos, diagramas)"
echo "  • tests/               (tests unitarios e integración)"
echo "  • tools/               (herramientas de desarrollo)"
echo "  • notebooks/           (Jupyter notebooks)"
echo "  • exercises/projects/  (proyectos completos)"

echo -e "\n${YELLOW}📄 Archivos importantes creados:${NC}"
echo "  • docker-compose.yml   (configuración Docker)"
echo "  • README.md            (documentación actualizada)"
echo "  • .env.example         (variables de entorno)"
echo "  • Ejemplos en exercises/, tests/, notebooks/"

echo -e "\n${YELLOW}🚀 Para comenzar:${NC}"
echo "  1. Revisar la estructura: tree -L 2"
echo "  2. Copiar .env.example a .env: cp .env.example .env"
echo "  3. Iniciar bases de datos: docker-compose up -d"
echo "  4. Explorar los ejemplos en src/, exercises/, notebooks/"
echo "  5. Ejecutar tests: pytest tests/ -v"

echo -e "\n${GREEN}¡Listo para desarrollar! 🎉${NC}"
