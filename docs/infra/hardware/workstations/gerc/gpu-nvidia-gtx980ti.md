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
title: "GPU — GERC (Dual GTX 980 Ti)"






owner: jakubc
---



# GPU — GERC (Dual GTX 980 Ti)

## Konfiguracja: 2× NVIDIA GeForce GTX 980 Ti

| Pole | Wartość |
| --- | --- |
| Model | NVIDIA GeForce GTX 980 Ti (2× w SLI/niezależne) |
| Rdzeń | GM200 (Maxwell 2.0) |
| Rewizja | rev a1 |
| Pamięć VRAM | 6144 MiB (6 GB GDDR5) na kartę = 12 GB total |
| Sterownik | NVIDIA 575.64.03 (proprietary) |
| Slot PCIe | GPU1: 01:00.0, GPU2: 02:00.0 |
| Tryb pracy | Niezależne lub SLI (do skonfigurowania) |

## Szczegóły GPU1 (01:00.0)
- **Nazwa:** NVIDIA GeForce GTX 980 Ti
- **VRAM:** 6144 MiB
- **Sterownik:** 575.64.03
- **Slot PCIe:** 01:00.0 (PCIe 3.0 x16)

## Szczegóły GPU2 (02:00.0)
- **Nazwa:** NVIDIA GeForce GTX 980 Ti
- **VRAM:** 6144 MiB
- **Sterownik:** 575.64.03
- **Slot PCIe:** 02:00.0 (PCIe 3.0 x16)

## Informacje o GPU NVIDIA GeForce GTX 980 Ti

> [!note] Kontekst 2015
> - GTX 980 Ti to flagowa karta Maxwell przed erą Pascal (GTX 1080).
> - Rdzeń GM200 (ten sam co w Titan X, ale z cut-down).
> - Specyfikacja: 2816 CUDA cores, 6 GB GDDR5, 384-bit memory bus.
> - Cena premierowa: ~$649 USD (segment high-end gaming/workstation).
> - TDP: 250W na kartę.

> [!quote] Odbiór w mediach i wśród użytkowników
> - AnandTech, Tom's Hardware: "najlepsza karta do 4K gaming w 2015".
> - Świetny stosunek cena/wydajność vs Titan X.
> - Nadal popularna w 2025 do 1080p/1440p gaming, rendering, CUDA workloads.

## Dzisiejsze zastosowania (2025)
> [!success] Dual GPU w 2025
> - **Gaming:** 1080p Ultra/1440p High nadal płynne w większości gier.
> - **CUDA:** rendering (Blender Cycles), video encoding (DaVinci Resolve), AI inference (starsze modele).
> - **Multi-display:** dual GPU = więcej portów display, niezależne outputy.
> - **Pasywne PCIe:** jedna karta może być dedykowana do obliczeń (headless).

## Prekursor, następca, rywal

| Rola | Model | Architektura | Rok | Notatka |
| --- | --- | --- | --- | --- |
| 🔁 Prekursor | GTX 780 Ti | Kepler GK110 | 2013 | poprzednia flagowa Maxwell 1.0 |
| 🔄 Następca | GTX 1080 Ti | Pascal GP102 | 2017 | 11 GB GDDR5X, znacznie szybsza |
| ⚔️ Rywal AMD | AMD R9 Fury X | Fiji XT | 2015 | 4 GB HBM, konkurencja w high-end |

## Konfiguracja software
- **Driver:** NVIDIA proprietary 575.64.03
- **CUDA:** (sprawdzić `nvcc --version` lub `/usr/local/cuda/version.txt`)
- **OpenCL:** wspierane
- **Display manager:** Wayland/X11 (KWin/Plasma)
- **Power management:** (sprawdzić `nvidia-smi -q -d PERFORMANCE`)

## Monitoring
```bash
# Temperatura, fan speed, power draw
nvidia-smi

# Szczegółowe info
nvidia-smi -q

# Tylko temperatury
nvidia-smi --query-gpu=temperature.gpu --format=csv
```

## Zadania
- [ ] @karinam sprawdzić czy karty są w trybie SLI czy niezależne (nvidia-settings).
- [ ] @karinam zanotować temperatury w idle i pod obciążeniem (furmark, stress test).
- [ ] @karinam dodać profile wentylatorów (czy automatyczne czy custom curve).
- [ ] @karinam sprawdzić power limit i TDP target (domyślnie 250W, czy jest OC).
- [ ] @karinam dodać benchmarki (3DMark, Unigine Heaven/Valley, GPU render test).
- [ ] @karinam opisać wyświetlacze podłączone do każdej karty (monitor setup).
- [ ] @karinam sprawdzić wersję CUDA i cuDNN (jeśli używane do ML/AI).
