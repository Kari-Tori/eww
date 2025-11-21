---
tags:
  - eww
  - map
  - readme
  - navigation
  - dashboard
created: 2025-11-21
author: jakubc
cssclasses:
  - dashboard
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

---

## 🚀 Getting Started

1. **Setup**: Uruchom `./init-eww.sh`
2. **Navigation**: Otwórz [[GRAPH-MAP]] jako dashboard
3. **Development**: Zobacz [[core/core|core components]]
4. **Documentation**: Przeglądaj [[docs/docs|docs/]]

**Pro tip**: Pin [[GRAPH-MAP]] i ten plik dla szybkiej nawigacji! 📌

---

*Last updated: 2025-11-21 | Author: [[jakubc]]*
