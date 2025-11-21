---
tags:
  - "#type/folder-note"
  - "#area/scripts"
  - "#status/active"
  - "#lang/bash"
cssclasses:
  - folder-note
created: 2025-11-21
author: jakubc
---

# 📜 Scripts

> **Skrypty produkcyjne i narzędziowe projektu**

## 📋 Cel folderu

Zawiera wszystkie skrypty Bash używane w projekcie: narzędzia CLI, automatyzację, pomocnicze utility i skrypty systemowe.

## 📁 Struktura

```
scripts/
├── bin/              # Skrypty wykonywalne (główne)
├── lib/              # Biblioteki pomocnicze (*.sh)
├── utils/            # Narzędzia pomocnicze
└── legacy/           # Stare skrypty (deprecated)
```

## 📄 Index plików

### Główne skrypty (bin/)
- [[eww-init]] - Inicjalizacja środowiska
- [[eww-setup]] - Setup systemu
- [[eww-update]] - Aktualizacja komponentów
- [[eww-backup]] - System backupu

### Biblioteki (lib/)
- [[lib/log.sh]] - Funkcje logowania
- [[lib/git.sh]] - Operacje Git
- [[lib/colors.sh]] - Kolorowanie outputu
- [[lib/validation.sh]] - Walidacja danych

### Utils
- [[cleanup-utils]] - Narzędzia czyszczenia
- [[file-utils]] - Operacje na plikach
- [[string-utils]] - Manipulacja stringami

## 🔧 Konwencje

### Shebang
```bash
#!/usr/bin/env bash
set -euo pipefail
```

### Nazewnictwo
- Funkcje: `eww::nazwa_funkcji` lub `nazwa_funkcji`
- Zmienne globalne: `EWW_NAZWA` (uppercase)
- Zmienne lokalne: `local nazwa` (lowercase)

### Styl
- Komentarze po polsku
- Walidacja argumentów
- Obsługa błędów
- Logowanie przez `lib/log.sh`

## 🔗 Powiązania

- [[Makefile]] - Targety Make używające skryptów
- [[dev]] - Skrypty deweloperskie
- [[infra]] - Skrypty infrastrukturalne
- [[docs/bash-best-practices]] - Best practices
- [[init-eww.sh]] - Główny skrypt init

## 📊 Status

- **Typ**: Folder skryptów
- **Język**: Bash 5.0+
- **Standard**: POSIX + Bashisms
- **Maintainer**: [[usr/jakubc/jakubc|jakubc]]
- **Testowanie**: BATS framework

---

**Ostatnia aktualizacja**: 2025-11-21  
**Źródło**: Scripts EWW  
**Style**: [[.editorconfig]]
