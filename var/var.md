---
title: 💾 Variable Data
type: folder-note
status: active
tags:
  - hub
  - var
  - data
  - cache
  - eww
author: jakubc
created: 2025-11-21
updated: 2025-11-21
---

# 💾 Variable Data

> **Dane zmienne, cache i logi projektu EWW**

## 📋 Przeznaczenie Folderu

Folder dla danych zmiennych, cache, logów i plików tymczasowych.

## 📑 Zawartość Folderu

### 📊 Kategorie

#### 📝 Logi
- Application logs
- Error logs
- Debug logs

#### 💾 Cache
- Build cache
- Download cache
- Temporary files

#### 📦 Data
- Runtime data
- State files
- Temporary databases

## 🔗 Powiązania

**Z główną mapą**: [[EWW-MAP|🗺️ Repository Map]]  
**Z infrastrukturą**: [[infra/infra|🏗️ Infra]]

## 📊 Struktura

```
var/
├── logs/       # Logi aplikacji
├── cache/      # Cache i pliki tymczasowe
└── data/       # Dane runtime
```

## ⚠️ Uwaga

Zawartość tego folderu jest ignorowana przez Git (`.gitignore`).

## 🎨 Oznaczenie Grafu

**Tag**: `#var`  
**Kolor**: Domyślny (szary)  
**Widoczność**: Niska (dane zmienne)

---

**Lokalizacja**: `/var/`  
**Ostatnia aktualizacja**: 2025-11-21  
**Autor**: [[usr/jakubc/jakubc|Jakub C]]

#var #data #cache #eww
