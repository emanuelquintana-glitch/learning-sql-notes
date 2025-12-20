# Script para configurar entorno R para SQL y análisis de datos

# Paquetes básicos para R Markdown
install.packages(c(
  # Core R Markdown
  "rmarkdown",
  "knitr",
  
  # Tidyverse (análisis de datos)
  "tidyverse",
  "dplyr",
  "tidyr",
  "ggplot2",
  "readr",
  "purrr",
  "stringr",
  "lubridate",
  
  # Conexión a bases de datos
  "DBI",
  "RMySQL",
  "RPostgres",
  "RSQLite",
  "odbc",
  
  # Econometría y estadística
  "forecast",
  "tseries",
  "quantmod",
  "plm",
  "sandwich",
  "lmtest",
  
  # Reportes profesionales
  "kableExtra",
  "gt",
  "flextable",
  
  # Interactividad
  "DT",
  "plotly",
  "shiny",
  
  # Desarrollo
  "devtools",
  "testthat",
  "roxygen2"
))

# Verificar instalación
cat("✅ Paquetes R instalados correctamente\n")
cat("Para usar R Markdown, ejecuta: rmarkdown::render('archivo.Rmd')\n")
