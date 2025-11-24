---
tags:
  - #router
  - #gateway
  - #asus
  - #network
  - #infrastructure
  - #eww
  - #folder_note
created: 2025-11-22T17:18:00Z
modified: 2025-11-22T17:18:00Z
author: jakubc
title: "ASUS DSL-N16 — Router/Gateway główny"
owner: jakubc
---

# ASUS DSL-N16 — Router/Gateway główny

Router ADSL/VDSL ASUS DSL-N16 pełniący rolę głównej bramy sieciowej w infrastrukturze EWW. Zapewnia dostęp do internetu oraz routing w sieci lokalnej 192.168.0.0/24.

## ℹ️ Opis i zastosowanie
> [!info] Profil urządzenia
> - 🌐 **Rola:** Gateway/Router główny
> - 📡 **Typ:** ADSL/VDSL modem-router
> - 🔌 **Model:** ASUS DSL-N16
> - 📍 **IP:** 192.168.0.10
> - 🌍 **Sieć:** 192.168.0.0/24
> - 📋 **Status:** Aktywny (problem z WAN - 2025-11-22)

## 🌐 Konfiguracja sieciowa
> [!info] Parametry sieciowe
> - 📍 **IP LAN:** 192.168.0.10
> - 🔌 **MAC:** 88:d7:f6:63:40:b8
> - 🌍 **Subnet:** 192.168.0.0/24
> - 🌐 **DHCP Server:** Aktywny (zakres do uzupełnienia)
> - 🔒 **Interfejs webowy:** http://192.168.0.10
> - 🔑 **Login:** admin
> - 🔑 **Hasło:** admin
> - 🚫 **SSH:** Port 22 zamknięty

## 📡 Porty i interfejsy
> [!info] Interfejsy fizyczne
> - 🌐 **WAN/DSL:** Port ADSL/VDSL (RJ11)
> - 🔌 **LAN:** 4× Gigabit Ethernet (RJ45)
> - 📶 **WiFi:** 802.11n (2.4 GHz) - do konfiguracji
> - 🔌 **USB:** 1× USB 2.0 (do drukarki/storage)

## 🔧 Konfiguracja
> [!warning] Wymagane ustawienia do sprawdzenia
> - [ ] Typ połączenia WAN (PPPoE/DHCP/Static)
> - [ ] Dane dostępowe ISP
> - [ ] Ustawienia DNS (primary/secondary)
> - [ ] NAT i przekierowania portów
> - [ ] Firewall rules
> - [ ] QoS settings
> - [ ] WiFi SSID i hasło
> - [ ] Zakres DHCP i rezerwacje IP

## 🔍 Diagnoza - 2025-11-22
> [!warning] Problem z dostępem do internetu
> - ❌ **Status WAN:** Brak routingu do internetu
> - ✅ **Status LAN:** Sieć lokalna działa poprawnie
> - ✅ **Ping do gateway:** OK z urządzeń lokalnych
> - ❌ **Ping z urządzeń do 8.8.8.8:** 100% packet loss
> - 🔧 **Przyczyna:** Problem z połączeniem WAN/ISP lub konfiguracja routingu
> - 📋 **Do sprawdzenia:**
>   - Status połączenia DSL (sync, SNR, attenuation)
>   - Konfiguracja WAN (PPPoE credentials)
>   - Logi systemowe routera
>   - Status z poziomu ISP

## 📊 Urządzenia w sieci
> [!info] Znane hosty
> - **192.168.0.77** - asus_z77 (karinam workstation)
> - **192.168.0.99** - gerc (główny workstation)
> - **Inne** - do zinwentaryzowania

## 🔒 Bezpieczeństwo
> [!warning] Wymagane działania
> - [ ] Zmienić domyślne hasło admin/admin
> - [ ] Włączyć szyfrowanie WiFi (WPA2/WPA3)
> - [ ] Zaktualizować firmware do najnowszej wersji
> - [ ] Skonfigurować firewall rules
> - [ ] Wyłączyć niepotrzebne usługi (UPnP, WPS)
> - [ ] Włączyć logowanie zdarzeń

## 📝 Notatki operacyjne
> [!abstract] Historia urządzenia
> - TODO: Data zakupu i instalacji
> - TODO: Wersja firmware
> - TODO: Historia aktualizacji i zmian konfiguracji
> - TODO: Awarie i naprawy

- [ ] @karinam dodać szczegóły konfiguracji ISP
- [ ] @karinam zinwentaryzować wszystkie urządzenia w sieci
- [ ] @karinam sprawdzić i naprawić połączenie WAN

## 📚 Dokumentacja
> [!info] Linki
> - [ASUS DSL-N16 Support](https://www.asus.com/support/Download-Center/)
> - Instrukcja obsługi: do dodania
> - Backup konfiguracji: do utworzenia

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Utworzono dokumentację routera na podstawie diagnostyki sieci |

## 📁 Podfoldery
- [config/](config/) - Pliki konfiguracyjne i backupy
- [logs/](logs/) - Logi systemowe i diagnostyczne
- [docs/](docs/) - Dokumentacja i instrukcje

## 🔗 Backlinks
- [[network/README]]
- [[usr/karinam/asus_z77/asus_z77]]
- [[gerc]]
- [[EWW-MAP]]
- [[GRAPH-MAP]]
