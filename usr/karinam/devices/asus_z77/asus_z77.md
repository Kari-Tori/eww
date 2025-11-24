---
tags:
  - #automation
  - #development
  - #eww
  - #karinam
  - #knowledge
  - #linux
  - #secondbrain
  - #folder_note
  - #index
  - #asus_z77
  - #workstation
created: 2025-11-22T21:00:00Z
modified: 2025-11-22T21:00:00Z
author: karinam
title: "🖥️ Asus Z77 Workstation | Karinam"
type: folder-note
location: usr/karinam/asus_z77
workstation: asus_z77
user: karinam
ip: 192.168.0.77
owner: karinam
---

# 🖥️ Asus Z77 Workstation | Karinam

> **Folder Note & Index** | Główna przestrzeń robocza Kariny na stacji Asus Z77

## 📌 Informacje

- 👤 **Użytkownik**: karinam
- 🏢 **Workstation**: Asus_Z77
- 🌐 **IP**: 192.168.0.77
- 📍 **Lokalizacja**: `/usr/karinam/asus_z77`
- 🎯 **Typ**: Profil stacji roboczej
- 📅 **Utworzono**: 2025-11-22

## 📁 Struktura katalogów

### 🖥️ Desktop
- [[usr/karinam/asus_z77/desktop/desktop|🖥️ Desktop]] - pulpit użytkownika
  - [[usr/karinam/asus_z77/desktop/TODO/TODO|📋 TODO]] - wszystkie zadania

### 📚 Modules
- [[usr/karinam/asus_z77/modules/journal/journal|📔 Journal]] - dziennik osobisty
- [[usr/karinam/asus_z77/modules/greenhouse/greenhouse|🌱 Greenhouse]] - moduł szklarnia
  - [[usr/karinam/asus_z77/modules/greenhouse/avocado/avocado|🥑 Avocado]] - submoduł awokado

### 📄 Pozostałe
- [[usr/karinam/asus_z77/docs/docs|📄 Docs]] - dokumentacja
- [[usr/karinam/asus_z77/pictures/pictures|📸 Pictures]] - zdjęcia
  - [[usr/karinam/asus_z77/pictures/Spectacle/Spectacle|📸 Spectacle]] - screenshoty

## 📊 Zawartość

```dataview
TABLE file.ctime as "Utworzono", file.tags as "Tagi"
FROM "usr/karinam/asus_z77"
WHERE file.name != "asus_z77"
SORT file.folder ASC, file.name ASC
```

## 🎯 Standardowe katalogi Kubuntu

Struktura odpowiada standardowym katalogom użytkownika w systemie Kubuntu:
- `Desktop` - pulpit (pliki widoczne na ekranie głównym)
- `Documents` (docs) - dokumenty
- `Pictures` - zdjęcia i screenshoty
- Custom modules - rozszerzenia specyficzne dla użytkownika

## 🔗 Powiązane

- [[usr/karinam/karinam|🩷 Karinam Profile]]
- [[usr/karinam/INDEX|🩷 INDEX - Karinam]]
- [[docs/infra/location|📍 Location]]

## 🔌 Połączenie SSHFS

**Zdalny dostęp z Jakub@GERC:**
```bash
# Montowanie przez SSHFS
sshfs karinam@192.168.0.77:/home/karinam/Desktop /home/jakubc/git/eww/usr/karinam/asus_z77/desktop

# Ścieżka zdalna: karinam@asus_z77:/home/karinam/Desktop
# Ścieżka lokalna: /home/jakubc/git/eww/usr/karinam/asus_z77/desktop
# System zdalny: Kubuntu (karinam@asus_z77)
# Klient: VS Code (jakubc@GERC)
```

**Status:** ✅ Aktywne połączenie SSHFS  
**Data konfiguracji:** 2025-11-22

## 📝 Notatki

Główna przestrzeń robocza Kariny na stacji Asus Z77 (192.168.0.77).
Katalogi zorganizowane zgodnie ze standardami XDG Base Directory + custom modules.

Desktop zmontowany zdalnie przez SSHFS do edycji w VS Code.

---

*Ostatnia aktualizacja: 2025-11-22 | Autor: karinam*
