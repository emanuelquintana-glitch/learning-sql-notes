#!/bin/bash

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

