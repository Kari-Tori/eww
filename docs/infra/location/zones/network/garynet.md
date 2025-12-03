---
tags:
  - #infra
  - #network
  - #garynet
  - #connection
created: 2025-11-22T22:15:00Z
modified: 2025-11-22T22:15:00Z
author: jakubc
owner: jakubc
---

# Garynet - Połączenie z Routerem Gary

## Opis

**Garynet** to gniazdko sieciowe RJ-45 w ścianie, które łączy naszą sieć z routerem Gary w innym budynku.

## Topologia

```
[Nasz budynek]
    Gateway (192.168.0.10) 
        ↓ LAN Port
    Gniazdko w ścianie (Garynet)
        ↓ Kabel UTP (20 metrów)
[Drugi budynek - Gary]
    Router Gary
        └─ Urządzenia Gary
```

## Szczegóły Połączenia

- **Typ**: Ethernet (UTP Cat5e/Cat6)
- **Długość kabla**: ~20 metrów
- **Lokalizacja startowa**: Gniazdko w ścianie (nasz budynek)
- **Lokalizacja końcowa**: Router Gary (drugi budynek)
- **Prędkość**: Do 1 Gbps (w zależności od kabla)

## Konfiguracja

- **VLAN**: Brak / [Do sprawdzenia]
- **Routing**: Prawdopodobnie bridge (przezroczyste połączenie)
- **IP Router Gary**: [Do ustalenia]
- **Sieć**: Prawdopodobnie oddzielna podsieć lub rozszerzenie 192.168.0.0/24

## Dostęp do Routera Gary

- **IP**: [Do ustalenia]
- **Login**: [Do ustalenia - uzgodnić z Gary]
- **Hasło**: [Do ustalenia - uzgodnić z Gary]

## Urządzenia za Routerem Gary

- [Do zinwentaryzowania]

## Zadania

- [ ] Ustalić IP routera Gary
- [ ] Ustalić konfigurację sieci (podsieć, VLAN)
- [ ] Sprawdzić typ kabla (Cat5e/Cat6)
- [ ] Test prędkości połączenia
- [ ] Uzgodnić z Gary dostęp do routera
- [ ] Dokumentacja urządzeń Gary
- [ ] Test łączności (ping, traceroute)

## Diagnostyka

### Test połączenia:
```bash
# Z naszego komputera
ping [IP_ROUTERA_GARY]
traceroute [IP_ROUTERA_GARY]

# Test prędkości
iperf3 -c [IP_ROUTERA_GARY]
```

## Notatki

- 20 metrów kabla to bezpieczna odległość dla Ethernet (max 100m)
- Sprawdzić czy kabel jest ekranowany (STP) dla lepszej odporności
- Rozważyć switch pomiędzy jeśli potrzeba więcej portów

## Bezpieczeństwo

⚠️ **Uwaga**: 
- Połączenie z innym budynkiem = potencjalne ryzyko
- Rozważyć VLAN separation
- Firewall między sieciami (jeśli potrzebne)
- Uzgodnić politykę bezpieczeństwa z Gary

## Linki

- [[gateway|Gateway (192.168.0.10)]]
- [[../../../usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/freederick|TODO Freederick]]
- [[../../../usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/internet|TODO Internet]]

## Data Dokumentacji

Utworzono: 2025-11-22

## 🔗 Backlinks

- [[docs/infra/areas/network/network]]
- [[docs/docs]]
- [[INDEX]]
