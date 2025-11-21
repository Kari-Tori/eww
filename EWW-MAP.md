---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
  - #folder_note
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🚀 EWW Repository Map"






---

# 🚀 EWW Repository Map

> **Główny dashboard nawigacyjny projektu E-Waste Workshop**

## 🗺️ Nawigacja graficzna

### 📊 Grafy wizualizacji
Wybierz graf odpowiedni do Twojego zadania:

- [[GRAPH-MAP|🗺️ Repository Overview]] - *Mapa całego repo (15 węzłów)*
- [[GRAPH-CORE|🔴 Core Components]] - *Komponenty rdzeniowe (50-80 notatek)*
- [[GRAPH-BUSINESS|🟡 Business Logic]] - *Warstwa biznesowa (40-60 notatek)*
- [[GRAPH-CONFIG|🟢 Config & Infrastructure]] - *Konfiguracja systemu (30-50 notatek)*
- [[GRAPH-USERS|👥 User Profiles]] - *Profile użytkowników (100-150 notatek)*

## 📁 Główne sekcje

### 🔴 Core Components
**[[core/core|core/]]** - Podstawowe komponenty systemu
- Konfiguracja projektu
- Setup środowiska
- Zasoby core

### 🟡 Business Logic
**[[business/business|business/]]** - Logika biznesowa
- Procesy biznesowe
- Workflows
- Business rules

### 🟢 Configuration
**[[config/config|config/]]** | **[[infra/infra|infra/]]** - Konfiguracja i infrastruktura
- Setup środowiska
- Deployment
- Infrastructure as Code

### 📚 Documentation
**[[docs/docs|docs/]]** - Dokumentacja projektu
- Guides
- How-tos
- API docs

### 📜 Scripts & Tools
**[[scripts/scripts|scripts/]]** | **[[tools/tools|tools/]]**
- Bash scripts
- Dev tools
- Automation

## 👥 Użytkownicy

- [[usr/jakubc/jakubc|🔵 jakubc]] - Owner & Developer (#owner #eww)
- [[usr/karinam/karinam|🩷 karinam]] - Candy Developer (#candy #pink)

## 📋 Dokumentacja główna

- [[README]] - Opis projektu
- [[CHANGELOG]] - Historia zmian
- [[INDEX]] - Index plików
- [[FULL-INDEX]] - Pełny index ze szczegółami

## 🎯 Quick Links

### Development
- [[init-eww.sh]] - Inicjalizacja środowiska
- [[install-waypoint.sh]] - Plugin Waypoint
- [[setup-git-remote.sh]] - Git remote setup

### Documentation Files
- [[docs.md]] - Dokumentacja główna
- [[scripts.md]] - Opis skryptów
- [[infra.md]] - Infrastruktura
- [[usr.md]] - Użytkownicy
- [[var.md]] - Zmienne i logi

## 🔧 Narzędzia

### Git Workflow
```bash
# Status repo
git status

# Graph Git
git log --all --graph --oneline --decorate

# Quick commit
git add . && git commit -m "feat: opis"
```

### Obsidian Plugins
- **Waypoint** - Auto-generowanie indexów folderów
- **Dataview** - Dynamiczne zapytania
- **Graph View** - Wizualizacja połączeń

## 📈 Statystyki repo

```dataview
TABLE length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
WHERE file.name = this.file.name
```

**Całkowite**:
- 📝 Plików MD: ~489
- 📁 Folderów: 21
- 👥 Użytkowników: 2
- 🎨 Grafów: 5

## 🎨 Color Coding

- 🔴 Red = Core (`#core`)
- 🟡 Yellow = Business (`#business`)
- 🟢 Green = Config/Infra (`#config`)
- 🔵 Cyan = jakubc (`#owner` `#eww`)
- 🩷 Pink = karinam (`#candy` `#pink`)

## 🎨 Foldery przypisane do kolorów

| Tag/Grupa | Kolor HEX | Folder note (index) | Zakres |
|-----------|-----------|---------------------|--------|
| `#folder_note` | `#4FC3F7` (jasny błękit) | [[EWW-MAP\|EWW-MAP]] + wszystkie folder notes | Węzły Waypoint – informacyjne indeksy folderów |
| `#eww` `#recycling` `#eko` | `#3B5C36` (zgniła zieleń) | [[core/core\|core/]], [[config/config\|config/]], [[business/business\|business/]], [[docs/docs\|docs/]] | Recykling, eko-technologia i bazowe moduły repo |
| `#jakubc` | `#C62828` (czerwień) | [[usr/jakubc/jakubc\|usr/jakubc/]] | Profil właściciela + workspace, LEGO, Star Wars |
| `#karinam` | `#FF7FA7` (candy pink) | [[usr/karinam/karinam\|usr/karinam/]] | Notatki/vault Kariny |
| `#star-wars` | `#D9A441` (złoty) | [[usr/jakubc/star_wars/star_wars\|usr/jakubc/star_wars/]] | Enc w uniwersum SW (ships, races, weapons) |
| `#lego` | `#F4C20D` (żółty) | [[usr/jakubc/lego/lego\|usr/jakubc/lego/]] | MOC, roadmapy LEGO, shipping |
| `#avocado` | `#56701F` (awokado) | [[docs/archive/avocado/avocado\|docs/archive/avocado/]] | SOP i projekty Avocado |
| `#secondbrain` | `#8F5AF0` (fiolet Obsidiana) | [[dev/Projects/Secondbrain/Secondbrain\|dev/Projects/Secondbrain/]] | Projekty PKM / Second Brain |
| `#GERC` | `#0D47A1` (kolor Asusa) | [[docs/infra/hardware/gerc/gerc\|docs/infra/hardware/gerc/]] | Serwery GERC i moduły sprzętowe |
| `#Asus_Z77` | `#C055D1` (różowo-fioletowy) | [[docs/infra/hardware/asus_z77/asus_z77\|docs/infra/hardware/asus_z77/]] | Build Asus Z77 i historia serwisu |

> [!TIP] Każdy z wymienionych folderów ma index z Waypointa – otwórz go przed lokalnym grafem, aby zobaczyć te same kolory i podlinkowane pliki podrzędne.
> Folder notes mają tag `folder_note`, więc w grafie błyskają jasnym błękitem niezależnie od pozostałych kolorów.

## 🚀 Getting Started

1. **Setup**: Uruchom `./init-eww.sh`
2. **Navigation**: Otwórz [[GRAPH-MAP]] jako dashboard
3. **Development**: Zobacz [[core/core|core components]]
4. **Documentation**: Przeglądaj [[docs/docs|docs/]]

**Pro tip**: Pin [[GRAPH-MAP]] i ten plik dla szybkiej nawigacji! 📌


*Last updated: 2025-11-21 | Author: [[jakubc]]*

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

