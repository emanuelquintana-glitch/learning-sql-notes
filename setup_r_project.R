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
