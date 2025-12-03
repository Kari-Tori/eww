---
created: 2025-11-22T17:18:00Z
modified: 2025-12-01T21:15:00Z
tags:
  - #folder_note
  - #router
  - #dsl
title: "ASUS DSL-N16"
---

# ASUS DSL-N16 — gateway legacy (192.168.0.10)

## 📌 Parametry
- IP: `192.168.0.10`
- MAC: `88:d7:f6:63:40:b8`
- Interfejs WWW: `http://192.168.0.10`
- Login: `admin / admin` (zmienić po migracji)
- Status: awaryjny gateway (WAN z Y700/TL-WR902AC), DSL port obecnie niewpięty.

## 🌐 Rola w topologii
- NAT/Firewall dla podsieci `192.168.0.0/24` (dopóki nie zastąpi go router dual-WAN).
- WAN z Lenovo Y700 (Wi-Fi hotspot) lub TL-WR902AC (WISP) → port WAN/RJ45.
- Docelowo wypięty, gdy router dual-WAN przejmie rolę gateway’a.

## 🧪 Problemy historyczne
- 2025-11-22: brak internetu na `asus_z77` mimo działającego LAN; winny klient Cloudflare WARP na hosta (tunel blokował ruch). Po `warp-cli disconnect` + `systemctl stop warp-svc` internet wraca.
- Router był resetowany soft + restart WAN, bez efektu dla z77 (problem hosta).

## 📁 Podfoldery

- [[config]]
- [[docs]]
- [[logs]]

## 📄 Pliki w tym folderze

*Brak plików markdown w tym folderze.*

## 🔗 Backlinki

- [[devices]]
