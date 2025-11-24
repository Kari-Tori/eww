---
tags:
  - #infrastructure
  - #network
  - #cisco
  - #ports
created: 2025-11-23T21:00:00Z
modified: 2025-11-23T21:00:00Z
author: jakubc
title: "Cisco Switch - Mapa portów"
owner: jakubc
---

# Cisco Switch - Mapa portów

Dokumentacja mapowania portów Cisco switch oraz urządzeń podłączonych.

## 📊 Informacje o urządzeniu

| Parametr | Wartość |
|----------|---------|
| **Model** | _TBD po montażu_ |
| **Wersja IOS** | _TBD po montażu_ |
| **Liczba portów** | _TBD po montażu_ |
| **Typ portów** | _TBD (10/100/1000 / SFP)_ |
| **Lokalizacja** | U42 Rack, U3-U4 |
| **Zasilanie** | UPS 5kW (U41-U42) |
| **Management IP** | _TBD po konfiguracji_ |
| **Hostname** | _TBD po konfiguracji_ |

---

## 🔌 Mapa portów (24 porty)

### Porty 1-12 (Row 1)

| Port | Status | Urządzenie | IP | VLAN | Opis | Kabel |
|------|--------|------------|----|----- |------|-------|
| 1 | 🔴 DOWN | - | - | - | Wolny | - |
| 2 | 🔴 DOWN | - | - | - | Wolny | - |
| 3 | 🔴 DOWN | - | - | - | Wolny | - |
| 4 | 🔴 DOWN | - | - | - | Wolny | - |
| 5 | 🔴 DOWN | - | - | - | Wolny | - |
| 6 | 🔴 DOWN | - | - | - | Wolny | - |
| 7 | 🔴 DOWN | - | - | - | Wolny | - |
| 8 | 🔴 DOWN | - | - | - | Wolny | - |
| 9 | 🔴 DOWN | - | - | - | Wolny | - |
| 10 | 🔴 DOWN | - | - | - | Wolny | - |
| 11 | 🔴 DOWN | - | - | - | Wolny | - |
| 12 | 🔴 DOWN | - | - | - | Wolny | - |

### Porty 13-24 (Row 2)

| Port | Status | Urządzenie | IP | VLAN | Opis | Kabel |
|------|--------|------------|----|----- |------|-------|
| 13 | 🔴 DOWN | - | - | - | Wolny | - |
| 14 | 🔴 DOWN | - | - | - | Wolny | - |
| 15 | 🔴 DOWN | - | - | - | Wolny | - |
| 16 | 🔴 DOWN | - | - | - | Wolny | - |
| 17 | 🔴 DOWN | - | - | - | Wolny | - |
| 18 | 🔴 DOWN | - | - | - | Wolny | - |
| 19 | 🔴 DOWN | - | - | - | Wolny | - |
| 20 | 🔴 DOWN | - | - | - | Wolny | - |
| 21 | 🔴 DOWN | - | - | - | Wolny | - |
| 22 | 🔴 DOWN | - | - | - | Wolny | - |
| 23 | 🔴 DOWN | - | - | - | Wolny | - |
| 24 | 🔴 DOWN | - | - | - | Wolny | - |

### Porty Uplink / SFP (jeśli dostępne)

| Port | Status | Urządzenie | IP | VLAN | Opis | Kabel |
|------|--------|------------|----|----- |------|-------|
| G1/1 | 🔴 DOWN | - | - | - | Wolny | - |
| G1/2 | 🔴 DOWN | - | - | - | Wolny | - |

---

## 📝 Planowane przypisania portów

### Gary Network Uplink
- **Port**: _TBD (zalecany: uplink G1/1 lub port 24)_
- **Źródło**: Patch Panel U1-U2 (Gary Network)
- **Typ kabla**: Cat6 patch cord 0.5m
- **VLAN**: _TBD_
- **Opis**: Uplink do Gary Network (Internet)

### GERC
- **Port**: _TBD (np. port 1)_
- **IP**: 192.168.0.99 (stary) / _TBD nowy_
- **MAC**: _TBD_
- **VLAN**: _TBD_
- **Kabel**: Cat6 _długość TBD_

### ASUS Z77
- **Port**: _TBD (np. port 2)_
- **IP**: 192.168.0.77 (stary) / _TBD nowy_
- **MAC**: _TBD_
- **VLAN**: _TBD_
- **Kabel**: Cat6 _długość TBD_

### Lenovo M710q
- **Port**: _TBD (np. port 3)_
- **IP**: 192.168.0.40 (planowany) / _TBD nowy_
- **MAC**: _TBD_
- **VLAN**: _TBD_
- **Kabel**: Cat6 _długość TBD_

---

## 🔧 Konfiguracja VLAN

| VLAN ID | Nazwa | Subnet | Gateway | Opis |
|---------|-------|--------|---------|------|
| 1 | Default | _TBD_ | _TBD_ | Management / Default |
| _TBD_ | Gary Network | _TBD_ | _TBD_ | Uplink do Gary Network |
| _TBD_ | Workstations | _TBD_ | _TBD_ | GERC, ASUS Z77, M710q |

---

## 📊 Status Legend

| Symbol | Znaczenie |
|--------|-----------|
| 🟢 UP | Port aktywny, link up, transmisja OK |
| 🟡 UP/ERR | Port aktywny, ale błędy (CRC, collisions) |
| 🔴 DOWN | Port nieaktywny, no link |
| ⚪ DISABLED | Port wyłączony administratorsko |
| 🔵 TRUNK | Port trunk (wiele VLAN) |

---

## 📋 Komendy diagnostyczne Cisco

```bash
# Sprawdzenie statusu wszystkich portów
show interfaces status

# Szczegóły konkretnego portu
show interface GigabitEthernet1/0/1

# Podsumowanie wszystkich interfejsów
show ip interface brief

# Statystyki błędów
show interfaces counters errors

# Konfiguracja VLAN
show vlan brief

# MAC address table
show mac address-table

# Running config
show running-config

# Backup config
copy running-config startup-config
```

---

## 🔗 Powiązane dokumenty

- [[docs/infra/network/network-deployment-2025-11-23]] - Log wdrożenia
- [[docs/infra/hardware/rack/u42-rack-layout]] - Layout szafy U42
- [[core/workflow/infrastructure]] - Infrastruktura ogólna

---

**Ostatnia aktualizacja**: 2025-11-23 21:00 (szablon)
**Osoba aktualizująca**: jakubc
**Status**: 🔴 Szablon - wymaga wypełnienia po montażu Cisco
