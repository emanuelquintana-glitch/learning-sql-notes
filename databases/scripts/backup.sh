#!/bin/bash

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
    sqlite3 databases/sqlite/learning.db ".backup /sqlite_backup_.db"
    echo -e "✓ Backup SQLite completado: $BACKUP_DIR/sqlite_backup_$TIMESTAMP.db"
fi

# Limpiar backups antiguos
echo -e "${YELLOW}Limpiando backups antiguos (más de $RETENTION_DAYS días)...${NC}"
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +$RETENTION_DAYS -delete
find "$BACKUP_DIR" -type f -name "*.db" -mtime +$RETENTION_DAYS -delete

echo -e "${GREEN}✅ Proceso de backup completado${NC}"
echo -e "${YELLOW}Backups guardados en: $BACKUP_DIR${NC}"

