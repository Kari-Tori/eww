---
tags:
  - #folder_note
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T20:00:00Z
modified: 2025-11-21T20:00:00Z
author: jakubc
title: "🌐 site — źródła strony EWW"






owner: jakubc
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

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

- [assets/](assets/assets.md)
- [ENDPOINTS/](ENDPOINTS/ENDPOINTS.md)
- [guide/](guide/guide.md)
- [search/](search/search.md)
- [vendor/](vendor/vendor.md)
- [wiki/](wiki/wiki.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

