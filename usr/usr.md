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
title: "👥 Usr"






owner: jakubc
---

# 👥 Usr

> **Profile użytkowników i personalizacja**

## 📋 Cel folderu

Zawiera konfiguracje Remote SSH do katalogów domowych użytkowników na różnych fizycznych maszynach.

**KONCEPCJA**: Katalog `usr/` umożliwia dostęp przez SSH do katalogów domowych (`/home/<username>/`) na różnych maszynach. VS Code łączy się zdalnie i pracujesz bezpośrednio na zdalnym systemie plików.

> 📖 **[Przewodnik Remote SSH](SSH-REMOTE-GUIDE.md)** — jak skonfigurować połączenia SSH

## 📁 Struktura

```
usr/
├── jakubc/           # 🔗 → /home/jakubc/ (maszyna: dev-laptop)
│   ├── INDEX.md      # Indeks zawartości
│   ├── TODO/         # Listy zadań
│   ├── Notes/        # Notatki osobiste
│   ├── workspace/    # Projekty robocze
│   └── ...           # Pełna replika /home/jakubc/
└── karinam/          # 🔗 → /home/karinam/ (maszyna: ops-workstation)
    ├── INDEX.md      # Indeks zawartości
    ├── TODO-karinam-list.md
    ├── projects/     # Projekty
    ├── notes/        # Notatki
    └── ...           # Pełna replika /home/karinam/
```

## 📄 Index użytkowników

### 👤 Jakub Cybulski (jakubc)
- **Profil**: [[usr/jakubc/jakubc]]
- **Rola**: Główny maintainer, architekt systemu
- **Obszary**: Core development, infrastruktura, dokumentacja
- **Email**: jakub@eww.dev
- **GitHub**: @jakubc
- **Tag**: `#people/jakubc`
- **Kolor**: 🔵 Niebieski

### 👤 Karina M. (karinam)
- **Profil**: [[usr/karinam/karinam]]
- **Rola**: Developer, tester
- **Obszary**: Testing, UI/UX, dokumentacja użytkownika
- **Tag**: `#people/karinam` `#color/candy`
- **Kolor**: 🩷 Różowy (candy)

## 🔗 Powiązania

- [[docs]] - Dokumentacja współtworzona
- [[dev]] - Środowisko deweloperskie
- [[config]] - Konfiguracje systemowe
- [[CHANGELOG]] - Historia zmian (autorzy)

## 📊 Status

- **Typ**: Folder użytkowników
- **Liczba użytkowników**: 2
- **Główny maintainer**: [[usr/jakubc/jakubc|jakubc]]
- **Active**: jakubc, karinam

## 🎨 Konwencje tagowania

### Jakubc
- Tagi: `#people/jakubc`, `#role/maintainer`
- Kolor: Niebieski (#0066FF)
- Graph node: Duży, centralny

### Karinam
- Tagi: `#people/karinam`, `#role/developer`, `#color/candy`
- Kolor: Candy Pink (#FF69B4)
- Graph node: Średni, powiązany


**Ostatnia aktualizacja**: 2025-11-21
**Źródło**: User profiles EWW
