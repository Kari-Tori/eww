---
created: 2025-12-01
modified: 2025-12-01T21:10:00Z
modified: 2025-12-01T22:15:00Z
tags:
  - #folder_note
  - #network
  - #infra
title: "network (sprzęt i łączność)"
---

# 🌐 Network — źródło prawdy

Centralne miejsce dla sprzętu sieciowego (routery, switche, uplinki GaryNet, tymczasowe mostki LTE).

## 📌 Zakres
- Plan adresacji, topologia (fizyczna/logiczna), VLAN/VPN/routing.
- Dokumentacja urządzeń i portów: Catalyst 3650, Netgear FS108, TL-WR902AC (WISP), ASUS DSL-N16, GaryNet uplink.
- Wdrażanie dual-WAN (GaryNet ↔ LTE/tethering) i migracja hostów z Netgear na Catalyst.

## 🌍 Aktualny stan WAN
- **GaryNet (Sky ER115):** RJ45 w ścianie, aktualnie tylko do diagnostycznego AP (TL-WR902AC Share ETH); router Sky ER115 firmware 4.13.07.04.r, status: modem/WAN disconnected (do weryfikacji u Gary’ego).
- **Primary (planowany):** GaryNet → router dual-WAN → Catalyst.
- **Backup (tymczasowy):** iPhone → Wi-Fi → Lenovo Y700 (ICS) → WAN ASUS DSL-N16; alternatywnie TL-WR902AC w trybie WISP/Client.  
- **Stare środowisko:** Netgear FS108 jako edge DEV, ASUS DSL-N16 z uplinkiem z Y700 (do wygaszenia po wdrożeniu dual-WAN).

## 📑 Kluczowe urządzenia / pliki
- [[cisco-3650-catalyst-poe-24/cisco-3650-catalyst-poe-24|Cisco 3650]] — core switch, PoE, plan/ports/specs/logi.
- [[netgear_fs108/netgear_fs108|Netgear FS108]] — stary edge DEV.
- [[tp-link_tl-wr902ac]] — bridge WISP do hotspotu (tymczasowy WAN).
- [[garynet]] — uplink między budynkami (Sky → RJ45 w ścianie).
- [[status/status]] — migawki/runbooki WAN (tethering, fallback).
- [[network-deployment]] / [[network-deployment-2025-11-23]] — plan i log wdrożenia dual-WAN/Catalyst.
- [[cisco-switch-port-map]] — mapowanie portów Catalyst/Netgear.
- [[devices/asus-dsl-n16/asus-dsl-n16]] — router ADSL/VDSL (legacy).
- [[network_diagram]] — aktualna topologia w Mermaid.

## 🧭 TODO (wysoki poziom)
- [ ] Sfinalizować wybór routera dual-WAN + polityka failover.
- [ ] Przenieść hosty z Netgear na Catalyst (zgodnie z planem).
- [ ] Uzupełnić adresację/VLAN + DHCP/DNS w jednym źródle.
- [ ] Monitorować GaryNet (ping/metryki) i PoE na Catalyście.

## 🚨 Znane problemy (historyczne)
- 2025-11-22: `asus_z77` bez internetu — winny klient Cloudflare WARP na hoście; po `warp-cli disconnect`/`systemctl stop warp-svc` ruch wrócił (router ASUS DSL-N16 ok).
- Tethering z iPhone degraduje baterie i jest niestabilny; docelowo zastępujemy LTE modemem/routerem + dual-WAN.

## 📂 Struktura folderu
- `garynet.md` — opis połączenia między budynkami.
- `network-deployment*.md` — plan + log wdrożenia.
- `devices/` — sprzęt sieciowy (ASUS DSL-N16).
- `cisco-3650-catalyst-poe-24/` — core switch.
- `netgear_fs108/`, `tp-link_tl-wr902ac.md`, `cisco-switch-port-map.md`.

## 🔗 Backlinki
- [[hardware]]
