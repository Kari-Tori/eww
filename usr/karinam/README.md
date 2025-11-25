---
tags:
  - #karinam
  - #profile
  - #readme
created: 2025-11-22T23:42:00Z
modified: 2025-11-22T23:42:00Z
author: jakubc
title: "README - Przestrzeń użytkownika karinam"
---

# 🩷 Karinam - Przestrzeń użytkownika

> **Profil użytkownika w projekcie E-Waste Workshop**

## 📋 Szybki start

- **Profil:** [karinam.md](./karinam.md)
- **Urządzenia:** [devices/README.md](./devices/README.md)
- **Changelog:** [CHANGELOG-2025-11-22.md](./CHANGELOG-2025-11-22.md)

## 📁 Struktura

```
usr/karinam/
├── devices/              # Urządzenia
│   ├── asus_z77/        # Komputer stacjonarny (192.168.0.77)
│   │   ├── desktop/     # Pulpit (SSHFS mount)
│   │   ├── README.md
│   │   └── asus_z77.md
│   ├── iphone/          # iPhone (szablon)
│   ├── watch/           # Apple Watch (szablon)
│   └── devices.md
├── health/              # Zdrowie i fitness
├── karinam.md          # Profil użytkownika
├── README.md           # Ten plik
└── CHANGELOG-*.md      # Logi zmian
```

## 🖥️ ASUS Z77 Desktop

Desktop kariny zamontowany przez SSHFS z ASUS Z77 (Kubuntu).

**Struktura desktop:**
```
desktop/
├── inbox/              # Nowe wpisy
├── modules/            # Moduły (greenhouse, journal)
├── TODO/               # Zadania
├── old-desktop/        # Archiwum
└── INDEX.md           # Indeks
```

**Montowanie:**
```bash
# Automatyczne:
./scripts/mount-karinam-desktop.sh

# Ręcznie:
sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
  usr/karinam/devices/asus_z77/desktop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3

# Odmontowanie:
fusermount -u usr/karinam/devices/asus_z77/desktop
```

## 🔗 Dostęp

### SSH
```bash
ssh karinam@192.168.0.77
```

### Desktop na ASUS Z77
- **Fizycznie:** `/home/karinam/devices/asus_z77/desktop`
- **Symlink:** `~/desktop` → `~/devices/asus_z77/desktop`
- **XDG:** `$HOME/desktop`

### VS Code (jakubc)
- SSHFS mount: `usr/karinam/devices/asus_z77/desktop`
- Edycja zdalna w czasie rzeczywistym

## 📚 Dokumentacja

- [Profil karinam](./karinam.md) - pełny profil użytkownika
- [Lista urządzeń](./devices/README.md) - ASUS Z77, iPhone, Watch
- [ASUS Z77 README](./devices/asus_z77/README.md) - instrukcje workstation
- [Desktop INDEX](./devices/asus_z77/desktop/INDEX.md) - indeks pulpitu
- [Changelog](./CHANGELOG-2025-11-22.md) - historia zmian

## 🔄 Historia zmian

- **2025-11-22:** Pełna reorganizacja struktury
  - Utworzono devices/
  - Przeniesiono desktop na ASUS Z77
  - Zreorganizowano desktop (inbox, modules, TODO)
  - Archiwizacja starej zawartości

## 👥 Współpraca

**Karinam:**
- Pracuje lokalnie na ASUS Z77 (Kubuntu)
- Desktop: `~/desktop`

**Jakubc:**
- Dostęp przez SSHFS w VS Code
- Edycja zdalna desktop kariny

---

*Ostatnia aktualizacja: 2025-11-22 | Autor: jakubc*
