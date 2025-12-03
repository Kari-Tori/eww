---
version: 0.0.1
tags:
  - #todo
  - #internet
  - #network
  - #debug
created: 2025-11-24
modified: 2025-11-24
author: jakubc
priority: 10
deadline: 2025-11-22T23:59:59Z
status: in-progress
owner: jakubc
---

# Internet - Diagnostyka Połączenia

## Problem

Firefox ma problemy z wczytywaniem stron na komputerze karinam@192.168.0.77

## Infrastruktura

- **Gateway/Router**: 192.168.0.10 (admin/admin) - ASUS DSL-N16
- **Asus Z77**: 192.168.0.77 (karinam)
- **Lenovo Y700**: Sprawdź w infra

## Zadania

- [ ] SSH do karinam@192.168.0.77
- [ ] Sprawdź łączność z gateway (ping 192.168.0.10)
- [ ] Sprawdź DNS
- [ ] Sprawdź routing
- [ ] Zaloguj się do routera GUI (192.168.0.10)
- [ ] Sprawdź logi routera
- [ ] Zaktualizuj dokumentację w `/eww/docs/infra`

## Diagnostyka

```bash
# Test połączenia
ping -c 4 192.168.0.10
ping -c 4 8.8.8.8
ping -c 4 google.com

# DNS
nslookup google.com
cat /etc/resolv.conf

# Routing
ip route
traceroute 8.8.8.8
```

## Notatki

- Router ASUS DSL-N16 to gateway (192.168.0.10)
- Garynet.md - gniazdko w ścianie, 20m kabel do innego budynku (router Gary)

## Linki

- [[TODO-2025-11-22]]
- [[../../../docs/infra/areas/network/gateway]]
- [[../../../docs/infra/areas/devices/asus-z77]]

## 🔗 Backlinks

- [[core/tasks/jakubc/TODO-daily/TODO-2025-11-22/TODO-2025-11-22]]
- [[core/core]]
- [[core/config]]