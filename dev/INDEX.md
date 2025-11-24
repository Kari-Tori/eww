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
created: 2025-11-23T10:28:07Z
modified: 2025-11-23T10:28:07Z
author: jakubc
title: "📁 INDEX — Główny indeks repozytorium E-Waste Workshop"
owner: jakubc
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
| `business/` | Procesy biznesowe, finanse, sprzedaż | ❌ Brak |
| `core/` | SOP, polityki, szablony zarządcze | ❌ Brak |

### 🛠️ Obszary techniczne

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `dev/` | Warsztat deweloperski, PoC | ❌ Brak |
| `scripts/` | Automaty i narzędzia wsadowe | [scripts.md](scripts/scripts.md) |
| `tools/` | Narzędzia analityczne | ❌ Brak |

### 📚 Dokumentacja i konfiguracja

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `docs/` | Centralna dokumentacja techniczna | ❌ Brak |
| `config/` | Fragmenty konfiguracji bash/git | ❌ Brak |

### 🏗️ Infrastruktura

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `infra/` | Ansible, inventory, IaC | ❌ Brak |

### 👥 Obszary użytkowników

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `usr/` | Vault'y użytkowników (gitignore) | ❌ Brak |
| `var/` | Dane runtime, heartbeat | ❌ Brak |

### 📦 Pomocnicze

| Katalog | Opis | Folder Note |
|---------|------|-------------|
| `archive/` | Archiwa i backupy (gitignore) | ❌ Brak |
| `Tags/` | Taksonomia Obsidian | ❌ Brak |

## 📄 Pliki kluczowe w katalogu głównym

### Dokumentacja podstawowa
- `README.md` — główne wprowadzenie do projektu
- `CHANGELOG.md` — historia wersji (Keep a Changelog)
- `config/VERSION` — aktualny numer wersji (0.0.0.0)

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
Wersja: 0.0.0.0
Katalogi główne: 10
Pliki .md: 42
Pliki .sh: 114
Ostatnia aktualizacja: 2025-11-23
```

---

> [!TIP] Wskazówka
> Każdy folder note jest oznaczony tagiem `#folder_note` i świeci na niebiesko w grafie Obsidian. Używaj lokalnego grafu dla lepszej nawigacji w obrębie konkretnego obszaru.

> [!NOTE] Konwencja
> Wszystkie odwołania do ikon wykorzystują standard opisany w [docs/infra/assets/icons.md](docs/infra/assets/icons.md).
