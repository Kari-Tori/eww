---
version: 0.0.1
tags:
  - #GERC
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "Obudowa — index"






owner: jakubc
---



# Obudowa — index

Obudowa wraz z wentylatorami i chłodzeniem ma własny podfolder. Każdy panel lub zestaw komponentów opisujemy oddzielnie.

## Podsekcje
- [Obudowa (chassis)](case-chassis.md)
- [Wentylatory obudowy](case-fans.md)
- [Chłodzenie CPU](case-cpu-cooler.md)
- [Wentylatory CPU](case-cpu-fans.md)

## Monitoring temperatur (sensors)

### CPU (coretemp)
- **Package:** 53.0°C (high: 87°C, crit: 105°C)
- **Core 0-7:** 45-51°C (średnio ~47°C)

### VRM/Case temps (PSU sensors)
- **VRM temp:** 41.5°C (crit: 70°C)
- **Case temp:** 30.2°C (crit: 70°C)

### NVMe
- **nvme0n1:** 42.9°C (Composite)

## Zadania
- [ ] @karinam uzupełnić nazwę i model obudowy.
- [ ] @karinam sprawdzić listę wszystkich wentylatorów (ilość, rozmiary, RPM).
- [ ] @karinam opisać konfigurację airflow (intake/exhaust, positive/negative pressure).
- [ ] @karinam dodać profil wentylatorów (Fan Expert 3 curves).
- [ ] @karinam zanotować poziom hałasu (dB) w idle i load.

## 🔗 Backlinks

- [[docs/infra/hardware/workstations/gerc/case/case]]
- [[docs/docs]]
- [[INDEX]]