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
