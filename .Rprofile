# SQL Learning Notes Project Configuration

# Set project root
.project_root <- getwd()

# CRAN mirror
options(
  repos = c(CRAN = "https://cloud.r-project.org"),
  scipen = 999,
  digits = 4,
  width = 80
)

# Welcome message
if (interactive()) {
  cat("\n")
  cat("╔══════════════════════════════════════════╗\n")
  cat("║     SQL Learning Notes Project           ║\n")
  cat("║           RStudio Ready!                ║\n")
  cat("╚══════════════════════════════════════════╝\n")
  cat("\n")
  cat("Project root:", .project_root, "\n")
  cat("R version:", R.version.string, "\n")
  cat("\n")
  
  # Check for essential packages
  needed_pkgs <- c("DBI", "RSQLite", "quarto", "rmarkdown")
  installed <- rownames(installed.packages())
  missing <- setdiff(needed_pkgs, installed)
  
  if (length(missing) > 0) {
    cat("Missing packages:", paste(missing, collapse = ", "), "\n")
    cat("Install with: install.packages(c('", paste(missing, collapse = "', '"), "'))\n", sep = "")
  } else {
    cat("All essential packages are installed.\n")
  }
  
  cat("\n")
  cat("Quick start:\n")
  cat("  1. con <- dbConnect(RSQLite::SQLite(), 'databases/sqlite/learning.sqlite')\n")
  cat("  2. dbListTables(con)\n")
  cat("  3. quarto::quarto_render('docs/index.qmd')\n")
  cat("\n")
}

# Simple helper functions
connect_sqlite <- function(db_name = "learning.sqlite") {
  if (!requireNamespace("DBI", quietly = TRUE)) {
    install.packages("DBI")
    library(DBI)
  }
  if (!requireNamespace("RSQLite", quietly = TRUE)) {
    install.packages("RSQLite")
    library(RSQLite)
  }
  
  db_path <- file.path(.project_root, "databases", "sqlite", db_name)
  
  # Create directory if needed
  if (!dir.exists(dirname(db_path))) {
    dir.create(dirname(db_path), recursive = TRUE)
  }
  
  con <- dbConnect(SQLite(), db_path)
  message("Connected to: ", db_path)
  return(con)
}

render_chapter <- function(chapter_num) {
  if (!requireNamespace("quarto", quietly = TRUE)) {
    install.packages("quarto")
    library(quarto)
  }
  
  chapter_file <- file.path(.project_root, "docs", "chapters", 
                           sprintf("%02d", chapter_num), 
                           sprintf("%02d.qmd", chapter_num))
  
  if (file.exists(chapter_file)) {
    quarto::quarto_render(chapter_file)
    message("Rendered chapter ", chapter_num)
  } else {
    message("Chapter file not found: ", chapter_file)
  }
}
