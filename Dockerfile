FROM python:3.11-slim

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

