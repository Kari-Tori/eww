---
tags:
  - #devices
  - #karinam
  - #hardware
created: 2025-11-22T23:01:42Z
modified: 2025-11-22T23:01:42Z
author: jakubc
title: "Urządzenia przypisane do karinam"
---

# Urządzenia przypisane do karinam

## Lista urządzeń

### 1. ASUS Z77 (Komputer stacjonarny)
- **Typ:** Workstation
- **Lokalizacja:** LAN domowy (192.168.0.77)
- **System:** Ubuntu 25.04
- **Dokumentacja:** [ASUS Z77](../../../docs/infra/hardware/workstations/asus_z77/asus_z77.md)
- **Profil:** [asus_z77.md](usr/karinam/devices/asus_z77/asus_z77.md)
- **Desktop:** [desktop/](./asus_z77/desktop/)

### 2. iPhone
- **Typ:** Smartphone
- **Profil:** [iphone.md](./iphone/iphone.md)
- **Status:** Do uzupełnienia

### 3. Apple Watch
- **Typ:** Smartwatch
- **Profil:** [watch.md](./watch/watch.md)
- **Status:** Do uzupełnienia

## Dostęp

### SSH/SFTP
```bash
ssh karinam@192.168.0.77
```

### SSHFS Mount (VS Code - jakubc)
Desktop kariny zamontowany przez SSHFS w VS Code (jakubc):
```bash
# Montowanie:
sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
  usr/karinam/devices/asus_z77/desktop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3

# Aktualnie zamontowany:
karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop → /home/jakubc/git/eww/usr/karinam/devices/asus_z77/desktop
```

### Użytkowanie
- **Karinam** - pracuje na swoim komputerze ASUS Z77 (Kubuntu), używa `~/desktop` (symlink → `~/devices/asus_z77/desktop`)
- **Jakubc** - VS Code podłączone przez SSHFS do jej desktop
- **Synchronizacja** - zmiany w czasie rzeczywistym przez SSHFS (edycja w VS Code jakubc = edycja na ASUS Z77 karinam)

## Notatki
- Komputer ASUS Z77 (192.168.0.77) - główna stacja robocza Kariny z Kubuntu
- Desktop Kariny: `~/desktop` → symlink do `~/devices/asus_z77/desktop`
- VS Code (jakubc) podłączone przez SSHFS do jej desktop - edycja zdalna
- Zmiany synchronizowane w czasie rzeczywistym
- iPhone i Apple Watch - szablony do uzupełnienia
