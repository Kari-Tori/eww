---
tags:
  - #Lenovo_M710q
  - #ops
created: 2025-11-22T18:41:00Z
modified: 2025-11-22T18:41:00Z
author: jakubc
title: "2025-11-22 · Provisioning plan"
owner: jakubc
---

# 2025-11-22 · Provisioning plan

## Kroki
1. Aktualizacja BIOS + reset do defaults.
2. Instalacja docelowego OS (Proxmox lub Ubuntu Server).
3. Konfiguracja statycznego IP (propozycja 192.168.0.40/24) + wpis do DNS.

## TODO
- [ ] @jakubc przygotować bootowalnego pendrive (Ventoy + ISO).
- [ ] @jakubc zdefiniować rolowanie backupów (rsync / snapshoty ZFS).
