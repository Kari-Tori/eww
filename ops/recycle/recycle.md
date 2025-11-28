---
tags:
  - folder_note
  - ops
  - recycle
  - recycling
  - waste
  - zero-waste
created: 2025-11-28T21:00:00Z
modified: 2025-11-28T21:00:00Z
author: karinam
title: "Recycle - Recykling i zarządzanie odpadami"
owner: karinam
---

# Recycle - Recykling i zarządzanie odpadami

> Moduł zarządzania odpadami z rozbiórki - recykling płyt PCB, plastiku i innych surowców

## Cel

Odpowiedzialne zarządzanie materiałami, których nie można bezpośrednio sprzedać:
- Maksymalizacja odzysku wartościowych materiałów
- Minimalizacja odpadów trafiających na wysypisko
- Zgodność z normami środowiskowymi
- Współpraca z partnerami recyklingowymi

## Co trafia do RECYCLE?

Z **ROZBIÓRKI** trafiają materiały niesprzedawalne bezpośrednio:

### 1. Płyty PCB (Printed Circuit Boards)
- Uszkodzone płytki bez wartościowych komponentów
- Płyty po demontażu wszystkich elementów
- PCB z korozją lub zniszczeniami
- **Recykling:** Odzysk metali szlachetnych (Au, Ag, Cu)

### 2. Plastik
- **Rodzaje:**
  - ABS (obudowy)
  - PC/Poliwęglan
  - PVC (kable, izolacje)
  - PP/PE (opakowania)
  - Mieszanki plastikowe
- **Proces:** Sortowanie → granulowanie → recykling

### 3. Metale
- Aluminium (obudowy, radiatory)
- Miedź (przewody, cewki)
- Stal (śruby, elementy konstrukcyjne)
- Metale szlachetne (z PCB)
- **Proces:** Segregacja → przetopienie → surowiec wtórny

### 4. Szkło
- Uszkodzone ekrany LCD/LED
- Szkło nieprzydatne do ponownego użycia
- **Proces:** Kruszenie → recykling szkła

### 5. Baterie i akumulatory
- Baterie uszkodzone/wyczerpane
- Akumulatory nie nadające się do regeneracji
- **Proces:** Przekazanie do specjalistycznego recyklingu

### 6. Inne materiały
- Kable uszkodzone
- Taśmy, folie
- Elementy ceramiczne
- Materiały kompozytowe

## Struktura katalogów

```
recycle/
├── recycle.md          # Ta notatka
├── pcb/                # Płyty drukowane
│   ├── damaged/       # Uszkodzone płytki
│   ├── stripped/      # Po demontażu komponentów
│   └── awaiting/      # Oczekujące na recykling
├── plastics/           # Tworzywa sztuczne
│   ├── abs/           # ABS
│   ├── pc/            # Poliwęglan
│   ├── pvc/           # PVC
│   ├── mixed/         # Mieszanki
│   └── processed/     # Przetworzone (granulat)
├── metals/             # Metale
│   ├── aluminum/      # Aluminium
│   ├── copper/        # Miedź
│   ├── steel/         # Stal
│   └── precious/      # Szlachetne (Au, Ag)
├── glass/              # Szkło
├── batteries/          # Baterie i akumulatory
├── misc/               # Różne materiały
└── partners/           # Dokumenty partnerów recyklingowych
```

## Proces recyklingu

```
ROZBIÓRKA → SEGREGACJA → RECYCLE
               ↓
    ┌──────────┼──────────┐
    │          │          │
    ▼          ▼          ▼
 SPRZEDAŻ  MAGAZYN   PARTNER
 (surowce) (oczekuje) (recykling)
```

### Etapy

1. **Przyjęcie z ROZBIÓRKI**
   - Rejestracja materiału
   - Wstępna klasyfikacja

2. **Segregacja**
   - Podział wg typu materiału
   - Ważenie i dokumentacja
   - Ocena wartości

3. **Decyzja:**
   - **Sprzedaż** - surowce wtórne (metale czyste, plastik granulat)
   - **Magazyn** - gromadzenie do większej partii
   - **Partner recyklingowy** - materiały specjalistyczne

4. **Przekazanie**
   - Dokumentacja przekazania
   - Certyfikaty recyklingu
   - Rozliczenie (jeśli odpłatne)

## Partnerzy recyklingowi

### Kategorie partnerów:
- 🔋 **Baterie i akumulatory** - specjalistyczny recykling
- 🖥️ **Płyty PCB** - odzysk metali szlachetnych
- ♻️ **Plastik** - recykling tworzyw
- 🔩 **Metale** - skup i przetopienie
- 📱 **WEEE** - certyfikowany recykling elektrośmieci

### Dokumentacja:
- Umowy współpracy
- Certyfikaty recyklingu
- Potwierdzenia przekazania
- Rozliczenia finansowe

## Metryki i raportowanie

### Śledzenie:
- Ilość materiału (kg/miesiąc)
- Wartość odzyskana
- Procent odpadów zero-waste
- Certyfikaty środowiskowe

### Cele:
- < 5% odpadów na wysypisko
- 95%+ materiałów przetworzonych
- Maksymalizacja odzysku wartości

## Zero Waste w praktyce

**RECYCLE** to ostatni etap cyklu:
- Materiały niesprzedawalne → odpowiedzialna utylizacja
- Partnerzy recyklingowi → nowe życie surowców
- Certyfikaty → potwierdzenie zgodności
- **Cel:** Minimum na wysypisko, maksimum odzysku

## Powiązania

- [[ops/ops|OPS]] - Operacje główne
- [[ops/ops-workflow|Workflow]] - Przepływ operacyjny
- [[ZERO-WASTE-POLICY|Zero Waste Policy]] - Polityka zeroodpadowa
