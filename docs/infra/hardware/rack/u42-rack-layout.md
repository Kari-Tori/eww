---
version: 0.0.1
tags:
  - #infrastructure
  - #rack
  - #hardware
  - #layout
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "U42 Rack - Layout szafy"
owner: jakubc
---

# U42 Rack - Layout szafy

Dokumentacja fizycznego rozmieszczenia urządzeń w szafie rack 42U.

## 📐 Specyfikacja szafy

| Parametr | Wartość |
|----------|---------|
| **Model** | U42 Rack Cabinet |
| **Wysokość** | 42U (1U = 44.45mm) |
| **Szerokość** | 19" (482.6mm) |
| **Lokalizacja** | Pomieszczenie 24m² |
| **Wejście kabli** | Góra (okablowanie strukturalne) |
| **Zasilanie** | UPS 5kW (na dole szafy) |
| **Chłodzenie** | Naturalna konwekcja (góra ciepłe, dół zimne) |

---

## 🗂️ Layout szafy (U1-U42, od góry)

### Górna sekcja (U1-U10) - Networking & Patch

| U-slot  | Urządzenie       | Model | Status  | Zasilanie | Opis                                           |
| ------- | ---------------- | ----- | ------- | --------- | ---------------------------------------------- |
| **U1**  | Patch Panel      | _TBD_ | 🔴 TODO | -         | Okablowanie strukturalne (Gary Network uplink) |
| **U2**  | Organizer        | _TBD_ | 🔴 TODO | -         | Cable management / organizacja kabli           |
| **U3**  | **Cisco Switch** | _TBD_ | 🔴 TODO | UPS 5kW   | **GŁÓWNY SWITCH** (montaż dziś)                |
| **U4**  | _(Cisco cont.)_  | _TBD_ | 🔴 TODO | UPS 5kW   | Kontynuacja Cisco (jeśli 2U)                   |
| **U5**  | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |
| **U6**  | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |
| **U7**  | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |
| **U8**  | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |
| **U9**  | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |
| **U10** | Wolny            | -     | ⚪ FREE  | -         | Dostępny slot                                  |

### Środkowa sekcja górna (U11-U20) - Serwerownia

| U-slot | Urządzenie | Model | Status | Zasilanie | Opis |
|--------|------------|-------|--------|-----------|------|
| **U11** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U12** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U13** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U14** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U15** | Wolny | - | ⚪ FREE | - | Dostępny slot (zarezerwowany dla Lenovo M710q?) |
| **U16** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U17** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U18** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U19** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U20** | Wolny | - | ⚪ FREE | - | Dostępny slot |

### Środkowa sekcja dolna (U21-U30) - Storage / Compute

| U-slot  | Urządzenie | Model | Status | Zasilanie | Opis          |
| ------- | ---------- | ----- | ------ | --------- | ------------- |
| **U21** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U22** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U23** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U24** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U25** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U26** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U27** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U28** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U29** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |
| **U30** | Wolny      | -     | ⚪ FREE | -         | Dostępny slot |

### Dolna sekcja (U31-U42) - Power & Infrastructure

| U-slot | Urządzenie | Model | Status | Zasilanie | Opis |
|--------|------------|-------|--------|-----------|------|
| **U31** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U32** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U33** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U34** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U35** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U36** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U37** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U38** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U39** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U40** | Wolny | - | ⚪ FREE | - | Dostępny slot |
| **U41** | **UPS 5kW** | _TBD model_ | 🟢 ACTIVE | Sieć 230V | **ZASILANIE GŁÓWNE** (ciężkie, stabilne na dole) |
| **U42** | _(UPS cont.)_ | _TBD model_ | 🟢 ACTIVE | Sieć 230V | Kontynuacja UPS |

---

## 📊 Podsumowanie wykorzystania

| Kategoria | Sloty używane | Sloty wolne | % wykorzystania |
|-----------|---------------|-------------|-----------------|
| **Networking** (U1-U4) | 4 | 0 | 100% (po montażu Cisco) |
| **Serwerownia** (U5-U30) | 0 | 26 | 0% |
| **Power** (U31-U42) | 2 (UPS) | 10 | 16.7% |
| **RAZEM** | 6 | 36 | **14.3%** |

**Dostępne sloty**: 36 / 42 (85.7% wolne)

---

## 🔌 Przepływ kabli

```
GÓRA SZAFY (okablowanie wchodzi od góry, pomieszczenie 24m²)
    ↓
[U1-U2] Patch Panel + Organizer
    ↓ (krótki patch 30-50cm)
[U3-U4] Cisco Switch
    ↓ (kable w dół do urządzeń)
[U5-U40] Wolne sloty (kable prowadzone w dół)
    ↓
[U41-U42] UPS 5kW (zasilanie wszystkich urządzeń)
```

**Logika**:
- Internet/Gary Network → wchodzi od **góry** (ściana/sufit)
- Patch panel → **górna część** szafy (U1-U2)
- Switch → bezpośrednio **pod patch panelem** (U3-U4)
- Kable urządzeń → prowadzone **w dół** wzdłuż szafy
- UPS → na **dole** (stabilność mechaniczna, grawitacja)



## 📋 Planowane rozmiersjonowanie grafu – napisz dev/scripts/graph-snapshoteszczenie urządzeń

### Dzisiaj (2025-11-23)
- ✅ Cisco Switch montaż w U3-U4
- ✅ Patch Panel w U1-U2 (jeśli jeszcze nie zainstalowany)

### Przyszłość
- 🔲 Lenovo M710q (1U) → U15? (środek szafy, łatwy dostęp)
- 🔲 Przyszły serwer NAS/Storage → U20-U25?
- 🔲 Dodatkowy switch/router → U5-U6 (pod Cisco)?

---

## 🔧 Cable Management

### Zasady prowadzenia kabli
1. **Patch cords góra**: Patch Panel (U1-U2) → Cisco (U3-U4) = 30-50cm
2. **Kable urządzeń**: Cisco → urządzenia w dół = długość zależna od U-slot
3. **Zasilanie**: UPS (U41-U42) → urządzenia w górę wzdłuż tylnej części rack
4. **Organizery**: Użyć organizers (U2, U10, U20, U30) dla porządku

### Długości kabli (szacunkowe)
- Patch Panel → Cisco (U1→U3): **0.5m** (30-50cm)
- Cisco → U15 (M710q): **~1.5m** (12U × 44mm ≈ 53cm + zapas)
- Cisco → U30: **~2.5m** (27U × 44mm ≈ 1.2m + zapas)
- UPS → Cisco (U41→U3): **~3m** (38U × 44mm ≈ 1.7m + zapas)

---

## 🌡️ Zarządzanie ciepłem

### Rozkład temperatury w szafie
- **Góra (U1-U10)**: Najcieplejsza część (ciepłe powietrze unosi się)
- **Środek (U11-U30)**: Optymalna temperatura dla urządzeń
- **Dół (U31-U42)**: Najzimniejsza część (chłodne powietrze opada)

### Rekomendacje
- **Aktywne urządzenia** (switch, serwery): U3-U25 (optymalna temp)
- **Pasywne urządzenia** (patch panel, organizery): U1-U2, U26-U30
- **UPS** (dużo ciepła): Dół szafy U41-U42 (stabilność + chłód)

---

## 📊 Status Legend

| Symbol      | Znaczenie                                |
| ----------- | ---------------------------------------- |
| 🟢 ACTIVE   | Urządzenie zainstalowane i działa        |
| 🟡 PLANNED  | Planowane do montażu                     |
| 🔴 TODO     | Do wykonania (dzisiaj/jutro)             |
| ⚪ FREE      | Slot wolny, dostępny                     |
| 🔵 RESERVED | Zarezerwowany dla konkretnego urządzenia |

---

## 🔗 Powiązane dokumenty

- [[docs/infra/hardware/network/cisco-switch-port-map]] - Mapa portów Cisco
- [[docs/infra/hardware/network/network-deployment-2025-11-23]] - Log wdrożenia
- [[core/workflow/infrastructure]] - Infrastruktura ogólna
- [[docs/infra/hardware/workstations/gerc/gerc]] - GERC specs
- [[docs/infra/hardware/workstations/asus_z77/asus_z77]] - ASUS Z77 specs
- [[docs/infra/hardware/workstations/lenovo_m710q/lenovo_m710q]] - Lenovo M710q specs

---

**Ostatnia aktualizacja**: 2025-11-23 21:00 (szablon)
**Osoba aktualizująca**: jakubc
**Status**: 🔴 Szablon - wypełnić po montażu Cisco w U3-U4

## 🔗 Backlinks

- [[docs/infra/hardware/rack/rack]]
- [[docs/docs]]
- [[INDEX]]