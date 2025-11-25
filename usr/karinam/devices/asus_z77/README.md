---
tags:
  - #asus_z77
  - #karinam
  - #workstation
created: 2025-11-22T23:26:00Z
modified: 2025-11-22T23:26:00Z
author: jakubc
title: "ASUS Z77 - Stacja robocza Kariny"
---

# ASUS Z77 - Stacja robocza Kariny

## Informacje
- **IP:** 192.168.0.77
- **System:** Ubuntu 25.04 (Kubuntu)
- **Użytkownik:** karinam
- **Hostname:** AsusZ77

## Struktura

```
~/devices/asus_z77/
└── desktop/          # Główny pulpit (zamontowany przez SSHFS w VS Code)
    ├── inbox/
    ├── TODO/
    ├── projects/
    ├── notes/
    ├── research/
    ├── modules/
    │   ├── greenhouse/
    │   └── journal/
    ├── e-bay/
    └── Karina/

~/desktop → symlink do ~/devices/asus_z77/desktop
~/health/
```

## Montowanie SSHFS (jakubc)

```bash
# Automatyczne montowanie (start / status / stop / dry-run)
./scripts/mount-karinam-desktop.sh start
./scripts/mount-karinam-desktop.sh status
./scripts/mount-karinam-desktop.sh stop
./scripts/mount-karinam-desktop.sh --dry-run  # sprawdź komendę przed montażem

# Ręcznie:
sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
  usr/karinam/devices/asus_z77/desktop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3

# Odmontowanie:
fusermount -u usr/karinam/devices/asus_z77/desktop
```

Można nadpisać `REMOTE_*`, `SSH_PORT` i `SSHFS_OPTIONS`, gdy montujesz w niestandardowym środowisku.

## Synchronizacja plików spoza desktop/

```bash
cd /home/jakubc/git/eww
./scripts/sync-karinam-obsidian.sh push   # z lokalnego repo do Obsidian Kariny
./scripts/sync-karinam-obsidian.sh pull   # pobierz zmiany z Kariny
```

## Dokumentacja
- [Sprzęt](../../../../docs/infra/hardware/workstations/asus_z77/asus_z77.md)
- [Profil Kariny](../../karinam.md)
