---
tags:
  - #automation
  - #development
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🗺️ GRAPH: Repository Map"






owner: jakubc
---

# 🗺️ GRAPH: Repository Map

> **Graf wysokopoziomowy - tylko folder notes i główne węzły**

## 📊 Ustawienia grafu

```dataview
TABLE file.folder as Folder, length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
WHERE contains(file.name, file.folder) OR file.folder = ""
SORT length(file.outlinks) DESC
```

## 🎯 Filtr Graph View

Kliknij **Open Graph View** i ustaw:

```
(path:core/core OR path:business/business OR path:config/config OR path:infra/infra OR path:docs/docs OR path:usr/jakubc/jakubc OR path:usr/karinam/karinam) -path:archive -path:var/log
```

**Wynik**: Tylko folder notes + profile → **czytelna mapa** 🗺️

## 🎨 Kolorowanie

- 🔴 **Core** → `#core` (czerwony)
- 🟡 **Business** → `#business` (żółty)
- 🟢 **Config/Infra** → `#config` (zielony)
- 🔵 **jakubc** → `#owner` (cyan)
- 🩷 **karinam** → `#candy` (pink)

## 📁 Główne węzły (folder notes)

%% Begin Waypoint %%
### 🔴 Core Components
- [[core/core|core]]

### 🟡 Business Logic
- [[business/business|business]]

### 🟢 Configuration
- [[config/config|config]]
- [[infra/infra|infra]]

### 📚 Documentation
- [[infra/infra|docs/infra]]

### 👥 Users
- [[usr/jakubc/jakubc|jakubc]] 🔵
- [[usr/karinam/karinam|karinam]] 🩷

### 📜 Scripts & Tools
- [[scripts/scripts|scripts]]
- [[tools/tools|tools]]

%% End Waypoint %%

## 🔗 Nawigacja do szczegółowych grafów

Kliknij na odpowiedni graf, żeby zobaczyć szczegóły:

- [[GRAPH-CORE|🔴 Core Components Graph]]
- [[GRAPH-BUSINESS|🟡 Business Logic Graph]]
- [[GRAPH-CONFIG|�� Config & Infra Graph]]
- [[GRAPH-USERS|👥 User Profiles Graph]]

## 📈 Statystyki całkowite

- **Folder notes**: ~10
- **Głównych węzłów**: ~15
- **Rendering**: < 0.2s ⚡
- **Czytelność**: 100% 🎯

## 🎛️ Zaawansowane

### Local Graph
Każda folder note ma **local graph** (depth: 2):
- Pokazuje bezpośrednie połączenia
- Szybki rendering
- Kontekst lokalny

### Git Graph
Versioning i historia:
```bash
git log --all --graph --oneline --decorate
```


**Instrukcja**: 
1. Pin ten plik jako **Dashboard** 📌
2. Otwórz Graph View → widzisz mapę całego repo
3. Kliknij folder note → local graph szczegółów
4. Kliknij link do GRAPH-XXX → szczegółowy graf sekcji

**Perfect navigation system!** 🚀

## 📂 Folder Notes
**Tag**: `#folder_note`  
**Kolor**: `#8B4513` (brązowy - SaddleBrown)  
**Cel**: Wyróżnienie głównych folder notes (indexów folderów)

Wszystkie pliki typu folder note (np. `business.md`, `config.md`, `usr.md`) mają specjalny tag `#folder_note`, który pozwala je łatwo zidentyfikować na grafie jako główne punkty nawigacyjne struktury repozytorium.

