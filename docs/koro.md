---
title: Koro
description: KoroFileHeader -> YAML frontmatter
type: file
category: docs
filepath: docs/koro.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
aliases:
related:
  - docs/docs.md
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/koro.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# KoroFileHeader -> YAML frontmatter

Skrypt scripts/koro-to-frontmatter.sh konwertuje nagłówek KoroFileHeader (HTML comment na początku pliku)
na frontmatter YAML używany w notatkach (np. Obsidian).

Jak użyć:
- Nadaj skryptowi prawa wykonywania: chmod +x scripts/koro-to-frontmatter.sh
- Uruchom: ./scripts/koro-to-frontmatter.sh ścieżka/do/pliku.md

Zachowanie:
- Skrypt nie nadpisze pliku, jeśli już zaczyna się od `---` (frontmatter YAML).
- Wyciąga pola: @Author, @Date, @LastEditTime, @LastEditors, @FilePath, @Description
  i tworzy z nich blok YAML.
- Usuwa pierwszy blok HTML-komentarza z pliku i wstawia wygenerowany frontmatter.

Przykład:
  ./scripts/koro-to-frontmatter.sh usr/karinam/journal/template/daily-template-kanban-mockup.md

Uwaga:
- Wszystkie komunikaty po polsku.
- Skrypt jest prosty — możesz dodać mapowanie formatów dat lub integrację z Makefile.
