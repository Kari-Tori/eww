---
title: Obsidian Troubleshooting
description: Obsidian - Rozwiązywanie problemów
type: file
category: docs
filepath: docs/obsidian-troubleshooting.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - obsidian
  - pkm
  - docs
  - knowledge
keywords:
  - notes
  - obsidian
  - pkm
  - vault
aliases:
  - obsidian_troubleshooting
related:
  - docs/docs.md
dependencies:
sources:
  - docs/obsidian-troubleshooting.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# Obsidian - Rozwiązywanie problemów

## Problem: Vault eww nie otwiera się w Obsidian

### Objawy
- Obsidian nie pokazuje vault eww na liście
- Błąd "Vault not found" lub podobny
- Vault był dostępny, ale przestał działać po zmianie użytkownika

### Diagnoza

Sprawdź konfigurację:
```bash
./scripts/eww-obsidian-fix.sh --check
```

### Przyczyny

1. **Błędna ścieżka w konfiguracji** - najczęstszy problem
   - Konfiguracja Obsidian wskazuje na `/home/INNY_UŻYTKOWNIK/git/eww`
   - Faktyczna ścieżka to `/home/OBECNY_UŻYTKOWNIK/git/eww`

2. **Brak katalogu `.obsidian`**
   - Vault nie został zainicjalizowany w Obsidian
   - Katalog `.obsidian` został usunięty

3. **Uprawnienia plików**
   - Brak dostępu do katalogu vault
   - Obsidian działa jako inny użytkownik

### Rozwiązanie

#### Automatyczna naprawa (zalecane)

```bash
./scripts/eww-obsidian-fix.sh --fix
```

Skrypt:
1. Tworzy backup konfiguracji
2. Poprawia ścieżki dla obecnego użytkownika
3. Weryfikuje poprawność

#### Ręczna naprawa

1. **Znajdź plik konfiguracji**:
   ```bash
   nano ~/.config/obsidian/obsidian.json
   ```

2. **Popraw ścieżki** na obecnego użytkownika:
   ```json
   {
     "vaults": {
       "59e40bb5db0b06eb": {
         "path": "/home/TWÓJ_UŻYTKOWNIK/git/eww",
         "ts": 1763338446031,
         "open": true
       }
     }
   }
   ```

3. **Zrestartuj Obsidian**

#### Inicjalizacja nowego vault

Jeśli `.obsidian` nie istnieje:

```bash
# 1. Upewnij się, że jesteś w repo
cd /home/$(whoami)/git/eww

# 2. Otwórz Obsidian i wybierz "Open folder as vault"
# 3. Wskaż katalog /home/TWÓJ_UŻYTKOWNIK/git/eww
```

## Problem: Wtyczki nie działają

### Diagnoza

```bash
ls -la .obsidian/plugins/
cat .obsidian/community-plugins.json
```

### Rozwiązanie

1. **Reinstalacja wtyczek**:
   - Settings → Community plugins → Browse
   - Zainstaluj ponownie brakujące wtyczki

2. **Synchronizacja z listą**:
   ```bash
   # Lista wymaganych wtyczek
   cat .obsidian/community-plugins.json
   ```

Wtyczki EWW:
- `dataview` - zapytania do notatek
- `obsidian-tasks-plugin` - zarządzanie zadaniami
- `templater-obsidian` - szablony
- `calendar` - kalendarz
- `make-md` - zarządzanie przestrzenią
- `obsidian-kanban` - tablice kanban

## Problem: Vault karinam nie jest dostępny

### Diagnoza

```bash
ls -la usr/karinam/.obsidian/
./scripts/eww-obsidian-fix.sh --check
```

### Rozwiązanie

Vault karinam jest **prywatny** i ignorowany przez Git (`.gitignore`):

```bash
# usr/ jest ignorowane
usr/
usr/*/inbox/
usr/*/workspace/
usr/*/.obsidian/
```

**Nie commituj** prywatnych danych z `usr/`!

Jeśli potrzebujesz dostępu:
1. Upewnij się, że jesteś właścicielem plików
2. Napraw ścieżki: `./scripts/eww-obsidian-fix.sh --fix`

## Problem: Synchronizacja między urządzeniami

### Uwagi

- **NIE synchronizuj** katalogu `usr/` (dane prywatne)
- **TAK synchronizuj** `.obsidian/` w głównym katalogu (konfiguracja vault)

### Zalecana struktura Git

```bash
# W repo (synchronizowane)
.obsidian/          # Konfiguracja głównego vault
docs/               # Dokumentacja projektu
bussiness/          # Dokumenty biznesowe

# Poza repo (NIE synchronizowane)
usr/jakubc/         # Prywatne notatki użytkownika
usr/karinam/        # Prywatne notatki użytkownika
```

### Syncthing dla prywatnych vaultów

Jeśli potrzebujesz sync prywatnych notatek:

1. Użyj **Syncthing** (NIE Git!)
2. Synchronizuj tylko `usr/UŻYTKOWNIK/`
3. Ustaw `.stignore` dla cache Obsidian:
   ```
   .obsidian/workspace.json
   .obsidian/workspace-mobile.json
   ```

## Narzędzia diagnostyczne

### Sprawdzenie stanu vault

```bash
# Konfiguracja Obsidian
./scripts/eww-obsidian-fix.sh --check

# Struktura .obsidian
tree -L 2 .obsidian/

# Rozmiar vault
du -sh .
```

### Logi Obsidian

Linux:
```bash
# Logi aplikacji
~/.config/obsidian/logs/

# Developer Console w Obsidian
Ctrl+Shift+I → Console
```

## Checklist troubleshooting

- [ ] Sprawdź ścieżki w `~/.config/obsidian/obsidian.json`
- [ ] Weryfikuj istnienie `.obsidian/` w katalogu vault
- [ ] Upewnij się, że jesteś właścicielem plików (`ls -la`)
- [ ] Sprawdź czy Obsidian nie działa już w tle (`ps aux | grep obsidian`)
- [ ] Uruchom `./scripts/eww-obsidian-fix.sh --fix`
- [ ] Zrestartuj Obsidian
- [ ] Sprawdź logi błędów (Ctrl+Shift+I)

## FAQ

**Q: Czy mogę mieć wiele vaultów w jednym repo?**  
A: Tak! EWW ma strukturę:
- `/home/UŻYTKOWNIK/git/eww` - główny vault projektu
- `/home/UŻYTKOWNIK/git/eww/usr/karinam` - prywatny vault karinam

**Q: Dlaczego vault przestał działać po zmianie użytkownika?**  
A: Konfiguracja Obsidian zawiera bezwzględne ścieżki z nazwą użytkownika. Użyj `eww-obsidian-fix.sh --fix`.

**Q: Czy mogę usunąć `.obsidian/`?**  
A: **NIE** dla głównego vault (traci konfigurację wtyczek). **TAK** dla `usr/*/.obsidian` (dane prywatne, ignorowane przez Git).

**Q: Jak dodać nowy vault?**  
A: Obsidian → Settings → Open another vault → Open folder as vault → Wybierz katalog.

## Zobacz także

- [Obsidian Documentation](https://help.obsidian.md/)
- [eww/scripts/eww-obsidian-fix.sh](../scripts/eww-obsidian-fix.sh)
- [eww/.gitignore](../.gitignore) - ignorowane katalogi
- [docs/narzedzia-deweloperskie.md](narzedzia-deweloperskie.md)
