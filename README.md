<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL%20%7C%20PostgreSQL%20%7C%20SQLite-blue" alt="SQL">
  <img src="https://img.shields.io/badge/Python-3.8%2B-blue" alt="Python">
  <img src="https://img.shields.io/badge/Java-8%2B-orange" alt="Java">
  <img src="https://img.shields.io/badge/JavaScript-ES6%2B-yellow" alt="JavaScript">
  <img src="https://img.shields.io/badge/Licencia-Educativa-green" alt="Licencia">
  <img src="https://img.shields.io/badge/UPTC-Econom%C3%ADa-red" alt="UPTC">
</p>

<h1 align="center">
   Learning SQL & Programming Notes
</h1>

<p align="center">
  <strong>Portafolio de aprendizaje profesional - SQL y programación multi-lenguaje</strong>
</p>

<p align="center">
  <a href="#-características">Características</a> •
  <a href="#-estructura-del-proyecto">Estructura</a> •
  <a href="#-roadmap-de-aprendizaje">Roadmap</a> •
  <a href="#-tecnologías">Tecnologías</a> •
  <a href="#-configuración-rápida">Configuración</a> •
  <a href="#-autor">Autor</a>
</p>

<div align="center">
  
  ```sql
  -- Este proyecto transforma conocimiento en código
  SELECT conocimiento, práctica, proyecto 
  FROM aprendizaje 
  WHERE estudiante = 'Emanuel Quintana';
  ```
  
</div>

##  Características

###  **Aprendizaje Integral**
- **SQL Completo**: Desde `SELECT` básico hasta funciones de ventana y optimización
- **7 Lenguajes**: Python, R, Java, JavaScript, C++, C, SQL
- **Entorno Dockerizado**: MySQL, PostgreSQL, SQLite listos para usar
- **Proyectos Reales**: E-commerce, biblioteca, analítica de datos

### ️ **Herramientas Profesionales**
- **Documentación Interactiva**: Quarto + Jupyter Notebooks
- **Testing Automatizado**: Unit tests, integración, performance
- **CI/CD**: GitHub Actions preconfigurado
- **Gestión de Bases de Datos**: Migraciones, backups, seeds

###  **Enfoque Educativo**
- **Ejercicios Graduales**: Básico → Intermedio → Avanzado
- **Ejemplos Prácticos**: Código listo para ejecutar
- **Buenas Prácticas**: Estructura limpia y documentada
- **Portafolio**: Demostración de habilidades técnicas

##  Estructura del Proyecto

```
learning-sql-notes/
├──  docs/                    # Documentación interactiva (Quarto)
├──  src/                     # Código fuente por lenguaje
│   ├── python/                # SQLAlchemy, Pandas, Flask, Django
│   ├── java/                  # JDBC, JPA, Spring
│   ├── javascript/            # Node.js, Express, Sequelize
│   ├── r/                     # tidyverse, data.table
│   ├── c++/                   # MySQL Connector/C++, pqxx
│   ├── c/                     # libpq, SQLite3 C API
│   └── sql/                   # Consultas, patrones, optimización
├──  exercises/              # Ejercicios por nivel y lenguaje
├── ️ databases/              # Bases de datos y migraciones
├──  notebooks/              # Jupyter Notebooks interactivos
├── ️ tests/                  # Tests automatizados
├──  tools/                  # Herramientas de desarrollo
├──  assets/                 # Diagramas, imágenes, datos
└──  config/                 # Configuraciones del proyecto
```

###  Estadísticas del Proyecto
- **199 directorios** organizados profesionalmente
- **68 archivos** de código y documentación
- **7 lenguajes** de programación
- **3 sistemas de bases de datos** (MySQL, PostgreSQL, SQLite)
- **Niveles de dificultad**: Básico, Intermedio, Avanzado

##  Roadmap de Aprendizaje

###  **Nivel Básico** (Fundamentos)
1. **SQL Essentials**
   - Consultas SELECT, filtrado, ordenamiento
   - Funciones agregadas (COUNT, SUM, AVG)
   - Joins básicos (INNER, LEFT, RIGHT)

2. **Programación Multi-Lenguaje**
   - Conexiones a bases de datos
   - Consultas parametrizadas
   - Manejo básico de resultados

###  **Nivel Intermedio** (Aplicación)
1. **SQL Intermedio**
   - Subconsultas y CTEs
   - Funciones de ventana
   - Transacciones y aislamiento

2. **Integración Avanzada**
   - ORMs (SQLAlchemy, Hibernate)
   - APIs REST con bases de datos
   - Procesamiento de datos (Pandas, tidyverse)

###  **Nivel Avanzado** (Maestría)
1. **SQL Avanzado**
   - Query optimization
   - Índices y particionamiento
   - Full-text search
   - JSON en SQL

2. **Arquitecturas Complejas**
   - Microservicios con bases de datos
   - Data pipelines (ETL/ELT)
   - Big Data y SQL distribuido

##  Tecnologías

### ️ **Bases de Datos**
```yaml
MySQL:      "Contenedor Docker + scripts"
PostgreSQL: "Contenedor Docker + configuración"
SQLite:     "Archivo embebido + herramientas"
```

###  **Backend & Data Science**
```yaml
Python:     "SQLAlchemy, Pandas, Flask, Django"
R:          "tidyverse, data.table, RMySQL, RPostgreSQL"
Java:       "JDBC, Hibernate, Spring Data JPA"
```

###  **Full Stack**
```yaml
JavaScript: "Node.js, Express, Sequelize, MySQL2"
Frontend:   "HTML/CSS/JS con conexiones a BD"
APIs:       "RESTful APIs con persistencia en BD"
```

###  **Herramientas**
```yaml
Docker:     "Entorno de desarrollo completo"
Git:        "Control de versiones profesional"
Testing:    "pytest, JUnit, Jest"
CI/CD:      "GitHub Actions"
```

##  Configuración Rápida

###  **Requisitos Previos**
```bash
# Software necesario
- Git
- Docker & Docker Compose
- Python 3.8+ (opcional)
- Node.js 16+ (opcional)
- Java 8+ (opcional)
```

###  **Inicio en 5 Minutos**
```bash
# 1. Clonar repositorio
git clone https://github.com/emanuelquintana-glitch/learning-sql-notes.git
cd learning-sql-notes

# 2. Iniciar bases de datos (Docker)
docker-compose up -d

# 3. Configurar entorno
cp .env.example .env

# 4. Instalar dependencias Python (opcional)
pip install -r requirements.txt

# 5. ¡Explorar!
# - Documentación: docs/index.qmd
# - Ejercicios: exercises/sql/basic/
# - Notebooks: notebooks/sql/basics.ipynb
```

###  **Acceso a Herramientas**
| Herramienta | URL | Credenciales |
|------------|-----|-------------|
| **Adminer** | http://localhost:8080 | MySQL: student/student123 |
| **MySQL** | localhost:3306 | student/student123 |
| **PostgreSQL** | localhost:5432 | student/postgres123 |

##  Ejecución de Tests

```bash
# Tests unitarios Python
pytest tests/unit/python/ -v

# Tests específicos de SQL
pytest tests/unit/sql/ -v

# Tests de integración
pytest tests/integration/ -v

# Performance testing
python -m pytest tests/performance/ -v
```

##  Recursos Educativos

###  **Referencias Principales**
Este proyecto se inspira en (pero **NO incluye contenido completo de**):
-  **"Learning SQL"** - Alan Beaulieu (O'Reilly, 3ª Edición)
-  **"The C Programming Language"** - Kernighan & Ritchie
-  **"Java: The Complete Reference"** - Herbert Schildt
-  **"Eloquent JavaScript"** - Marijn Haverbeke

###  **Enlaces Recomendados**
- [Documentación Oficial MySQL](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)

##  Autor

<p align="center">
  <img src="https://img.shields.io/badge/-Economista%20en%20Formación-UPTC-red" alt="Estudiante">
  <img src="https://img.shields.io/badge/-Econometría%20Computacional-blue" alt="Intereses">
  <img src="https://img.shields.io/badge/-Python%20%7C%20R%20%7C%20SQL-green" alt="Tecnologías">
</p>

### **Emanuel Quintana Silva**
-  **Estudiante de Economía** - Universidad Pedagógica y Tecnológica de Colombia (UPTC)
-  **Email**: emanuel.quintana@uptc.edu.co
-  **GitHub**: [@emanuelquintana-glitch](https://github.com/emanuelquintana-glitch)
-  **ORCID**: [0009-0006-8419-2805](https://orcid.org/0009-0006-8419-2805)
-  **Portafolio**: [En construcción...]

###  **Intereses Académicos**
- Econometría Computacional
- Análisis de Datos con R y Python
- Bases de Datos y SQL para Ciencias Sociales
- Visualización de Datos Económicos

##  Licencia y Uso Ético

###  **Licencia Educativa**
Este proyecto utiliza una **Licencia Educativa - Atribución** que:
- Permite uso educativo y no comercial
- Requiere atribución apropiada
- Respeta derechos de autor de materiales referenciados
- Solo incluye trabajo original del autor

###  **Uso Justo (Fair Use)**
Este proyecto se acoge al **"Fair Use"** para fines educativos:
- Propósito transformativo (reorganización para aprendizaje)
- Cantidad limitada de referencias
- Sin impacto comercial negativo
- Atribución completa a autores originales

**Ver archivo completo:** [LICENSE.md](LICENSE.md)

---

<div align="center">

### **"El conocimiento que no se comparte, pierde su valor"**

[![GitHub stars](https://img.shields.io/github/stars/emanuelquintana-glitch/learning-sql-notes?style=social)](https://github.com/emanuelquintana-glitch/learning-sql-notes/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/emanuelquintana-glitch/learning-sql-notes?style=social)](https://github.com/emanuelquintana-glitch/learning-sql-notes/network/members)
[![GitHub issues](https://img.shields.io/github/issues/emanuelquintana-glitch/learning-sql-notes)](https://github.com/emanuelquintana-glitch/learning-sql-notes/issues)

**¿Te gusta este proyecto? ¡Dale una estrella en GitHub!**

</div>

---

<p align="center">
  <sub>Construido con Rstudio, Eclipse ID, Vscode, Vim y Neovim por un estudiante apasionado por el aprendizaje</sub><br>
  <sub>UPTC • 2024 • "Transformando conocimiento en código"</sub>
</p>