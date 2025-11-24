---
tags:
  - #infrastructure
  - #network
  - #deployment
  - #log
created: 2025-11-23T19:45:00Z
modified: 2025-11-23T19:45:00Z
author: jakubc
title: "Network Deployment Log - 2025-11-23"
owner: jakubc
---

# Network Deployment Log - 2025-11-23

Log wdrożenia infrastruktury sieciowej i synchronizacji dla projektu EWW.

## 📅 Plan wdrożenia (6 faz) - ZAKTUALIZOWANY

### Faza 1: Podłączenie Cisco Switch ✅ CEL DZIŚ
- Fizyczny montaż switch w U3-U4 (pod patch panel U1-U2)
- Podłączenie zasilania do UPS 5kW
- Weryfikacja statusu portów i LED
- Podłączenie konsoli (serial/USB) dla konfiguracji
- Dokumentacja modelu, wersji IOS, liczby portów

### Faza 2: Konfiguracja podstawowa Cisco ✅ CEL DZIŚ
- Ustawienie hostname, enable password
- Konfiguracja management IP
- Weryfikacja `show interfaces status`
- Test ping z konsoli
- Podłączenie uplink Gary Network (krótki patch od patch panel)

### Faza 3: Połączenie z Gary Network ✅ CEL DZIŚ
- Identyfikacja parametrów Gary Network (IP range, gateway, DHCP)
- Konfiguracja portu uplink (trunk/access, VLAN)
- Test connectivity Gary Network ↔ Cisco
- Weryfikacja routingu

### Faza 4: Migracja GERC do nowego środowiska ✅ CEL DZIŚ
- Podłączenie GERC (192.168.0.99) do Cisco switch
- Konfiguracja IP w nowym zakresie Gary Network (lub bridge)
- Test GERC ↔ Gary Network ↔ Internet
- Weryfikacja działania Git, SSH, Docker
- **Stare środowisko: nie ruszamy jeszcze**

### Faza 5: Migracja ASUS Z77 do nowego środowiska ✅ CEL DZIŚ
- Podłączenie ASUS Z77 (192.168.0.77) do Cisco switch
- Konfiguracja IP w nowym zakresie Gary Network
- Test ASUS Z77 ↔ Gary Network ↔ Internet
- Weryfikacja działania Git, SSH, Obsidian
- **Stare środowisko: backup plan jeśli problemy**

### Faza 6: Dokumentacja i backup ✅ CEL DZIŚ
- Backup konfiguracji Cisco: `copy running-config startup-config`
- Aktualizacja `core/workflow/infrastructure.md`
- Utworzenie `docs/infra/network/gary-network-topology.md`
- Dodanie Cisco do `docs/infra/hardware/` inventory
- **Lenovo M710q: odłożone na później**

---

## 📝 Log zmian

### 2025-11-23 20:00 - Start deployment: Gary Network + Cisco prod od zera
**Kontekst**:
- Aktualny setup: Wszystko działa (GERC, ASUS Z77, infrastruktura podstawowa)
- Plan: Połączenie do Gary Network **bez rozłączania** obecnego sprzętu
- Urządzenie: Cisco (switch/router) - budowa nowego środowiska produkcyjnego od zera
- Podejście: Włączyć Cisco, debugować, budować równoległe środowisko prod

**Status przed startem**:
- ✅ GERC: Działa, gotowy
- ✅ ASUS Z77: Działa, gotowy
- ✅ Lenovo M710q: Dostępny do wdrożenia
- ✅ Dokumentacja: Kompletna
- ✅ TODO struktura: Wdrożona

**Cel**:
- Podłączenie do Gary Network przez Cisco
- Zachowanie obecnego działającego setupu
- Budowa nowego środowiska prod równolegle
- Debug i konfiguracja Cisco step-by-step

**Następny krok**: Włączenie Cisco, analiza portów, konfiguracja początkowa

---

### 2025-11-23 20:10 - Decyzja: Budowa nowego środowiska równolegle
**Potwierdzenie**:
- ✅ Budujemy nowe środowisko **BEZ ruszania** istniejącego
- ✅ Obecny setup pozostaje nienaruszony i działający
- ✅ Cisco switch jako punkt wejściowy do Gary Network

**Plan na dziś**:
- Podłączenie switch Cisco
- Konfiguracja podstawowa switch
- Reszta deployment jutro

**Fizyczna lokalizacja switch**:
- Szafa: U42 (rack) w pomieszczeniu 24m²
- Istniejące urządzenia: UPS 5kW na dole szafy
- Topologia: **Internet wchodzi od góry** (patch panel/okablowanie strukturalne u góry)
- Pozycja switch: **U3-U4 (bezpośrednio pod patch panelem U1-U2)**
- Logiczny przepływ: Internet (góra) → Patch panel → Switch → Urządzenia (w dół)
- Zalety: minimalne długości kabli, łatwy dostęp, logiczna topologia, wizualny monitoring LED
- Kablowanie: Gary Network uplink od góry (krótki patch), porty dla urządzeń w dół szafy

**Następny krok**: Montaż switch w U3-U4, podłączenie uplink od patch panelu, zasilanie z UPS, power-on

**🎯 Cel na dziś (2025-11-23)**:
1. ✅ Cisco Switch - montaż fizyczny + konfiguracja podstawowa
2. ✅ GERC (192.168.0.99) - migracja do nowego środowiska Gary Network
3. ✅ ASUS Z77 (192.168.0.77) - migracja do nowego środowiska Gary Network
4. ⏸️ Lenovo M710q - odłożone na później

---

## 📋 Log wdrożenia

---

### [Kolejne wpisy będą dodawane tutaj]

**Format wpisu**:
```
### YYYY-MM-DD HH:MM - Tytuł zmiany
**Wykonano**:
- Lista wykonanych działań

**Problem** (opcjonalnie):
- Opis napotkanych problemów

**Rozwiązanie** (opcjonalnie):
- Jak rozwiązano problem

**Status**:
- Aktualny status urządzeń/komponentów

**Następny krok**: Co dalej
```

---

## 🎯 Checklisty wykonania

---

## 📊 Status Board

| Komponent | Status | Owner | ETA |
|-----------|--------|-------|-----|
| CouchDB (GERC) | ⏳ Pending | @jakubc | TBD |
| LiveSync (GERC) | ⏳ Pending | @jakubc | TBD |
| WAN Fix (ASUS Z77) | 🔴 Critical | @karinam @jakubc | TBD |
| LiveSync (ASUS Z77) | ⏳ Blocked | @karinam | After WAN fix |
| Lenovo M710q OS | ⏳ Pending | @jakubc | TBD |
| Lenovo M710q Deploy | ⏳ Pending | @jakubc | TBD |

**Legend**:
- 🔴 Critical - blokujący problem
- ⏳ Pending - oczekuje na wykonanie
- 🟡 In Progress - w trakcie
- 🟢 Done - zakończone
- ⛔ Blocked - zablokowane przez inny task

---

## 🔗 Powiązane dokumenty

- [[core/workflow/infrastructure]] - Pełna dokumentacja infrastruktury
- [[core/workflow/git-sync-strategy]] - Strategia Git + LiveSync
- [[docs/infra/network/README]] - Konfiguracja sieci
- [[docs/infra/hardware/workstations/gerc/TODO/TODO]] - TODO GERC
- [[docs/infra/hardware/workstations/asus_z77/TODO/TODO]] - TODO ASUS Z77
- [[docs/infra/hardware/workstations/lenovo_m710q/TODO/TODO]] - TODO Lenovo M710q

---

**Ostatnia aktualizacja**: 2025-11-23 19:45
**Osoba aktualizująca**: jakubc
**Następna planowana aktualizacja**: Po wykonaniu pierwszego kroku wdrożenia
