---
tags:
  - #asus_z77
  - #karinam
  - #workstation
created: 2025-11-22T23:26:00Z
modified: 2025-11-22T23:26:00Z
author: jakubc
title: "ASUS Z77 - Stacja robocza Kariny"
owner: karinam
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
# Automatyczne montowanie:
./scripts/mount-karinam-desktop.sh

# Ręcznie:
sshfs karinam@192.168.0.77:/home/karinam/devices/asus_z77/desktop \
  usr/karinam/devices/asus_z77/desktop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3

# Odmontowanie:
fusermount -u usr/karinam/devices/asus_z77/desktop
```

## Dokumentacja
- [Sprzęt](../../../../docs/infra/hardware/workstations/asus_z77/asus_z77.md)
- [Profil Kariny](../../karinam.md)
