---
title: "🕒 systemd — Jednostki usług użytkownika"
description: "Pliki `.service`, `.timer` i `.path` obsługujące automaty E-Waste Workshop na poziomie user-space."
color: purple
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.2.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#1E88E5]systemd"
  - "[#43A047]automation"
  - "[#F4511E]monitoring"
  - infra
  - infrastructure
  - devops
sources:
  - path: "../README.md"
    title: "Repo README"
  - path: "../AGENTS.md"
    title: "AGENTS"
  - path: "../bin/bin.md"
    title: "bin note"
backlinks:
  - path: "../INDEX.md"
    title: "Główny indeks"
  - path: "../FULL-INDEX.md"
    title: "Full Index"
  - path: "../eww.md"
    title: "Opis repo"
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



---

---

**Backlinków:** 1  
**Linków wychodzących:** 0  
**Zaktualizowano:** 1763715821.5484378  


---

## 🔗 Backlinki

*Pliki linkujące do tego dokumentu:*

- [[core/TEMPLATES/TEMPLATES|TEMPLATES]]

## 📎 Źródła i powiązania

*Dokumenty powiązane:*

- [[core/TEMPLATES/TEMPLATES|TEMPLATES]]

---

**Backlinków:** 1  
**Linków wychodzących:** 1  
**Zaktualizowano:** 1763717741.383811  
