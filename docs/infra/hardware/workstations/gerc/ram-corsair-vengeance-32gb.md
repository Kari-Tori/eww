---
version: 0.0.1
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "RAM — GERC"






owner: jakubc
---



# RAM — GERC

| Pole | Wartość |
| --- | --- |
| Łączna pojemność | 32 GB (4 × 8 GB, wolne 4 sloty) |
| Typ | DDR4 |
| Konfiguracja | 4 × 8 GB (DIMM_A1, DIMM_B1, DIMM_C1, DIMM_D1) |
| Producent | Corsair |
| Model/Seria | Corsair Vengeance LPX CMK32GX4M4A2666C16 |
| Part Number | CMK32GX4M4A2666C16 |
| Taktowanie (SPD) | 2400 MT/s |
| Taktowanie (XMP/Configured) | 2448 MT/s (2666 MHz z profilu) |
| Pojemność pojedynczego modułu | 8 GB |
| Architektura | Quad-channel DDR4 (4 kanały aktywne) |
| Data Width | 72 bits (z ECC support) |
| Total Width | 72 bits |
| Dostępne sloty | 4 wolne (DIMM_A2, DIMM_B2, DIMM_C2, DIMM_D2) |
| Maksymalna pojemność | 128 GB (8 × 16 GB) |

## Obsadzenie slotów (Bank NODE 1)

| Slot | Status | Size | Manufacturer | Part Number | Speed |
| --- | --- | --- | --- | --- | --- |
| DIMM_A1 | ✅ Installed | 8 GB | Corsair | CMK32GX4M4A2666C16 | 2400 MT/s → 2448 MT/s |
| DIMM_A2 | ⬜ Empty | - | - | - | - |
| DIMM_B1 | ✅ Installed | 8 GB | Corsair | CMK32GX4M4A2666C16 | 2400 MT/s → 2448 MT/s |
| DIMM_B2 | ⬜ Empty | - | - | - | - |
| DIMM_C1 | ✅ Installed | 8 GB | Corsair | CMK32GX4M4A2666C16 | 2400 MT/s → 2448 MT/s |
| DIMM_C2 | ⬜ Empty | - | - | - | - |
| DIMM_D1 | ✅ Installed | 8 GB | Corsair | CMK32GX4M4A2666C16 | 2400 MT/s → 2448 MT/s |
| DIMM_D2 | ⬜ Empty | - | - | - | - |

## Podsumowanie systemu
```
Total memory: 32 GiB
Used: 7.2 GiB
Free: 19 GiB
Shared: 124 MiB
Buffer/cache: 5.5 GiB
Available: 24 GiB
Swap: 511 MiB (not used)
```

## O module Corsair Vengeance LPX
> [!info] Corsair Vengeance LPX CMK32GX4M4A2666C16
> - Seria: Vengeance LPX (Low Profile eXtreme)
> - Kit: 4 × 8 GB (32 GB total)
> - XMP Profile: 2666 MHz (aktualnie 2448 MT/s configured)
> - ECC: Obsługa 72-bit (z płytą X99)
> - Radiatory: Czarne, low-profile aluminium
> - Przeznaczenie: Overclocking, compact builds, workstation

## Zadania
- [ ] @karinam potwierdzić dokładne timingi (CL, tRCD, tRP, tRAS) w BIOS.
- [ ] @karinam dodać datę ostatniego testu pamięci (memtest86+) + wynik.
- [ ] @karinam sprawdzić możliwość rozbudowy do 64 GB (4 × 16 GB dodatkowe).
- [ ] @karinam zweryfikować profil XMP i napięcia DRAM (powinno być 1.2V standard, 1.35V XMP).
- [ ] @karinam dodać benchmark (AIDA64 Memory, PassMark) dla porównania wydajności.

## 🔗 Backlinks

- [[docs/infra/hardware/workstations/gerc/gerc]]
- [[docs/docs]]
- [[INDEX]]