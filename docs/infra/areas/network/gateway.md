---
tags:
  - #infra
  - #network
  - #gateway
  - #router
  - #asus
created: 2025-11-22T22:15:00Z
modified: 2025-11-22T22:15:00Z
author: jakubc
owner: jakubc
---

# Gateway - ASUS DSL-N16 (192.168.0.10)

## Informacje Podstawowe

- **IP**: 192.168.0.10
- **Marka**: ASUS
- **Model**: DSL-N16
- **Typ**: Router ADSL/VDSL z Wi-Fi
- **Rola**: Gateway (główny router, dostęp do Internetu)

## Dostęp

- **Adres WWW**: http://192.168.0.10
- **Login**: admin
- **Hasło**: admin (⚠️ zmienić na bezpieczne!)

## Specyfikacja

- **Wi-Fi**: 802.11n (2.4 GHz)
- **Porty LAN**: 4x Gigabit Ethernet
- **Port WAN/DSL**: 1x RJ-11 (ADSL/VDSL)
- **USB**: 1x USB 2.0 (dla drukarki/dysku)

## Topologia Sieci

```
Internet (DSL) 
    ↓
ASUS DSL-N16 (192.168.0.10) [GATEWAY]
    ↓
├─ Wi-Fi (2.4 GHz)
│   └─ Urządzenia bezprzewodowe
│
└─ LAN (Gigabit Ethernet)
    ├─ 192.168.0.77 - Asus Z77 (karinam)
    ├─ Lenovo Y700 (sprawdzić IP)
    └─ Garynet → Router Gary (20m kabel)
```

## Podłączone Urządzenia

### Przewodowe (LAN)
- [[devices/asus-z77|Asus Z77]] - 192.168.0.77 (karinam)
- [[devices/lenovo-y700|Lenovo Y700]] - IP do ustalenia
- [[garynet|Garynet]] - Gniazdko w ścianie → kabel 20m → Router Gary

### Bezprzewodowe (Wi-Fi)
- [Do uzupełnienia]

## Konfiguracja

### WAN (Internet)
- **Typ połączenia**: PPPoE / DHCP / Statyczne IP (sprawdzić)
- **ISP**: [Do uzupełnienia]
- **DNS**: [Do uzupełnienia - prawdopodobnie 8.8.8.8, 8.8.4.4]

### LAN
- **Sieć**: 192.168.0.0/24
- **Gateway**: 192.168.0.10
- **DHCP**: Włączony/Wyłączony (sprawdzić)
- **Zakres DHCP**: 192.168.0.100 - 192.168.0.200 (do sprawdzenia)

### Wi-Fi
- **SSID**: [Do uzupełnienia]
- **Hasło**: [Do uzupełnienia]
- **Szyfrowanie**: WPA2-PSK (sprawdzić)
- **Kanał**: Auto / [Do uzupełnienia]

## Zadania

- [ ] Zalogować się do routera (http://192.168.0.10)
- [ ] Zmienić domyślne hasło admin
- [ ] Sprawdzić podłączone urządzenia (lista DHCP)
- [ ] Zaktualizować firmware
- [ ] Sprawdzić logi (diagnostyka problemu z Firefox)
- [ ] Skonfigurować DNS (zalecane: 1.1.1.1 lub 8.8.8.8)
- [ ] Włączyć QoS (jeśli potrzebne)
- [ ] Backup konfiguracji

## Diagnostyka (Problem z Firefox na 192.168.0.77)

### Kroki diagnozy:
1. [ ] Sprawdzić status połączenia WAN (router)
2. [ ] Sprawdzić czy inne urządzenia mają Internet
3. [ ] Sprawdzić logi routera (błędy DNS, DHCP)
4. [ ] Test ping z routera do 8.8.8.8
5. [ ] Sprawdzić konfigurację DNS
6. [ ] Sprawdzić firewall routera

## Notatki

⚠️ **Bezpieczeństwo**:
- Domyślne hasło "admin" to RYZYKO!
- Zmienić hasło na silne (min. 12 znaków)
- Wyłączyć dostęp zdalny (WAN) jeśli niepotrzebny
- Włączyć firewall

💡 **Wskazówki**:
- ASUS DSL-N16 to starszy model (802.11n)
- Rozważyć upgrade do Wi-Fi 5 (802.11ac) lub Wi-Fi 6
- Router obsługuje OpenWRT (custom firmware)

## Linki

- [[../../../usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/internet|TODO Internet]]
- [[../../../usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/freederick|TODO Freederick]]
- [[devices/asus-z77|Asus Z77]]
- [[devices/lenovo-y700|Lenovo Y700]]
- [[garynet|Garynet]]
- [ASUS Support](https://www.asus.com/support/)

## Data Dokumentacji

Utworzono: 2025-11-22
