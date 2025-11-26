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
title: "Zasilacz — GERC (Corsair PSU)"






owner: jakubc
---



# Zasilacz — GERC (Corsair PSU)

| Pole | Wartość |
| --- | --- |
| Producent | Corsair |
| Model | TODO (wykryto jako corsairpsu-hid) |
| Typ | Modular/Semi-modular (do weryfikacji) |
| Moc nominalna | 850W+ (szacunkowo na podstawie obciążenia) |
| Certyfikat | TODO (prawdopodobnie 80+ Gold/Platinum) |
| Interface | USB HID (monitoring przez sensors) |

## Monitoring w czasie rzeczywistym (sensors)

### Napięcia
| Linia | Wartość aktualna | Min | Max | Status |
| --- | --- | --- | --- | --- |
| **V_in** (wejście) | 230.00 V | - | - | ✅ OK |
| **V_out +12V** | 12.16 V | 8.41 V (crit min) | 15.59 V (crit max) | ✅ OK |
| **V_out +5V** | 4.98 V | 3.50 V (crit min) | 6.50 V (crit max) | ✅ OK |
| **V_out +3.3V** | 3.28 V | 2.31 V (crit min) | 4.30 V (crit max) | ✅ OK |

### Pobór mocy (aktualny snapshot)
| Linia | Moc | Prąd | Max prąd |
| --- | --- | --- | --- |
| **Total Power** | 210.00 W | - | - |
| **+12V** | 182.00 W | 15.25 A | 75.00 A (crit max) |
| **+5V** | 21.00 W | 4.25 A | 40.00 A (crit max) |
| **+3.3V** | 7.00 W | 2.19 A | 40.00 A (crit max) |

### Temperatury
| Sensor | Wartość | Krytyczna |
| --- | --- | --- |
| **VRM temp** | 41.5°C | 70.0°C |
| **Case temp** | 30.2°C | 70.0°C |

### Wentylator PSU
| Parametr | Wartość |
| --- | --- |
| **PSU Fan** | 0 RPM (tryb fanless/semi-passive) |

## Analiza obciążenia
> [!info] Snapshot poboru mocy (idle/light load)
> - **Total:** 210W
> - **Dominacja +12V:** 182W (86.7% całkowitego poboru)
> - **Dual GPU GTX 980 Ti:** ~100-120W w idle razem
> - **CPU i7-5960X:** ~50-70W w idle
> - **Pozostałe:** dyski, RAM, płyta ~30-40W
>
> **Peak load (szacunkowo):**
> - Dual GTX 980 Ti full load: ~500W (2 × 250W)
> - CPU i7-5960X full load: ~140W
> - Pozostałe: ~50W
> - **Total peak:** ~700W → potrzebny PSU 850W+ (z marginesem)

## Model zasilacza (do weryfikacji)
> [!hint] Prawdopodobne modele Corsair z USB HID monitoring
> Corsair oferuje monitoring HID w seriach:
> - **HX Series** (80+ Platinum) - 850W, 1000W, 1200W
> - **AX Series** (80+ Titanium) - 860W, 1000W, 1200W, 1600W
> - **RM Series** (80+ Gold) - 850W, 1000W
>
> Na podstawie temperatury VRM (~41°C) i trybu fanless → prawdopodobnie **HX850** lub **AX860**.

## Zadania
- [ ] @karinam otworzyć obudowę i sprawdzić dokładny model zasilacza (etykieta).
- [ ] @karinam dodać numer seryjny i datę zakupu.
- [ ] @karinam sprawdzić czy PSU ma tryb ECO/fanless i do jakiego progu obciążenia.
- [ ] @karinam zanotować pełne obciążenie (stress test dual GPU + CPU) i porównać z mocą nominalną.
- [ ] @karinam dodać testy napięć (multimetr) dla weryfikacji dokładności HID.
- [ ] @karinam sprawdzić historię serwisu (wymiana wentylatora, czyszczenie).
- [ ] @karinam dodać kable modular (jakie są używane, jakie zapasowe).
