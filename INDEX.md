---
tags:
  - #automation
  - #development
  - #eww
  - #folder_note
  - #index
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T20:18:52Z
modified: 2025-11-21T20:18:52Z
author: jakubc
title: "📁 INDEX — Główny indeks repozytorium E-Waste Workshop"
---

# 📁 INDEX — Główny indeks repozytorium E-Waste Workshop

> **Nawigacja centralna** — szybki dostęp do wszystkich obszarów projektu

## 🎯 Skróty nawigacyjne

- 📖 [README.md](README.md) — wprowadzenie do projektu
- 📋 [CHANGELOG.md](CHANGELOG.md) — historia zmian
- 🤖 [docs/AGENTS.md](docs/AGENTS.md) — kontekst dla AI
- 🎯 [docs/MVP.md](docs/MVP.md) — cele MVP
- 📊 [docs/FULL-INDEX.md](docs/FULL-INDEX.md) — pełny indeks plików
- 🗺️ [EWW-MAP.md](EWW-MAP.md) — mapa koncepcyjna
- 📜 [STATUS-REPO.md](STATUS-REPO.md) — status repozytorium

## 🗂️ Struktura katalogów głównych

### 💼 Obszary biznesowe i zarządcze

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `business/` | Procesy biznesowe, finanse, sprzedaż | [business.md](business/business.md) |
| `core/` | SOP, polityki, szablony zarządcze | [core.md](core/core.md) |

### 🛠️ Obszary techniczne

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `dev/` | Warsztat deweloperski, PoC | [dev.md](dev/dev.md) |
| `scripts/` | Automaty i narzędzia wsadowe | [scripts.md](scripts/scripts.md) |
| `tools/` | Narzędzia analityczne | [tools.md](tools/tools.md) |

### 📚 Dokumentacja i konfiguracja

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `docs/` | Centralna dokumentacja techniczna | [docs.md](docs/docs.md) |
| `config/` | Fragmenty konfiguracji bash/git | [config.md](config/config.md) |

### 🏗️ Infrastruktura

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `infra/` | Ansible, inventory, IaC | [infra.md](infra/infra.md) |

### 👥 Obszary użytkowników

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `usr/` | Vault'y użytkowników (gitignore) | [usr.md](usr/usr.md) |
| `var/` | Dane runtime, heartbeat | [var.md](var/var.md) |

### 📦 Pomocnicze

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `archive/` | Archiwa i backupy (gitignore) | [archive.md](archive/archive.md) |
| `Tags/` | Taksonomia Obsidian | [Tags.md](Tags/Tags.md) |

## 📄 Pliki kluczowe w katalogu głównym

### Dokumentacja podstawowa
- `README.md` — główne wprowadzenie do projektu
- `CHANGELOG.md` — historia wersji (Keep a Changelog)
- `config/VERSION` — aktualny numer wersji (0.0.0.5)

### Konfiguracja i automatyzacja
- `Makefile` — codzienne zadania (TODO, sync, migracje)
- `init-eww.sh` — podstawowy skrypt inicjalizacyjny

### Statusy i mapy
- `STATUS-REPO.md` — aktualny stan repozytorium
- `EWW-MAP.md` — mapa koncepcyjna projektu
- `TAG-STRATEGY.md` — strategia tagowania

## 🎨 System tagowania

### Tagi główne
- `#eww` — wszystkie pliki projektu
- `#folder_note` — folder notes / indeksy Waypoint
- `#index` — pliki indeksowe
- `#automation` — automatyzacja i skrypty
- `#development` — kod i narzędzia dev
- `#docs` — dokumentacja
- `#knowledge` — baza wiedzy

### Tagi obszarów
- `#business` — biznes i operacje
- `#infrastructure` — infrastruktura
- `#linux` — system Linux
- `#productivity` — produktywność
- `#secondbrain` — second brain / PKM

## 🔍 Jak nawigować?

1. **Szybki start**: Przejdź do [README.md](README.md)
2. **Konkretny obszar**: Wybierz katalog z tabeli powyżej
3. **Folder note**: Każdy katalog ma plik `katalog/katalog.md` z opisem
4. **Pełny przegląd**: Zobacz [docs/FULL-INDEX.md](docs/FULL-INDEX.md)
5. **Graf Obsidian**: Otwórz folder note i przełącz na lokalny graf

## 🛠️ Narzędzia indexowania

- `make index` — regeneruj wszystkie indeksy
- `scripts/generate-index.sh` — generuj INDEX.md automatycznie
- `scripts/check-folder-notes.sh` — sprawdź kompletność folder notes

## 📊 Statystyki

```
Wersja: 0.0.0.5
Katalogi główne: 12
Pliki .md: 665
Pliki .sh: 117
Ostatnia aktualizacja: 2025-11-21
```

---

> [!TIP] Wskazówka
> Każdy folder note jest oznaczony tagiem `#folder_note` i świeci na niebiesko w grafie Obsidian. Używaj lokalnego grafu dla lepszej nawigacji w obrębie konkretnego obszaru.

> [!NOTE] Konwencja
> Wszystkie odwołania do ikon wykorzystują standard opisany w [docs/assets/icons.md](docs/assets/icons.md).

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

