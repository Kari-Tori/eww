---
tags:
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #secondbrain
  - #star-wars
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "🧱 Hardware"






owner: jakubc
---



# 🧱 Hardware

Folder `docs/infra/hardware/` zawiera katalogi per asset oraz ten indeks. Każde urządzenie otrzymuje własny folder z notką indeksową (`folder note`) i plikami komponentów (np. `cpu-intel-i7-3770k.md`, `gpu-nvidia-gtx1660ti.md`, `ram-corsair-vengeance-16gb.md`).

## 📋 Zasady
- Jeden folder = jeden asset (np. `asus_z77/`), w środku plik `asus_z77.md` jako indeks.
- Standardowy frontmatter: `title`, `role`, `location`, `created`, `updated`.
- Komponenty opisujemy w osobnych plikach nazwanych po modelu (`cpu-intel-…`, `gpu-nvidia-…`, `storage-…` itd.).
- [ ] @karinam sprawdzić, czy każda karta sprzętu ma aktualne dane (daty, numery seryjne, logi serwisowe).

## 🖥️ Workstations

| ID | Nazwa | Rola | Plik |
| --- | --- | --- | --- |
| `asus_z77` | Asus Z77 workstation | Jednostka główna Kariny | [workstations/asus_z77/asus_z77.md](workstations/asus_z77/asus_z77.md) |
| `gerc` | Asus X99 Pro (GERC) | Węzeł obliczeniowy / workstation | [workstations/gerc/gerc.md](workstations/gerc/gerc.md) |
| `lenovo_y700` | Lenovo Y700 laptop | Mobilny workstation/diagnostyka | [laptops/lenovo_y700/lenovo_y700.md](laptops/lenovo_y700/lenovo_y700.md) |
| `lenovo_m710q` | Lenovo M710q Tiny | Mikroserwer / edge node | [workstations/lenovo_m710q/lenovo_m710q.md](workstations/lenovo_m710q/lenovo_m710q.md) |
| `dell_t140` | Dell PowerEdge T140 | Serwer tower (storage/kontenery) | [workstations/dell_t140/dell_t140.md](workstations/dell_t140/dell_t140.md) |
| `dell_inspirion-3881` | Dell Inspiron 3881 | Lekka stacja robocza | [workstations/dell_inspirion-3881/dell_inspirion-3881.md](workstations/dell_inspirion-3881/dell_inspirion-3881.md) |
| `cisco-3650-catalyst-poe-24` | Cisco Catalyst 3650-24P PoE | Core switch + PoE | [cisco-3650-catalyst-poe-24/README.md](cisco-3650-catalyst-poe-24/README.md) |
| `netgear_fs108` | Netgear FS108 | Switch dev | [netgear_fs108/netgear_fs108.md](netgear_fs108/netgear_fs108.md) |
| `mobile_devices` | Flota iPhone hotspot | Mobilne źródła internetu | [mobile/phones/README.md](mobile/phones/README.md) |
| `media_tv` | Telewizory (3×) | Media/wyświetlacze | [media_tv/media_tv.md](media_tv/media_tv.md) |
| `media_amplituner` | Amplituner audio | Audio hub | [media_amplituner/media_amplituner.md](media_amplituner/media_amplituner.md) |
| `media_soundbar` | Soundbar | Audio (planowane) | [media_soundbar/media_soundbar.md](media_soundbar/media_soundbar.md) |
| `kitchen_touchscreen` | Panel dotykowy kuchnia | Media/sterowanie (plan) | [kitchen_touchscreen/kitchen_touchscreen.md](kitchen_touchscreen/kitchen_touchscreen.md) |

Dodając nowe urządzenia, utwórz folder `ID/`, plik indeksowy `ID/ID.md` oraz podnotki komponentów; następnie dopisz wpis do powyższej tabeli.

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

- [workstations/asus_z77/](workstations/asus_z77/asus_z77.md)
- [workstations/gerc/](workstations/gerc/gerc.md)
- [laptops/lenovo_y700/](laptops/lenovo_y700/lenovo_y700.md)
- [workstations/lenovo_m710q/](workstations/lenovo_m710q/lenovo_m710q.md)
- [workstations/dell_t140/](workstations/dell_t140/dell_t140.md)
- [workstations/dell_inspirion-3881/](workstations/dell_inspirion-3881/dell_inspirion-3881.md)
- [netgear_fs108/](netgear_fs108/netgear_fs108.md)
- [mobile_devices/](mobile_devices/mobile_devices.md)
- [media_tv/](media_tv/media_tv.md)
- [media_amplituner/](media_amplituner/media_amplituner.md)
- [media_soundbar/](media_soundbar/media_soundbar.md)
- [kitchen_touchscreen/](kitchen_touchscreen/kitchen_touchscreen.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]
