---
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T00:00:00Z
author: jakubc
title: "CPU — GERC"






owner: jakubc
---



# CPU — GERC

| Pole | Wartość |
| --- | --- |
| Model | Intel Core i7-5960X @ 3.00GHz |
| Generacja | Haswell-E (2014) |
| Socket | LGA2011-v3 |
| Rdzenie / wątki | 8 / 16 |
| Bazowe taktowanie | 3,00 GHz |
| Turbo Boost | 3,90 GHz |
| TDP | 140W |
| Architektura | x86_64 (64-bit) |
| Pamięć cache L1d | 256 KiB (8 × 32 KiB) |
| Pamięć cache L1i | 256 KiB (8 × 32 KiB) |
| Pamięć cache L2 | 2 MiB (8 × 256 KiB) |
| Pamięć cache L3 | 20 MiB (shared) |
| Technologie | HT, Turbo Boost 2.0, VT-x, VT-d, AES-NI, AVX2 |
| BogoMIPS | 6120.62 |

## Stan aktualny
- **Temperatura Package:** ~53°C (idle/light load)
- **Temperatury rdzeni:** 45-51°C
- **Temperatura max (high):** 87°C
- **Temperatura krytyczna:** 105°C
- **CPU scaling:** ~46% (dynamiczne skalowanie)
- **CPU min/max MHz:** 1200 / 3900 MHz

## Znaczenie historyczne i odbiór

> [!note] Kontekst 2014
> - i7-5960X to flagowy procesor Haswell-E dla entuzjastów, pierwsz 8-rdzeniowy Intel Core dla desktopów.
> - Wprowadził platformę LGA2011-v3 z obsługą DDR4 i 40 linii PCIe 3.0.
> - Cena premierowa: ~$999 USD (segment HEDT - High-End Desktop).

> [!quote] Odbiór w mediach i wśród użytkowników
> - AnandTech i Tom's Hardware chwaliły surową moc wielowątkową i potencjał OC (często do 4.4-4.5 GHz).
> - Krytykowano wysoką cenę i wymagania termiczne (chłodzenie wodne/tower premium).
> - Stał się legendą w rendering/video editing, 3D modeling i pierwszych workloadach AI/ML.

## Dzisiejsze zastosowania (2025)
> [!success] Reuse w 2025
> - Nadal wydajny do Docker/containerów, kompilacji, home lab, małych obciążeń AI.
> - 8c/16t + 20MB cache + DDR4 dają znacznie lepszą wydajność niż starsze 4c/8t Z77.
> - Platforma X99 wspiera więcej dysków, GPU (SLI/CrossFire), rozszerzalność PCIe.

## Prekursor, następca, rywal

| Rola | Model | Platforma | Rok | Notatka |
| --- | --- | --- | --- | --- |
| 🔁 Prekursor | i7-4960X | LGA2011 (Ivy Bridge-E) | 2013 | 6c/12t, poprzednia generacja HEDT |
| 🔄 Następca | i7-6950X | LGA2011-v3 (Broadwell-E) | 2016 | 10c/20t, kolejna generacja HEDT (droższy) |
| ⚔️ Rywal AMD | AMD Ryzen 7 1800X | AM4 | 2017 | 8c/16t, znacznie tańszy, nowsza architektura Zen |

## Chłodzenie
Zobacz: [Chłodzenie CPU](case/case-cpu-cooler.md)

## Zadania
- [ ] @karinam sprawdzić aktualny profil Turbo Boost (czy wszystkie rdzenie osiągają 3.9 GHz)
- [ ] @karinam dodać historię overclockingu (jeśli był) i napięcia VCore
- [ ] @karinam zanotować procedurę wymiany pasty termicznej i ostatnią datę serwisu
- [ ] @karinam dodać testy wydajności (Geekbench, Cinebench, PassMark)
