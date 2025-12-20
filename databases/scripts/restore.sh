#!/bin/bash

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

