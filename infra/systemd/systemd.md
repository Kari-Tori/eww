---
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🕒 systemd — automaty usługowe"






---

# 🕒 systemd — automaty usługowe

> [!TIP] Instalacja
> Skopiuj pliki do `~/.config/systemd/user/`, wykonaj `systemctl --user daemon-reload`, a następnie `systemctl --user enable --now <nazwa>.service|.timer|.path`.

## 🧭 Zakres folderu
- Usługi monitorujące Obsidian i status repo.
- Timery i path-unit’y powiązane ze skryptami z `bin/` i `scripts/`.

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Service | `eww-autocommit.service` | Uruchamia automatyczne commity snapshotów. |
| Timer | `eww-autocommit.timer` | Harmonogram dla `eww-autocommit.service`. |
| Service | `eww-status.service` | Odpala `bin/eww-status` i raportuje kondycję repo. |
| Timer | `eww-status.timer` | Okresowo odpala `eww-status.service`. |
| Path | `eww-watch-obsidian-plugins.path` | Monitoruje zmiany w `.obsidian/plugins`. |
| Service | `eww-watch-obsidian-plugins.service` | Reaguje na path-unit i aktualizuje listę pluginów. |

## ⚙️ Kluczowe funkcje
1. **Automatyzacja zdrowia repo** – status i snapshoty działają w tle.
2. **Monitoring Obsidian** – każdy update pluginów aktualizuje dokumentację.
3. **Łatwy rollout** – pliki gotowe do kopiowania bez dodatkowej konfiguracji.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [bin/bin.md](../bin/bin.md)
- [scripts/scripts.md](../scripts/scripts.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)
- [bin/eww-setup-plugins-monitor](../bin/eww-setup-plugins-monitor)





**Backlinków:** 1  
**Linków wychodzących:** 0  
**Zaktualizowano:** 1763715821.5484378  



## 🔗 Backlinks

- [[core/TEMPLATES/TEMPLATES|TEMPLATES]]
- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]



## 📎 Źródła i powiązania

*Dokumenty powiązane:*

- [[core/TEMPLATES/TEMPLATES|TEMPLATES]]


**Backlinków:** 1  
**Linków wychodzących:** 1  
**Zaktualizowano:** 1763717741.383811  

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

*Brak podfolderów.*
