---
tags:
  - #live-sync
  - #obsidian
  - #sshfs
  - #karinam
  - #documentation
created: 2025-11-23T00:26:00Z
modified: 2025-11-23T00:26:00Z
author: jakubc
title: "LIVE SYNC - Desktop Kariny (Obsidian ↔ VS Code)"
---

# ⚡ LIVE SYNC - Desktop Kariny

> **Live synchronizacja** między Obsidian (karinam) a VS Code (jakubc)

## 🎯 Jak to działa

### Architektura LIVE SYNC

```
KARINA (Obsidian)                          JAKUBC (VS Code)
~/git/eww/                                 /home/jakubc/git/eww/
└── usr/karinam/                           └── usr/karinam/
    └── devices/                               └── devices/
        └── asus_z77/                              └── asus_z77/
            └── desktop/                               └── desktop/
                ↓ (symlink)                                ↓ (SSHFS mount)
                /home/karinam/devices/asus_z77/desktop/   karinam@192.168.0.77:
                ↑                                          ~/devices/asus_z77/desktop
                └─────────────── TEN SAM FOLDER FIZYCZNIE ─────────────────┘
```

### Kluczowe elementy

1. **Folder fizyczny** (źródło prawdy):
   ```
   karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop/
   ```

2. **Symlink w Obsidian vault Kariny**:
   ```bash
   ~/git/eww/usr/karinam/devices/asus_z77/desktop
   → /home/karinam/devices/asus_z77/desktop
   ```

3. **SSHFS mount w VS Code (jakubc)**:
   ```bash
   /home/jakubc/git/eww/usr/karinam/devices/asus_z77/desktop
   → karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop
   ```

## 📁 Co jest LIVE

### ⚡ LIVE (synchronizacja natychmiastowa)

Wszystko w `desktop/`:
- `desktop.md` - folder note
- `inbox/` - nowe wpisy
- `modules/` - moduły (greenhouse, journal)
  - `greenhouse/flowers/` - inwentaryzacja kwiatów
  - `greenhouse/kwiatki/` - zdjęcia roślin
  - `greenhouse/avocado/` - hodowla awokado
- `TODO/` - zadania
- `old-desktop/` - archiwum

**Zmiany widoczne natychmiast w obie strony!**

### 📦 Wymaga rsync (ręczna synchronizacja)

Pliki poza `desktop/`:
- `karinam.md` - profil
- `devices/README.md`
- `devices/iphone/`
- `devices/watch/`
- `health/`
- `README.md`
- `CHANGELOG-*.md`

**Synchronizacja:** `./scripts/sync-karinam-obsidian.sh push`

- `push` (default) kopiuje lokalne zmiany poza `desktop/` do `karinam@192.168.0.77:/home/karinam/git/eww/usr/karinam`
- `pull` pobiera zmiany z Kariny do lokalnego `usr/karinam`
- `--dry-run` pozwala sprawdzić komendę rsync przed wykonaniem

## 🔧 Konfiguracja

### Setup (wykonany 2025-11-23)

1. **Na serwerze Kariny (asus_z77)**:
   ```bash
   # Fizyczny desktop
   mkdir -p ~/devices/asus_z77/desktop
   
   # Symlink dla kompatybilności
   ln -s ~/devices/asus_z77/desktop ~/desktop
   
   # Symlink w Obsidian vault
   cd ~/git/eww/usr/karinam/devices/asus_z77
   ln -s /home/karinam/devices/asus_z77/desktop desktop
   ```

2. **Lokalnie (jakubc)**:
 ```bash
 # SSHFS mount (ręcznie)
 sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
   usr/karinam/devices/asus_z77/desktop \
   -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
 
 # Automatycznie: start (domyślnie) / check / stop
 ./scripts/mount-karinam-desktop.sh start
 ./scripts/mount-karinam-desktop.sh status
 ./scripts/mount-karinam-desktop.sh stop
 ./scripts/mount-karinam-desktop.sh --dry-run  # sprawdź komendę przed montażem
 # Możesz nadpisać wartości przez zmienne środowiskowe: REMOTE_USER / REMOTE_HOST / REMOTE_PATH / SSH_PORT / SSHFS_OPTIONS
   ```

### Weryfikacja działania

```bash
# Test live sync
echo "Test z jakubc" >> usr/karinam/devices/asus_z77/desktop/LIVE-SYNC-TEST.md
# → Karina widzi zmianę natychmiast w Obsidian (Ctrl+R)

# Test w drugą stronę
# Karina edytuje w Obsidian → Jakubc widzi w VS Code natychmiast
```

## 🚀 Workflow

### Karina (Obsidian)

1. Otwórz vault: `~/git/eww`
2. Przejdź do: `usr/karinam/devices/asus_z77/desktop/`
3. Edytuj dowolny plik
4. Zapisz (Ctrl+S)
5. **Zmiany widoczne natychmiast dla jakubc w VS Code!**

### Jakubc (VS Code)

1. Otwórz: `/home/jakubc/git/eww`
2. Edytuj: `usr/karinam/devices/asus_z77/desktop/*`
3. Zapisz (Ctrl+S)
4. **Zmiany widoczne natychmiast dla Kariny w Obsidian!**

### Synchronizacja innych plików

```bash
# Po edycji plików poza desktop/
cd /home/jakubc/git/eww
./scripts/sync-karinam-obsidian.sh push
# Użyj `pull`, żeby pobrać zmiany z Obsidian Kariny

# Karina w Obsidian: Ctrl+R (refresh)
```

## 🔍 Troubleshooting

### Desktop nie widoczny w Obsidian

```bash
# Sprawdź symlink
ssh karinam@192.168.0.77
ls -la ~/git/eww/usr/karinam/devices/asus_z77/desktop

# Powinno być:
# lrwxrwxrwx ... desktop -> /home/karinam/devices/asus_z77/desktop

# Jeśli nie działa - usuń i utwórz ponownie
cd ~/git/eww/usr/karinam/devices/asus_z77
rm desktop
ln -s /home/karinam/devices/asus_z77/desktop desktop
```

### SSHFS nie działa (jakubc)

```bash
# Odmontuj
./scripts/mount-karinam-desktop.sh stop

# Lub sprawdź status / surowy fusermount:
fusermount -u usr/karinam/devices/asus_z77/desktop  # jeśli fusermount jest preferowany

# Zamontuj ponownie
./scripts/mount-karinam-desktop.sh start
```

### Zmiany nie synchronizują się

1. **Dla desktop/** - sprawdź SSHFS:
   ```bash
   mount | grep karinam
   ```

2. **Dla innych plików** - użyj rsync:
   ```bash
   ./scripts/sync-karinam-obsidian.sh push
   ```

## 📊 Statystyki

- **Live sync**: ~100% plików na desktop
- **Latencja**: <1s (sieć lokalna)
- **Stabilność**: SSHFS z auto-reconnect
- **Vault size**: ~232MB (głównie zdjęcia w greenhouse)

## 🔗 Powiązane

- [Desktop](./desktop/desktop.md) - główny folder note
- [ASUS Z77 README](./README.md) - dokumentacja urządzenia
- [Skrypt montowania](../../../scripts/mount-karinam-desktop.sh)
- [Skrypt synchronizacji](../../../scripts/sync-karinam-obsidian.sh)

---

**Data konfiguracji:** 2025-11-23  
**Autor:** jakubc  
**Status:** ✅ Działający  
**Ostatni test:** 2025-11-23 00:13 (LIVE-SYNC-TEST.md)
