---
tags:
  - #dokumentacja
  - #router
  - #manual
created: 2025-11-22T17:18:00Z
modified: 2025-11-22T17:18:00Z
author: jakubc
title: "Dokumentacja ASUS DSL-N16"
owner: jakubc
---

# Dokumentacja ASUS DSL-N16

Folder zawiera dokumentację techniczną, instrukcje i procedury dla routera.

## 📚 Specyfikacja techniczna

### Procesor i pamięć
- CPU: Broadcom BCM6328 (300 MHz MIPS)
- RAM: 64 MB DDR2
- Flash: 8 MB

### Sieć bezprzewodowa
- Standard: 802.11n (2.4 GHz)
- Prędkość: do 300 Mbps
- Anteny: 2× wewnętrzne

### Porty
- WAN: 1× RJ11 (ADSL/VDSL)
- LAN: 4× Gigabit Ethernet (RJ45)
- USB: 1× USB 2.0

### Funkcje
- Firewall: SPI, DoS protection
- VPN: Pass-through (PPTP, L2TP, IPSec)
- QoS: WMM, Bandwidth control
- Guest Network: TAK
- Parental Control: TAK

## 🔗 Linki do dokumentacji

- [Strona produktu ASUS](https://www.asus.com/networking/dsl-n16/)
- [Download Center](https://www.asus.com/support/Download-Center/)
- [Instrukcja obsługi (PDF)](https://dlcdnets.asus.com/pub/ASUS/wireless/DSL-N16/E7982_DSL-N16_Manual.pdf)

## 📝 Przydatne komendy i procedury

### Reset do ustawień fabrycznych
1. Włącz router
2. Wciśnij przycisk RESET na 5-10 sekund
3. Poczekaj na restart
4. Domyślne IP: 192.168.1.1 (zmienione na 192.168.0.10)
5. Domyślny login: admin/admin

### Aktualizacja firmware
1. Pobierz najnowszy firmware z ASUS Support
2. Zaloguj się do routera
3. Przejdź do: Administration → Firmware Upgrade
4. Wybierz plik .trx
5. Upload i poczekaj na restart (5-10 minut)

### Diagnostyka DSL
1. Advanced Settings → DSL Line
2. Sprawdź:
   - Line State (Up/Down)
   - SNR Margin (15 dB+ = OK)
   - Attenuation (niższe = lepsze)
   - Connection Type

## 📋 Checklist konfiguracji

- [ ] Zmienić domyślne hasło
- [ ] Skonfigurować WAN (typ połączenia ISP)
- [ ] Ustawić WiFi (SSID, WPA2/WPA3)
- [ ] Skonfigurować DHCP i rezerwacje IP
- [ ] Włączyć firewall
- [ ] Wyłączyć niepotrzebne usługi (UPnP, WPS)
- [ ] Zaktualizować firmware
- [ ] Utworzyć backup konfiguracji
- [ ] Sprawdzić logi systemowe

## 🔍 Troubleshooting

### Brak internetu (WAN)
1. Sprawdź fizyczne połączenie DSL (lampka DSL świeci?)
2. Sprawdź status DSL w Advanced Settings → DSL Line
3. Zweryfikuj dane ISP (PPPoE login/password)
4. Sprawdź logi WAN connection
5. Zrestartuj router
6. Kontakt z ISP

### Wolne WiFi
1. Zmień kanał WiFi (1, 6, 11)
2. Sprawdź interferecje
3. Zaktualizuj firmware
4. Włącz QoS

### Urządzenia nie dostają IP
1. Sprawdź DHCP Server (włączony?)
2. Sprawdź zakres DHCP
3. Sprawdź logi DHCP
4. Restart routera

## 📂 Struktura plików

*Brak dodatkowych plików dokumentacji*

- [ ] Dodać instrukcję konfiguracji ISP
- [ ] Dodać schematy sieci
- [ ] Dodać procedury backup/restore

## 🔗 Backlinks

- [[docs/infra/hardware/network/devices/asus-dsl-n16/docs/docs]]
- [[docs/docs]]
- [[INDEX]]
