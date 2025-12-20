#!/bin/bash

# Nombre del proyecto
PROJECT="learning-sql-notes"

# Crear carpeta principal
mkdir -p $PROJECT
cd $PROJECT || exit

# Archivos raíz
touch README.md credits.md CHANGELOG.md LICENSE.md

# =========================
# Docs (Quarto)
# =========================
mkdir -p docs/chapters

cat > docs/_quarto.yml <<EOL
project:
  type: book
  output-dir: _book

book:
  title: "Learning SQL"
  author: "Alan Beaulieu"
  chapters:
    - index.qmd
    - chapters/01-introduction/01-introduction.qmd
    - chapters/02-create-populate-db/02-create-populate-db.qmd
    - chapters/03-query-primer/03-query-primer.qmd
    - chapters/04-filtering/04-filtering.qmd
    - chapters/05-multi-table-queries/05-multi-table-queries.qmd
    - chapters/06-set-operations/06-set-operations.qmd
    - chapters/07-data-manipulation/07-data-manipulation.qmd
    - chapters/08-grouping-aggregates/08-grouping-aggregates.qmd
    - chapters/09-subqueries/09-subqueries.qmd
    - chapters/10-joins-revisited/10-joins-revisited.qmd
    - chapters/11-conditional-logic/11-conditional-logic.qmd
    - chapters/12-transactions/12-transactions.qmd
    - glossary.qmd

format:
  html:
    toc: true
    toc-depth: 3
    code-fold: true
    theme: cosmo
  pdf:
    documentclass: book
    toc: true
    number-sections: true
EOL

# Crear index.qmd
cat > docs/index.qmd <<EOL
---
title: "Learning SQL"
author: "Alan Beaulieu"
date: "`date +%Y-%m-%d`"
format:
  html: default
  pdf: default
---

# Bienvenido a Learning SQL

Este libro es un compendio de notas basadas en:

**Alan Beaulieu, Learning SQL (3ra edición)**

> Generar, manipular y recuperar datos con SQL.

Aquí encontrarás capítulos, ejercicios y ejemplos en SQL, R y Python, además de diagramas y bases de datos de práctica.
EOL

# Crear capítulos vacíos
for i in {01..12} glossary; do
    mkdir -p docs/chapters/$i
    touch docs/chapters/$i/$i.qmd
done

# =========================
# LaTeX
# =========================
mkdir -p latex/chapters

cat > latex/preamble.tex <<EOL
\documentclass[12pt,oneside]{book}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[spanish]{babel}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{xcolor}
\usepackage{listings}
\usepackage{geometry}
\geometry{margin=1in}

% Configuración de listings para SQL y código
\lstdefinelanguage{SQL}{
    keywords={SELECT, FROM, WHERE, INSERT, UPDATE, DELETE, JOIN, INNER, LEFT, RIGHT, ON, GROUP, BY, ORDER, ASC, DESC, CREATE, TABLE, PRIMARY, KEY, VALUES},
    keywordstyle=\color{blue}\bfseries,
    morecomment=[l]{--},
    morestring=[b]',
    commentstyle=\color{gray}\itshape,
    stringstyle=\color{red},
    showstringspaces=false,
    basicstyle=\ttfamily\small,
    numbers=left,
    numberstyle=\tiny,
    stepnumber=1,
    numbersep=5pt
}
\lstset{language=SQL}
EOL

cat > latex/main.tex <<EOL
\input{preamble.tex}

\begin{document}

\frontmatter
\title{Learning SQL}
\author{Alan Beaulieu}
\date{\today}
\maketitle
\tableofcontents

\mainmatter

EOL

# Crear capítulos LaTeX vacíos
for i in {01..12} glossary; do
    mkdir -p latex/chapters/$i
    touch latex/chapters/$i/$i.tex
    echo "\\input{chapters/$i/$i.tex}" >> latex/main.tex
done

echo "\end{document}" >> latex/main.tex

# =========================
# Exercises
# =========================
mkdir -p exercises/sql/{basic,intermediate,advanced} exercises/r exercises/python

# =========================
# Databases
# =========================
mkdir -p databases/examples

# =========================
# Diagrams
# =========================
mkdir -p diagrams/erd diagrams/flowcharts

# =========================
# Docker
# =========================
mkdir -p docker
touch docker/Dockerfile docker/docker-compose.yml

# =========================
# Virtual Environment
# =========================
python3 -m venv .venv
echo "Estructura creada correctamente en $(pwd)"
