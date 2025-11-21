---
tags:
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #linux
  - #obsidian
  - #secondbrain
  - #star-wars
created: 2025-11-21T19:00:00Z
modified: 2025-11-21T19:00:00Z
author: jakubc
title: "## Polecane wtyczki (często dyskutowane na forach)"






---



## Polecane wtyczki (często dyskutowane na forach)

> [!TIP] Instalacja jednym poleceniem
> `scripts/install-ai-toolkit.sh obsidian ~/Obsidian/code` automatycznie pobiera najnowsze wydania wymienionych wtyczek i umieszcza je w katalogu `.obsidian/plugins`.

- Kanban (mgmeyers) — tablice Kanban w notatkach  
  Repo: https://github.com/mgmeyers/obsidian-kanban

- Dataview — zapytania i raporty z notatek  
  Repo: https://github.com/blacksmithgu/obsidian-dataview

- Tasks — zaawansowane filtrowanie zadań  
  Repo: https://github.com/schemar/obsidian-tasks

- Templater — skrypty i dynamiczne szablony  
  Repo: https://github.com/SilentVoid13/Templater

- QuickAdd — szybkie akcje / makra  
  Repo: https://github.com/chhoumann/quickadd

- Advanced URI — integracje i linki akcyjne  
  Repo: https://github.com/Vinzent03/obsidian-advanced-uri

- Obsidian Git — backup i automatyczne commity  
  Repo: https://github.com/denolehov/obsidian-git

- Obsidian Linter — utrzymanie stylu Markdown  
  Repo: https://github.com/platers/obsidian-linter


## Szybkie przykłady konfiguracji i snippetów

### 1) Dataview — przykładowe zapytanie (lista zadań #eBay)
```dataview
TABLE priority as "Priorytet", due as "Termin", assignee as "Przypisany"
FROM ""
WHERE contains(tags, "#eBay") AND type = "task"
SORT due asc
```

### 2) Templater — prosty szablon dzienny
```tpl
<%* 
// templater: szybkie wstawienie daty i linku dziennego
%>
date: <% tp.date.now("YYYY-MM-DD") %>
title: Dzień — <% tp.date.now("YYYY-MM-DD") %>
# Dziś — <% tp.date.now("dddd, D MMMM YYYY") %>
```

### 3) Tasks — filtr zadań w notatce
```tasks
not done
path includes "journal"
tag includes #eBay
due before 2025-11-30
sort by priority
```

### 4) QuickAdd + Templater — dodaj kartę do Kanban (template action)
```json
{
  "name": "Dodaj kartę Dziś",
  "type": "template",
  "template": "- [ ] Nowe zadanie — krótki opis\n\t- 📅: <% tp.date.now(\"YYYY-MM-DD\") %>\n\t- ⚑: P3\n\t- 👤: @twoje_imie"
}
```

### 5) Obsidian Git — wskazówki
- Ustawienia rekomendowane: auto-commit on save = true (rozważ częstotliwość), commit message template = "Auto: vault update {{date}}".
- Uwaga: przetestuj konfigurację przed włączeniem automatycznych pushy.


## Co polecają użytkownicy (fora, Discord, Reddit) — skrót
- Dataview + Tasks do raportów i filtrowania zadań z Kanban.  
- QuickAdd + Templater do szybkiego tworzenia kart i automatyzacji.  
- Advanced URI do integracji z zewnętrznymi skryptami i hotkeyami.  
- Obsidian Git jako obowiązkowy backup/history dla aktywnych vaultów.  
- Linter dla spójności formatu Markdown przy automatycznych commitach.

Szybkie przykłady integracji polecane na forach
- QuickAdd action -> template (szybkie dodanie karty do "Dziś 📅").  
- Dataview report pokazujący zadania z wszystkich tablic Kanban z terminem i priorytetem.  
- Pre-commit lub Obsidian Git auto-commit + Obsidian Linter przed commitem.

Źródła: repozytoria wtyczek (linki powyżej), dyskusje na r/ObsidianMD, oficjalne Discordy wtyczek, GitHub Discussions.

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

*Brak podfolderów.*

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

