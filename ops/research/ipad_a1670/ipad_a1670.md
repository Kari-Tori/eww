---
tags:
  - #folder_note
  - #research
  - #device/ipad/a1670
  - #eww
created: 2025-11-27T17:45:16Z
modified: 2025-11-27T18:05:00Z
author: karinam
title: "iPad A1670 – research"
owner: karinam
status: "informacje modelowe"
links:
  intake: "[[repair/intake/records/ipad-2025-11-27/ipad-2025-11-27]]"
  repair: "Odoo (moduł napraw) – wymiana gniazda ładowania"
---

# 🧭 iPad A1670 – research

Repo informacji o modelu (rok, specyfikacja, diagramy). Przypadki serwisowe linkujemy poniżej.

## 🔗 Zakres

- Informacje ogólne o modelu (spec, diagramy, typowe usterki).
- Przypadki serwisowe: [[repair/intake/records/ipad-2025-11-27/ipad-2025-11-27|karta przyjęcia]] (ten egzemplarz trafił od razu do modułu napraw w Odoo).

## 🧱 Profil modelu / dane bazowe

- **Nazwa:** iPad Pro 12.9" (2nd gen), model A1670 (Wi‑Fi)
- **Rok:** 2017 (potwierdź numerem seryjnym)
- **SoC:** Apple A10X Fusion + M10
- **RAM:** 4 GB
- **Storage:** 64 / 256 / 512 GB (wariant do ustalenia)
- **Ekran:** 12.9", 2732×2048, 120 Hz (ProMotion)
- **Bateria:** ok. 41 Wh (10875 mAh) – do weryfikacji
- **Porty:** Lightning, Smart Connector; audio jack brak
- **Łączność:** Wi‑Fi 802.11ac, Bluetooth 4.2
- **OS:** iPadOS (wsparcie zależne od wersji)

## 🔌 Naprawa gniazda ładowania (Lightning)

- Typowa przyczyna: zużycie mechaniczne/wygięte piny; zabrudzenie rzadziej.
- Zalecenie: **wymiana całego modułu/taśmy z gniazdem** (bezpieczniejsze niż mikrolutowanie pinów).
- Mikrolutowanie: tylko gdy brak części; wymaga hot-air, osłon termicznych, czyszczenia padów i testu pod mikroskopem.
- Po wymianie: test ładowania (prąd/napięcie), stabilność mechaniczna portu, enumeracja USB.

## 📎 Diagramy / manuale / załączniki

- TODO: dodać schemat blokowy/portów (Lightning, Smart Connector).
- TODO: dodać manual serwisowy lub guide do wymiany gniazda.
- TODO: zdjęcia PCB i okolicy gniazda po otwarciu (link do assetów).
- Części: [[research/ipad_a1670/parts/parts|lista części]] (moduł gniazda w kartach części).

## 🛠️ Znane usterki / uwagi serwisowe

- Gniazdo Lightning: mechaniczne zużycie, odgięte piny.
- Przy demontażu: uważać na taśmy digitizera i czujniki; podgrzewanie krawędzi.
- Po wymianie gniazda: test ładowania, enumeracja USB, stabilność mechaniczna portu.

## ✅ Checklista pomiarów (opcjonalna diagnostyka)

- [ ] Test ładowania po wymianie modułu (prąd/napięcie).
- [ ] Inspekcja wizualna PCB w okolicy gniazda.
- [ ] Test portu USB (stabilność mechaniczna po wymianie).
