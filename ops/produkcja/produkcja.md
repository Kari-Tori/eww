---
title: PRODUKCJA - Wytwarzanie produktów z surowców wtórnych
description: Dokumentacja modułu produkcyjnego - ekstruzja, wtrysk, odlewanie, druk 3D
version: 0.0.0.1
audience: operations
type: operations
category: production
tags:
  - produkcja
  - manufacturing
  - ekstruzja
  - wtrysk
  - odlewanie
  - druk-3d
  - filament
language: pl
created: 2025-11-28
updated: 2025-11-28
---

# PRODUKCJA - Wytwarzanie produktów z surowców wtórnych

## Misja

**PRODUKCJA** to moduł wytwarzania gotowych produktów z **czystych surowców wtórnych** pochodzących z modułu RECYCLE.

### Cel główny

Przekształcanie czystego surowca (1kg kruszonego plastiku, 100g miedzi) w **gotowe produkty** o wyższej wartości rynkowej.

## Źródło surowców

### SUROWCE WTÓRNE - Magazyn

Wszystkie surowce pochodzą z modułu **RECYCLE**:

- 📏 **1kg kruszonego plastiku** (ABS, PC, PLA) - worki foliowe
- 🔩 **1kg metalu** (Cu, Al, Fe) - worki z kawałkami
- 💎 **10g złota / 50g srebra** (99%) - woreczki
- 🏺 **1kg proszku szklanego** (frakcje) - worki

## Procesy produkcyjne

### 1. Ekstruzja filamentu 3D

**Cel:** Produkcja szpul filamentu do druku 3D

#### Wejście
- 1kg kruszonego plastiku ABS/PLA (z RECYCLE)

#### Proces
1. **Podgrzanie:** Plastik topiony w ekstruderze (190-220°C dla PLA)
2. **Ekstruzja:** Wydmuchiwanie przez dyszę (kontrola średnicy)
3. **Kalibracja:** Laser mierzy średnicę (1.75mm ±0.05mm lub 2.85mm ±0.10mm)
4. **Nawijanie:** Automatyczne nawijanie na szpulę
5. **Pakowanie:** Szpula w folii próżniowej + etykieta

#### Produkt końcowy
- **Szpula filamentu 1kg (1.75mm)** - gotowa do sprzedaży na eBay
- Etykieta: typ plastiku, kolor, średnica, data produkcji, batch number

#### Użycie
- Sprzedaż na eBay (główny kanał dla filamentu)
- Własny druk 3D (UPCYCLE, prototypy)

---

### 2. Wtrysk plastiku

**Cel:** Produkcja obudów, pokryw, części z plastiku

#### Wejście
- 1kg kruszonego plastiku ABS/PC (z RECYCLE)

#### Proces
1. **Topienie:** Plastik topiony w cylindrze wtryskowym
2. **Wtrysk:** Wtrysk do form aluminiowych (injection molding)
3. **Chłodzenie:** Chłodzenie formy (30-60 sekund)
4. **Wyjęcie:** Automatyczne/ręczne wyjęcie części
5. **Wykończenie:** Szlifowanie, obróbka, usunięcie nadlewów

#### Produkt końcowy
- **Obudowy do elektroniki** (custom cases)
- **Pokrywy, zatyczki, organizery**
- **Części zamienne** (uszy słuchawek, pokrywy baterii)

#### Użycie
- Sprzedaż jako części zamienne (eBay)
- UPCYCLE (montaż w nowych produktach)

---

### 3. Odlewanie metali

**Cel:** Produkcja prętów, przewodów, blach z metalu wtórnego

#### Wejście
- 1kg aluminium lub 100g miedzi (z RECYCLE)

#### Proces
1. **Topienie:** Metal topiony w piecu (660°C dla Al, 1085°C dla Cu)
2. **Odlewanie:** Wlewanie do form (ingots, wire molds)
3. **Chłodzenie:** Naturalnie lub w kąpieli wodnej
4. **Obróbka:** Cięcie, szlifowanie, kształtowanie
5. **Pakowanie:** Worki/pudełka z etykietą (typ metalu, masa, data)

#### Produkt końcowy
- **Pręty Al/Cu** (ingots 100g, 500g, 1kg)
- **Przewody miedziane** (custom length, grubość)
- **Kable** (lutowane, z izolacją)

#### Użycie
- Sprzedaż na eBay (surowce metalowe)
- UPCYCLE (spawanie, konstrukcje)
- Własna elektronika (lutowanie)

---

### 4. Druk 3D (produkcja obudów i części)

**Cel:** Drukowanie obudów, organizerów, części na zamówienie

#### Wejście
- Filament 3D 1.75mm (z własnej ekstruzji)

#### Proces
1. **Projektowanie CAD:** Fusion 360, OpenSCAD
2. **Slicing:** PrusaSlicer, Cura (generowanie G-code)
3. **Druk 3D:** FDM printer (PLA/ABS)
4. **Post-processing:** Szlifowanie, malowanie, lakierowanie
5. **Pakowanie:** Pudełko kartonowe + etykieta

#### Produkt końcowy
- **Obudowy Raspberry Pi** (custom designs)
- **Organizery na biurko** (modularne)
- **Części zamienne** (gałki, pokrywy, adaptery)

#### Użycie
- Sprzedaż na eBay/Etsy (unikalne obudowy)
- UPCYCLE (montaż w projektach)

---

### 5. Lutowanie i elektronika

**Cel:** Produkcja modułów elektronicznych, adapterów, kabli

#### Wejście
- PCB (prototypy, custom boards)
- Komponenty (z INTAKE/rozbiórki)
- Przewody miedziane (z odlewania)

#### Proces
1. **Projektowanie:** Eagle CAD, KiCad (schematy)
2. **Lutowanie:** Ręczne lutowanie komponentów
3. **Testowanie:** Multimetr, oscyloskop
4. **Pakowanie:** Antistatic bag + etykieta

#### Produkt końcowy
- **Adaptery USB** (USB-C, micro-USB, custom)
- **Przewody połączeniowe** (GPIO, jumper wires)
- **Moduły elektroniczne** (power supply, regulators)

#### Użycie
- Sprzedaż na eBay (elektronika DIY)
- UPCYCLE (montaż w projektach)

---

## Workflow PRODUKCJA

```
┌─────────────────────────────────────────────────────────────────┐
│                      MAGAZYN SUROWCÓW WTÓRNYCH                  │
│  • 1kg kruszonego plastiku ABS/PC/PLA (worki)                  │
│  • 1kg aluminium/miedzi (worki z kawałkami)                    │
│  • 10g złota/50g srebra (woreczki)                             │
│  • 1kg proszku szklanego (worki, frakcje)                      │
└────────────────────┬────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────────────┐
│                         PRODUKCJA                               │
│  1. Ekstruzja filamentu → Szpule 1kg (1.75mm)                  │
│  2. Wtrysk plastiku → Obudowy, pokrywy, części                 │
│  3. Odlewanie metali → Pręty, przewody, kable                  │
│  4. Druk 3D → Organizery, obudowy, części                      │
│  5. Lutowanie → Adaptery, moduły, przewody                     │
└────────────────────┬────────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────────────┐
│                     GOTOWE WYROBY                               │
│  • Szpule filamentu (pakowane, z etykietą)                     │
│  • Obudowy 3D printed (gotowe do sprzedaży)                    │
│  • Przewody i kable (custom length)                            │
│  • Adaptery USB (testowane)                                    │
│  • Elementy kompozytowe (epoxy + proszek szklany)             │
└────────────────────┬────────────────────────────────────────────┘
                     ↓
                   SALES
          ┌──────────┴──────────┐
          ↓                     ↓
        eBay                  Etsy
   (przemysłowe)         (unikalne)
```

## Produkty PRODUKCJA (katalog)

### Filament 3D
- **Szpula PLA 1kg (1.75mm)** - różne kolory (naturalne, czarny, biały)
- **Szpula ABS 1kg (1.75mm)** - czarny, biały
- **Szpula PETG 1kg (1.75mm)** - transparentny (jeśli dostępny surowiec)

### Obudowy i części
- **Obudowa Raspberry Pi 4** (różne warianty, z wentylatorem)
- **Organizery modularne** (na biurko, narzędzia, elektronikę)
- **Części zamienne** (gałki, pokrywy, adaptery)

### Metal i elektronika
- **Pręty Al/Cu** (100g, 500g, 1kg) - do spawania, konstrukcji
- **Przewody miedziane** (custom length, 0.5-2mm grubość)
- **Adaptery USB** (USB-C to micro-USB, USB-A to USB-C)

### Kompozyty
- **Płytki epoxy + proszek szklany** (custom boards, dekoracje)
- **Elementy kompozytowe** (wzmocnione włóknem szklanym)

## Kontrola jakości

### Standardy jakości

1. **Filament 3D:**
   - Średnica: 1.75mm ±0.05mm (kontrola laserowa)
   - Brak pęcherzy powietrza
   - Kolor jednolity

2. **Obudowy wtryskowe:**
   - Brak nadlewów
   - Wymiary zgodne z projektem CAD (±0.2mm)
   - Powierzchnia gładka (szlifowana)

3. **Odlewy metalowe:**
   - Brak pęknięć
   - Masa zgodna z etykietą (±5g)
   - Powierzchnia czysta (bez żużla)

4. **Elektronika:**
   - Wszystkie połączenia lutowane poprawnie
   - Testy multimetrem (ciągłość, napięcie)
   - Pakowanie antistatic

### Procedury testowe

- **Filament:** Test wydruku (kalibracja, przyczepność)
- **Obudowy:** Test montażu (Raspberry Pi, Arduino)
- **Przewody:** Test ciągłości (multimetr)
- **Adaptery:** Test napięcia/prądu (zasilanie testowe)

## Magazynowanie gotowych wyrobów

### Organizacja magazynu

```
produkcja/
├── finished/              # Gotowe produkty
│   ├── filament/          # Szpule filamentu (pakowane)
│   ├── cases/             # Obudowy 3D printed
│   ├── metals/            # Pręty, przewody metalowe
│   └── electronics/       # Adaptery, moduły
├── packaging/             # Materiały do pakowania
│   ├── boxes/             # Pudełka kartonowe
│   ├── labels/            # Etykiety (drukowane)
│   └── antistatic/        # Worki antistatic
└── tools/                 # Narzędzia produkcyjne
    ├── extruder/          # Ekstruder (filament)
    ├── injection-mold/    # Formy wtryskowe
    └── soldering/         # Stacja lutownicza
```

## KPI - Kluczowe wskaźniki

### Metryki produkcji

- **Wydajność ekstruzji:** kg filamentu/dzień
- **Czas wtrysku:** części/godzinę
- **Odzysk metalu:** % sprawnego odlewu (bez żużla)
- **Jakość druku 3D:** % udanych wydruków
- **Testy elektroniki:** % przejścia testów QA

### Cele miesięczne

- **10kg filamentu/miesiąc** (10 szpul × 1kg)
- **50 obudów wtryskowych** (Raspberry Pi, Arduino)
- **20kg odlewów metalowych** (pręty Cu/Al)
- **100 adapterów USB** (custom designs)

## Integracja z innymi modułami

### RECYCLE → PRODUKCJA

- **Wejście:** Czysty surowiec (1kg worki, woreczki)
- **Proces:** Magazyn SUROWCE WTÓRNE
- **Wyjście:** Pobieranie surowca do produkcji

### PRODUKCJA → SALES

- **Wejście:** Gotowe wyroby (pakowane, z etykietą)
- **Proces:** Przygotowanie do sprzedaży
- **Wyjście:** Listing na eBay/Etsy

### PRODUKCJA → UPCYCLE

- **Wejście:** Części własnej produkcji (obudowy, przewody)
- **Proces:** Montaż w projektach artystycznych
- **Wyjście:** Gotowy produkt UPCYCLE

## Rozwój PRODUKCJA

### Sprzęt docelowy (plan zakupów)

- ✅ **Ekstruder filamentu** (1.75mm) - priorytet 1
- ⏳ **Wtryskarka plastiku** (desktop injection molder) - priorytet 2
- ⏳ **Piec do topienia metali** (Al/Cu capable) - priorytet 3
- ✅ **Drukarka 3D FDM** (Prusa i3 MK3S+) - POSIADAMY
- ✅ **Stacja lutownicza** - POSIADAMY

### Szkolenia

- Obsługa ekstrudera (kalibry, temperatura)
- Projektowanie form wtryskowych (CAD)
- Bezpieczeństwo przy topnieniu metali (PPE)
- Kontrola jakości (pomiary, testy)

## Compliance i bezpieczeństwo

### Regulacje

- **CE Marking:** Dla elektroniki sprzedawanej w UK/EU
- **RoHS Compliance:** Brak szkodliwych substancji
- **Packaging Waste:** Recyclable packaging

### Bezpieczeństwo

- **PPE:** Rękawice, okulary (topienie metali)
- **Wentylacja:** Wyciąg oparów (ekstruzja ABS)
- **Instrukcje:** SOP dla każdego procesu produkcyjnego

---

## Linki

- [[ops/ops|OPS]] - Główny przepływ operacyjny
- [[ops/recycle/recycle|RECYCLE]] - Źródło surowców wtórnych
- [[ops/sales/sales|SALES]] - Sprzedaż gotowych wyrobów
- [[ops/upcycle/upcycle|UPCYCLE]] - Kreacja artystyczna z części produkcji
