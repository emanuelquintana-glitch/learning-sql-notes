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
