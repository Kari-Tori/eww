---
tags:
  - #network
  - #router
  - #wifi
  - #wisp
created: 2025-12-01T20:25:00Z
modified: 2025-12-01T20:25:00Z
author: jakubc
title: "TP-Link TL-WR902AC — travel/WISP"
status: planning
owner: jakubc
---

# TP-Link TL-WR902AC — travel/WISP

Mały router podróżny AC750 (2.4/5 GHz) z 1×10/100 RJ45. Używamy go tymczasowo jako WISP/Client do mostkowania hotspotu (iPhone) na port RJ45 dla routera/Asusa.

## 🎛️ Tryby
- Router/AP
- WISP/Client (Wi-Fi → NAT → RJ45) — **docelowy tryb tymczasowy**
- Repeater/Hotspot (hotel Wi-Fi → LAN/Wi-Fi)
- Access Point (RJ45 → Wi-Fi)

## 🔌 Porty i zasilanie
- 1× 10/100 Mb/s WAN/LAN (auto-MDI/MDIX)
- Wi-Fi 2.4 GHz (300 Mb/s) + 5 GHz (433 Mb/s)
- Zasilanie micro-USB 5 V (zalecane ≥2 A)

## ⚙️ Konfiguracja (WISP)
1) Reset do fabrycznych, zaloguj się (domyślnie `192.168.0.1`, admin/admin lub asystent).
2) Wybierz tryb **WISP/Client** i połącz z hotspotem iPhone (SSID/hasło).
3) LAN/IP lokalny: ustaw podsieć inną niż główna (np. 192.168.50.0/24), DHCP włączone.
4) Podłącz RJ45 z TL-WR902AC do portu WAN routera (tymczasowy WAN2) lub do uplinku, jeśli router ma pojedynczy WAN.
5) Zweryfikuj dostęp do internetu z hosta za routerem; sprawdź, czy brak konfliktów DHCP z GaryNet.

## 🛡️ Uwagi
- Podwójny NAT (hotspot → TP-Link → router) — zaakceptowane tymczasowo.
- Izolacja: nie mostkuj do LAN; trzymaj własną podsieć dla WAN zastępczego.
- Aktualizuj firmware przed produkcyjnym użyciem.

## 🔀 Tryby (przełącznik sprzętowy)
- **Share ETH (Router/AP)** — RJ45 jako WAN, urządzenie robi NAT i DHCP. Używaj tylko gdy chcesz własną podsieć i podwójny NAT.
- **Share Hotspot (WISP/Client)** — Wi-Fi jako WAN, NAT do RJ45/Wi-Fi. To był scenariusz hotspot→WAN.
- **AP / Range Extender / Client** — RJ45 jako uplink LAN (bez NAT, DHCP off), Wi-Fi w tej samej podsieci (Access Point).  
  - **Ten tryb wybierz dla GaryNet**: podłącz RJ45 z gniazdka GaryNet, ustaw statyczny IP/AP w podsieci GaryNet lub pobieraj z DHCP GaryNet, ustaw własny SSID/hasło, zostaw NAT wyłączony.

### Uwaga: AP bez linku LAN
- W trybie AP urządzenie może przestać nadawać SSID, jeśli nie widzi linku RJ45. Upewnij się, że uplink (GaryNet/ASUS) świeci diodę LAN/WAN.
- Jeśli SSID nadal się nie pojawia: wejdź w panel (przez kabel z laptopa, statyczne IP 192.168.0.x), włącz Wi-Fi/SSID ręcznie, zapisz i zrestartuj. Po zestawieniu linku LAN SSID powinien się pojawić.
- Tymczasowy obejściowy wariant: `Share ETH` + wyłącz DHCP/NAT w panelu (pseudo-AP), ale najlepiej trzymać czysty tryb AP gdy uplink działa.

## 🔗 Backlinki

- [[docs/infra/hardware/network/network]]
