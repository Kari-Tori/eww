---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T15:00:00Z
modified: 2025-11-21T15:00:00Z
author: jakubc
title: "⚙️ Makefile"






owner: jakubc
---

# ⚙️ Makefile

> **Główny plik automatyzacji zadań projektu EWW**

## 📋 Przeznaczenie

Makefile zawiera wszystkie główne komendy automatyzujące pracę z projektem.

## 🎯 Główne Targety

### 📚 Dokumentacja
```bash
make readme          # Generuj README
make changelog       # Generuj CHANGELOG
make docs            # Generuj całą dokumentację
```

### ✅ Testy i Walidacja
```bash
make test            # Uruchom testy
make lint            # Sprawdź kod
make validate        # Waliduj strukturę
```

### 🧹 Czyszczenie
```bash
make clean           # Wyczyść pliki tymczasowe
make clean-all       # Głębokie czyszczenie
```

### 🚀 Deployment
```bash
make install         # Instalacja
make deploy          # Deploy
```

## 🔗 Powiązania

**Z główną mapą**: [[EWW-MAP|🗺️ Repository Map]]  
**Z dokumentacją**: [[docs/infra/legacy/MAKEFILE-GUIDE|📚 Przewodnik]]  
**Z README**: [[README|📘 README]]

## 📊 Szczegóły

Pełna dokumentacja wszystkich targetów: [[docs/infra/legacy/MAKEFILE-GUIDE]]


**Lokalizacja**: `/Makefile`  
**Ostatnia aktualizacja**: 2025-11-21  
**Autor**: [[usr/jakubc/jakubc|Jakub C]]

#eww #core #makefile #automation #build
