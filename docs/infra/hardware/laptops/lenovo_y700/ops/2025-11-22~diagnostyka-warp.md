---
version: 0.0.1
tags:
  - #Lenovo_Y700
  - #ops
  - #warp
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "2025-11-22 · Diagnostyka WARP"
owner: jakubc
---

# 2025-11-22 · Diagnostyka WARP

## Kontekst
- Po awarii internetu na `asus_z77` laptop Y700 ma służyć jako kontrolne środowisko do testów Cloudflare Zero Trust oraz tetheringu.

## Zadania
- [ ] @jakubc przygotować scenariusz: tethering z iPhone (Wi-Fi hotspot) → Y700 → LAN 192.168.0.0/24.
- [ ] @jakubc zweryfikować jak Y700 dzieli łącze (USB tether vs Wi-Fi) i dopisać konfigurację `nmcli`.
- [ ] @jakubc zapisać wyniki `warp-cli status`, `ping 8.8.8.8` (WARP ON/OFF) i dodać do `docs/infra/hardware/network/network.md` jeżeli będzie używany jako failover.

## 🔗 Backlinks

- [[docs/infra/hardware/laptops/lenovo_y700/ops/ops]]
- [[docs/docs]]
- [[INDEX]]