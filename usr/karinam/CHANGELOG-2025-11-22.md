---
version: 0.0.6
modified: 2025-11-25
tags:
  - #changelog
  - #karinam
  - #reorganization
created: 2025-11-24
author: jakubc
title: "CHANGELOG - Reorganizacja struktury karinam (2025-11-22)"
---

# CHANGELOG - Reorganizacja struktury karinam

**Data:** 2025-11-22  
**Autor:** jakubc  
**Zakres:** Pełna reorganizacja struktury katalogów karinam

## 🎯 Cel reorganizacji

Uporządkowanie struktury plików karinam z podziałem na:
- **devices/** - urządzenia (asus_z77, iphone, watch)
- **desktop/** - pulpit z ASUS Z77 (SSHFS mount)
- **health/** - zdrowie i fitness

## 📝 Główne zmiany

### 1. Utworzono strukturę urządzeń
```
usr/karinam/devices/
├── devices.md          # Lista urządzeń
├── asus_z77/          # Komputer stacjonarny
├── iphone/            # Szablon iPhone
└── watch/             # Szablon Apple Watch
```

### 2. Przeniesiono desktop na ASUS Z77
**Zdalna lokalizacja (karinam@192.168.0.77):**
- `~/desktop` → `~/devices/asus_z77/desktop` (fizycznie)
- `~/desktop` → symlink do `~/devices/asus_z77/desktop` (dla kompatybilności)

**Lokalna lokalizacja (jakubc):**
- SSHFS: `usr/karinam/devices/asus_z77/desktop`

### 3. Reorganizacja desktop

**Nowa struktura:**
```
desktop/
├── inbox/              # Nowe wpisy (Karina → inbox)
├── modules/
│   ├── greenhouse/     # Szklarnia (z avocado)
│   └── journal/        # Dziennik
├── TODO/               # Zadania
├── old-desktop/        # Archiwum starej zawartości
└── INDEX.md           # Indeks
```

**Zmiany:**
- `Karina/` → `inbox/`
- Stara zawartość (e-bay, kwiatki, youtube, dokumenty) → `old-desktop/`
- Utworzono: `modules/greenhouse/`, `modules/journal/`, `TODO/`

### 4. Przeniesiono moduły
- `usr/karinam/greenhouse` → `desktop/modules/greenhouse`
- `usr/karinam/modules/` → scalono z `desktop/modules/`

### 5. Usunięto duplikaty
- Usunięto: `usr/karinam/INDEX.md`
- Usunięto: `usr/karinam/README.md`
- Usunięto: `usr/karinam/asus_z77/` (stara lokalizacja)
- Usunięto: `usr/karinam/Inbox/`, `notes/`, `projects/`, `research/`, `TODO/`

### 6. Przeniesiono do core
- `usr/karinam/house` → `core/house`

### 7. Zaktualizowano montowanie SSHFS
**Stara ścieżka:**
```bash
karinam@192.168.0.77:/home/karinam/desktop
```

**Nowa ścieżka:**
```bash
karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop
```

## 📄 Nowe pliki dokumentacji

- `usr/karinam/devices/devices.md` - lista urządzeń
- `usr/karinam/devices/asus_z77/README.md` - instrukcja ASUS Z77
- `usr/karinam/devices/asus_z77/desktop/INDEX.md` - indeks desktop
- `usr/karinam/devices/asus_z77/desktop/old-desktop/old-desktop.md` - dokumentacja archiwum
- `usr/karinam/devices/iphone/iphone.md` - szablon iPhone
- `usr/karinam/devices/watch/watch.md` - szablon Apple Watch
- `usr/karinam/karinam.md` - zaktualizowany profil

## 🔧 Zaktualizowane skrypty

- `scripts/mount-karinam-desktop.sh` - zaktualizowane ścieżki montowania

## ✅ Finalna struktura

```
usr/karinam/
├── devices/
│   ├── asus_z77/
│   │   ├── desktop/          # SSHFS mount
│   │   │   ├── inbox/
│   │   │   ├── modules/
│   │   │   ├── TODO/
│   │   │   ├── old-desktop/
│   │   │   └── INDEX.md
│   │   ├── asus_z77.md
│   │   └── README.md
│   ├── iphone/
│   │   └── iphone.md
│   ├── watch/
│   │   └── watch.md
│   └── devices.md
├── health/
│   └── health.md
└── karinam.md
```

## 🔗 Montowanie

```bash
# Automatyczne:
./scripts/mount-karinam-desktop.sh

# Ręcznie:
sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
  usr/karinam/devices/asus_z77/desktop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
```

## 📊 Statystyki

- **Katalogów utworzonych:** 7
- **Plików przeniesiony:** ~50
- **Archiwizowanych elementów:** 15+ (w old-desktop)
- **Nowych plików dokumentacji:** 7
- **Zaktualizowanych plików:** 3

## 💡 Korzyści

1. ✅ Czysta struktura katalogów
2. ✅ Podział na urządzenia
3. ✅ Desktop zorganizowany (inbox, modules, TODO)
4. ✅ Stara zawartość zarchiwizowana
5. ✅ Pełna dokumentacja
6. ✅ SSHFS działa na nowej ścieżce
7. ✅ Kompatybilność wsteczna (symlink ~/desktop)

---

*Autor: jakubc | Data: 2025-11-22T23:40:00Z*

## 🔗 Backlinks

- [[usr/karinam/karinam]]
- [[EWW-MAP]]
- [[INDEX]]
