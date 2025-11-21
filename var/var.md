---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T16:00:00Z
modified: 2025-11-21T16:00:00Z
author: jakubc
title: "💾 Var"






---

# 💾 Var

> **Dane zmienne, cache, logi i temporary files**

## 📋 Cel folderu

Zawiera wszystkie dane zmienne projektu: logi, cache, pliki tymczasowe, runtime data - elementy generowane automatycznie i zmieniające się podczas działania.

## 📁 Struktura

```
var/
├── log/              # Pliki logów
├── cache/            # Cache aplikacji
├── tmp/              # Pliki tymczasowe
├── runtime/          # Runtime data
└── backup/           # Backupy (rotacja)
```

## 📄 Index plików

### Logs
- [[error.log]] - Logi błędów
- [[access.log]] - Logi dostępu
- [[debug.log]] - Logi debugowania
- [[system.log]] - Logi systemowe

### Cache
- [[git-cache]] - Cache operacji Git
- [[build-cache]] - Cache buildów
- [[deps-cache]] - Cache zależności

### Runtime
- [[pid-files]] - Pliki PID procesów
- [[lock-files]] - Pliki blokad
- [[state-files]] - Pliki stanu

## ⚙️ Zarządzanie

### Rotacja logów
- Automatyczna rotacja co tydzień
- Kompresja starych logów (.gz)
- Retention: 30 dni

### Czyszczenie
```bash
# Wyczyść cache
make clean-cache

# Wyczyść logi starsze niż 30 dni
make clean-logs

# Wyczyść wszystko w var/tmp
make clean-tmp
```

## 🔗 Powiązania

- [[infra/monitoring]] - System monitoringu
- [[scripts/lib/log.sh]] - Biblioteka logowania
- [[.gitignore]] - Folder var/ w .gitignore
- [[Makefile]] - Targety czyszczenia

## 📊 Status

- **Typ**: Folder danych zmiennych
- **Volatile**: TAK (nie commitować do Git!)
- **Backup**: Tak (dla logów)
- **Monitoring**: Tak (rotacja, wielkość)

## ⚠️ Ważne

**Folder var/ NIE jest commitowany do Git!**  
Zawartość jest generowana automatycznie i zmienia się w runtime.


**Ostatnia aktualizacja**: 2025-11-21  
**Źródło**: Variable data EWW  
**Gitignore**: var/*
