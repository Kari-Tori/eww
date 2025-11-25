---
title: M18 — co dalej (decyzje + komponenty)
created: 2025-11-16
updated: 2025-11-16
lang: pl
tags:
  - follow-me
  - platform
  - bom
links:
  - [[usr/jakubc/m18.md]]
  - [[usr/jakubc/M18-FPOVCL-0.md]]
---

# 🔜 M18 NEXT — decyzje do podjęcia i komponenty

> [!summary|icon:compass|color:#F94144]
> **EWW vibe:** kolorowe bloki, krótkie checklisty, ceny w GBP. Notatka scala „co zdecydować” oraz „co kupić / odzyskać” dla platformy follow-me transportującej odkurzacz M18 + kosz warsztatowy.

## ✅ 1. Decyzje „must”

| Decyzja | Opcje (parametry) | Notatka |
| --- | --- | --- |
| Architektura sterowania | `MCU-only (ESP32, loop ≤1 ms)` • `MCU+SBC (ESP32 + Pi Zero 2 W / Pi 4)` | **MCU+SBC** = safety + headroom na SLAM. |
| Napęd jezdny | `Brushed DC + enkodery` • `BLDC + ESC (VESC)` • `Planetary gear (all-in-one)` | Zacznij od brushed DC, potem upgrade. |
| Masa ładunku | `8 kg`, `10 kg`, `12 kg+` | Większa masa → mocniejsze silniki + HO battery. |
| Prędkość maks. | `0.3 m/s`, `0.4 m/s`, `0.6 m/s` | Zapisuj w BOM + test planie. |
| Materiał mountu | `PETG 50% infill` • `ABS 45%` • `PLA 40% (proto)` | PETG = standard EWW, PLA tylko na stoły testowe. |
| Źródło zasilania | `M18 5 Ah` • `M18 HO 8 Ah` • `Dual M18 + booster` | Dual M18 = równoległa praca ruch + ssanie.

> [!tip|icon:checklist|color:#577590]
> Potwierdzenie powyższych punktów → pozwoli wygenerować dokładny BOM i rozpocząć druk mountu.

## 🧩 2. Architektura sterowania (warstwy)

> [!info|icon:cpu|color:#4895EF]
> - **MCU (ESP32/STM32G4):** PWM → silniki, enkodery, watchdog, monitor napięcia (ADC @1 kHz).  
> - **SBC (Pi Zero 2 W / Pi 4)**: SLAM + follow-me (OpenCV, BLE RSSI, LiDAR fusion).  
> - **Interfejs:** UART 1 Mbps + CRC; fallback BLE (ESP-NOW).  
> - **Telefon jako alternatywa:** tylko warstwa wizji – i tak potrzebny MCU hardware safety.

## ⚙️ 3. Napęd i mechanika

> [!tip|icon:gear|color:#90BE6D]
> - **Silniki:** 12–18 V DC gearmotor, przełożenie ~1:30–1:50 dla 0.4 m/s; enkoder ≥600 PPR.  
> - **Struktura:** stalowe/alu płaskowniki + mount PACKOUT (PETG 50% infill, warstwa 0,25 mm).  
> - **Koła:** Ø120–150 mm (guma), caster podporowy Ø80 mm z hamulcem.  
> - **Wzmocnienia:** listwy i śruby M6 w punktach kontaktu z koszem/odkurzaczem.  
> - **Log mechaniczny:** po każdej iteracji zapisać nośność i defleksję w `hw/tests.md`.

## 🔌 4. Zasilanie

> [!warning|icon:battery|color:#F8961E]
> - **Główne źródło:** ogniwa M18 (5 Ah / HO 8 Ah) – umożliwia 18 V/20 A.  
> - **DC/DC:**  
>   • 18→5 V @5 A (SBC + peryferia).  
>   • 18→3.3 V @1 A (MCU, IMU, LiDAR logic).  
>   • Filtr LC na linii drivera (redukcja zakłóceń).  
> - **Safety:** bezpiecznik 30 A, ręczny odłącznik, E‑STOP wpięty przed driverami.  
> - **Telemetria:** pomiar prądu (INA219) + napięcie (dzielnik, oversampling).

## 👀 5. Sensory — MVP → rozbudowa

> [!example|icon:radar|color:#48CAE4]
> - **MVP:** enkodery, 3× HC-SR04 (przód/45°), 4× IR cliff, MPU6050.  
> - **Upgrade:** LiDAR (RPLIDAR A1), BLE/UWB tagi follow-me, radar mmWave (TI IWR6843) dla kurzu/pyłu.  
> - **Montaż:** sensory w wydrukowanych koszach mocowanych do mountu PACKOUT (otwory M3).

## 🧾 6. Proponowane komponenty (nowe / używane UK)

| Kategorie | Nowe | Używane / GBP koszyk |
| --- | --- | --- |
| Driver silników | [VNH5019 Pololu](https://www.pololu.com/product/1451) | [eBay UK – VNH5019 used](https://www.ebay.co.uk/sch/i.html?_nkw=vnh5019+used) |
| Driver alternatywa | [Sabertooth 2x12](https://www.dimensionengineering.com/products/sabertooth2x12) | [eBay UK – Sabertooth](https://www.ebay.co.uk/sch/i.html?_nkw=sabertooth+2x12) |
| MCU | [ESP32 devkit](https://www.espressif.com/en/products/modules/esp32) | [Marketplace UK bundle](https://www.ebay.co.uk/sch/i.html?_nkw=esp32+devkit+used) |
| SBC | [Raspberry Pi Zero 2 W](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/) | [CEX UK Pi boards](https://uk.webuy.com/search?stext=raspberry%20pi%20zero%202) |
| Sensory | [HC-SR04 (SparkFun)](https://www.sparkfun.com/products/15569) | [HC-SR04 lot (GBP)](https://www.ebay.co.uk/sch/i.html?_nkw=hc-sr04) |
| IMU | [MPU6050](https://www.sparkfun.com/products/11028) | [MPU6050 used kits](https://www.ebay.co.uk/sch/i.html?_nkw=mpu6050) |
| LiDAR | [RPLIDAR A1](https://www.slamtec.com/en/Lidar/A1) | [LiDAR refurb (GBP)](https://www.ebay.co.uk/sch/i.html?_nkw=rplidar+a1) |
| Filament / montaż | [PETG Prusament](https://www.prusa3d.com/prusament/) | [PETG spool surplus](https://www.ebay.co.uk/sch/i.html?_nkw=petg+filament+used) |
| Odkurzacz bazowy | [Howe Tools, £215](https://www.howetools.co.uk/m18-packout-wet-dry-vacuum-l-class-body-only-m18-fpovcl-0) | [eBay UK M18 PACKOUT used](https://www.ebay.co.uk/sch/i.html?_nkw=milwaukee+m18+packout+vacuum) |

> [!note|icon:recycle|color:#52B788]
> **Reuse / DIY salvage:**  
> - Motor + enkoder: demontaż robotów przemysłowych lub wózków AGV (często £60–£80 para).  
> - Drivery VNH/Sabertooth: sprawdź oferty „spares/repair” – często wymagają tylko wymiany kondensatorów.  
> - Filament/śruby: końcówki szpul i odzyskane wkładki (po regeneracji gwintu).  
> - Przy zakupach z rynku wtórnego przewiduj 10–15 % budżetu na wymianę części wadliwych.

> [!note|icon:info|color:#FFD166]
> Linki prowadzą do UK/UE dostawców; przy zakupach spoza UK dolicz VAT/import w `hw/BOM.md`.

## 💰 7. Orientacyjny koszt (UK)

| Pozycja | GBP (nowe UK) | GBP (rynek wtórny) |
| --- | --- | --- |
| Napęd jezdny (2× DC gearmotor) | £180–£320 | £120–£220 (demontaż robotów) |
| Driver silników | £70–£150 | £40–£120 |
| MCU ESP32 | £18–£35 | £15–£30 |
| SBC (opcjonalnie) | £30–£70 | £25–£60 |
| Sensory (HC-SR04, IR, IMU) | £40–£80 | £20–£40 (loty) |
| LiDAR (opcjonalnie) | £220–£320 | £120–£250 (refurb) |
| Materiały mechaniczne (PETG, insert M4) | £35–£90 | £30–£80 |
| Misc (kable, bezpieczniki, złącza) | £25–£60 | £20–£50 |

> [!success|icon:balance-scale|color:#2EC4B6]
> - **POC (nowe części UK):** ~£350–£650.  
> - **POC (mix używanych/GB):** ~£250–£450.  
> - **Konfiguracja LIDAR/AI:** ~£550–£900 (zależnie od LiDAR + SBC).

## 🧪 8. Testy i walidacja

> [!info|icon:flask|color:#8338EC]
> - **Mechanika:** nośność 5–10 kg, test wstrząsów (drop 5 cm), wibracje z odkurzaczem.  
> - **Elektronika:** prąd rozruchowy, test termiczny driverów + E‑STOP (<50 ms).  
> - **Follow-me POC:** różne podłoża (beton, OSB), log zużycia energii (`scripts/m18-power-test.sh`).

## 📝 9. TODO / checklist

> [!check|icon:tasks|color:#7209B7]
> 1. Potwierdź architekturę (MCU-only vs MCU+SBC).  
> 2. Zdefiniuj masę/prędkość → dobór silników + driver.  
> 3. Uzupełnij `hw/BOM.md` o konkretne modele i alternatywy (nowe/używane).  
> 4. Start projektu mountu (`hw/packout_mount.scad`) + wydruk PETG (test).  
> 5. Zaprojektuj protokół UART (komendy + CRC) + szkic firmware ESP32.  
> 6. Zaplanuj scenariusze testów terenowych i log energii (koszt GBP).
