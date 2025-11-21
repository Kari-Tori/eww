---
title: "🌐 site — Strona statyczna"
description: "Źródła statycznej strony E-Waste Workshop (HTML, assets, wiki)."
color: green
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.2.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#1E88E5]website"
  - "[#43A047]docs"
  - "[#8E24AA]wiki"
  - "[#F4511E]assets"
  - documentation
  - docs
  - knowledge

related:
  - docs/archive/archive.md
  - docs/assets/icons.md
  - docs/governance/GOVERNANCE.md
  - docs/readme-checklist.md
  - docs/ROOT-MINIMIZATION.md
sources:
  - path: "../README.md"
    title: "Repo README"
  - path: "../AGENTS.md"
    title: "AGENTS"
  - path: "./ENDPOINTS/ENDPOINTS.md"
    title: "Site Endpoints"
backlinks:
  - path: "../INDEX.md"
    title: "Główny indeks"
  - path: "../FULL-INDEX.md"
    title: "Full Index"
  - path: "../eww.md"
    title: "Opis repo"
---

# 🌐 site — źródła strony EWW

> [!TIP] Deploy
> Katalog `site/` można budować jako statyczną stronę (np. GitHub Pages). Pliki HTML określają strukturę, a `assets/` i `wiki/` dostarczają treści.

## 🧭 Zakres folderu
- Pliki HTML (np. `index.html`, `404.html`, `sitemap.xml`).
- Dokumentacja osadzona w formie wiki.
- Assety (obrazy, JS, CSS).

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik | `404.html` | Strona błędu HTTP 404. |
| Folder | `assets/` | Grafiki, style, skrypty JS i webworkers. |
| Folder | `ENDPOINTS/` | Opis REST/HTTP endpointów (patrz `ENDPOINTS.md`). |
| Folder | `guide/` | Treści przewodnika wersji web. |
| Plik | `index.html` | Główny landing page. |
| Folder | `search/` | Konfiguracja wyszukiwarki (np. Lunr). |
| Pliki | `sitemap.xml`, `sitemap.xml.gz` | Mapy strony dla SEO. |
| Folder | `vendor/` | Biblioteki vendorowe (JS/CSS). |
| Folder | `wiki/` | Wersja wiki dostępna w przeglądarce (np. Kubuntu, Neovim, Obsidian). |

## ⚙️ Kluczowe funkcje
1. **Publikacja dokumentacji** – `wiki/` i `guide/` są renderowane jako strona.
2. **Obsługa assets** – `assets/` ujednolica zasoby między README a stroną.
3. **API reference** – `ENDPOINTS/` utrzymuje listę usług i ścieżek HTTP.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [docs/docs.md](../docs/docs.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)
- [site/ENDPOINTS/ENDPOINTS.md](ENDPOINTS/ENDPOINTS.md)

