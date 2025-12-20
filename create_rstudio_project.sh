#!/bin/bash

echo "========================================="
echo "  CREATING RSTUDIO PROJECT SAFELY"
echo "========================================="
echo ""

# Check if already exists
if [ -f "*.Rproj" ] || [ -f ".Rproj" ] || [ -f "learning-sql-notes.Rproj" ]; then
    echo "ERROR: RStudio project already exists!"
    echo "Please remove existing .Rproj files first."
    exit 1
fi

echo "1. Creating essential directories..."
mkdir -p R data-raw data-processed output reports

echo "2. Creating RStudio project file..."

cat > learning-sql-notes.Rproj << 'RPROJ'
Version: 1.0

RestoreWorkspace: No
SaveWorkspace: No
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: knitr
LaTeX: pdfLaTeX

AutoAppendNewline: Yes
StripTrailingWhitespace: Yes

BuildType: Quarto
QuartoProject: docs/_quarto.yml
RPROJ

echo "   ✓ Created: learning-sql-notes.Rproj"

echo ""
echo "3. Creating .Rprofile..."

cat > .Rprofile << 'RPROFILE'
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
RPROFILE

echo "   ✓ Created: .Rprofile"

echo ""
echo "4. Creating R/main.R..."

mkdir -p R

cat > R/main.R << 'MAINR'
# main.R - SQL Learning Notes Main Script

cat("SQL Learning Notes - R Environment\n")
cat("==================================\n\n")

# Check project structure
check_structure <- function() {
  cat("Project Structure Check:\n")
  
  dirs <- c(
    "docs/chapters",
    "databases/sqlite", 
    "src/sql",
    "exercises/sql"
  )
  
  for (dir in dirs) {
    if (dir.exists(dir)) {
      cat("  ✓ ", dir, "\n")
    } else {
      cat("  ✗ ", dir, " (missing)\n")
    }
  }
  cat("\n")
}

# List available chapters
list_chapters <- function() {
  chapters_dir <- "docs/chapters"
  if (dir.exists(chapters_dir)) {
    chapters <- list.dirs(chapters_dir, full.names = FALSE, recursive = FALSE)
    chapters <- sort(chapters[grepl("^[0-9]+$", chapters)])
    
    cat("Available Chapters:\n")
    for (chap in chapters) {
      qmd_file <- file.path(chapters_dir, chap, paste0(chap, ".qmd"))
      if (file.exists(qmd_file)) {
        # Read first line for title
        first_line <- readLines(qmd_file, n = 1)
        title <- gsub("^# ", "", first_line)
        cat("  ", chap, ": ", title, "\n", sep = "")
      } else {
        cat("  ", chap, ": (file missing)\n", sep = "")
      }
    }
  } else {
    cat("No chapters directory found.\n")
  }
  cat("\n")
}

# Main execution
if (interactive()) {
  check_structure()
  list_chapters()
  
  cat("Available Functions:\n")
  cat("  • connect_sqlite()   - Connect to SQLite database\n")
  cat("  • render_chapter(n)  - Render specific chapter\n")
  cat("  • check_structure()  - Check project structure\n")
  cat("  • list_chapters()    - List available chapters\n")
  cat("\n")
  
  cat("To get started:\n")
  cat("  source('.Rprofile')          # Load project config\n")
  cat("  con <- connect_sqlite()      # Connect to database\n")
  cat("  render_chapter(1)            # Render first chapter\n")
  cat("\n")
}
MAINR

echo "   ✓ Created: R/main.R"

echo ""
echo "5. Updating .gitignore..."

if [ -f ".gitignore" ]; then
  cat >> .gitignore << 'GITIGNORE'

# R/RStudio
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj

# Session files
*.Rds
*.rds

# Output directories
_book/
_site/
output/
GITIGNORE
else
  cat > .gitignore << 'GITIGNORE'
# R/RStudio
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj

# Session files
*.Rds
*.rds

# Output directories
_book/
_site/
output/
GITIGNORE
fi

echo "   ✓ Updated: .gitignore"

echo ""
echo "6. Creating setup script..."

cat > setup_r_project.R << 'SETUPR'
# setup_r_project.R
# Run this script to set up the R environment

cat("Setting up SQL Learning Notes R environment...\n\n")

# Install required packages
required_packages <- c(
  # Core
  "devtools", "usethis", "here", "fs",
  
  # Documentation
  "quarto", "rmarkdown", "knitr",
  
  # Database
  "DBI", "RSQLite", "dbplyr",
  
  # Data manipulation
  "tidyverse", "dplyr", "ggplot2"
)

cat("Checking packages...\n")
installed <- rownames(installed.packages())
to_install <- setdiff(required_packages, installed)

if (length(to_install) > 0) {
  cat("Installing", length(to_install), "packages:\n")
  cat(paste(to_install, collapse = ", "), "\n\n")
  
  install.packages(to_install)
  cat("\nPackages installed successfully!\n")
} else {
  cat("All packages are already installed.\n")
}

# Create sample database if needed
cat("\nChecking database setup...\n")
db_dir <- "databases/sqlite"
if (!dir.exists(db_dir)) {
  dir.create(db_dir, recursive = TRUE)
  cat("Created database directory:", db_dir, "\n")
}

db_file <- file.path(db_dir, "learning.sqlite")
if (!file.exists(db_file)) {
  cat("Creating sample database...\n")
  
  con <- DBI::dbConnect(RSQLite::SQLite(), db_file)
  
  # Create sample table
  DBI::dbExecute(con, "
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      age INTEGER,
      grade TEXT
    )
  ")
  
  # Insert sample data
  DBI::dbExecute(con, "
    INSERT INTO students (name, age, grade) VALUES
    ('Alice', 20, 'A'),
    ('Bob', 21, 'B'),
    ('Charlie', 22, 'A'),
    ('Diana', 20, 'C')
  ")
  
  DBI::dbDisconnect(con)
  cat("Sample database created at:", db_file, "\n")
} else {
  cat("Database already exists:", db_file, "\n")
}

cat("\n✅ Setup complete!\n")
cat("\nNext steps:\n")
cat("1. Open 'learning-sql-notes.Rproj' in RStudio\n")
cat("2. Run: source('.Rprofile')\n")
cat("3. Try: con <- connect_sqlite()\n")
cat("4. Try: render_chapter(1)\n")
SETUPR

echo "   ✓ Created: setup_r_project.R"

echo ""
echo "========================================="
echo "✅ PROJECT CREATION COMPLETE!"
echo "========================================="
echo ""
echo "📁 Files created:"
echo "   • learning-sql-notes.Rproj"
echo "   • .Rprofile"
echo "   • R/main.R"
echo "   • setup_r_project.R"
echo ""
echo "🎯 Next Steps:"
echo "   1. Open RStudio"
echo "   2. File > Open Project > learning-sql-notes.Rproj"
echo "   3. Run in R console: source('setup_r_project.R')"
echo "   4. Then run: source('.Rprofile')"
echo ""
echo "💡 Quick test after setup:"
echo "   con <- connect_sqlite()"
echo "   DBI::dbListTables(con)"
echo "   render_chapter(1)"
echo ""
