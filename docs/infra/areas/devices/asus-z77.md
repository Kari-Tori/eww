---
tags:
  - #infra
  - #device
  - #computer
  - #asus
  - #z77
  - #karinam
created: 2025-11-22T22:15:00Z
modified: 2025-11-22T22:15:00Z
author: jakubc
owner: jakubc
---

# Asus Z77 (karinam@192.168.0.77)

## Informacje Podstawowe

- **Hostname**: asus_z77
- **IP**: 192.168.0.77
- **Użytkownik**: karinam
- **Typ**: Komputer stacjonarny (Desktop PC)
- **Płyta główna**: ASUS Z77 (chipset Intel Z77)

## Dostęp

- **SSH**: `ssh karinam@192.168.0.77`
- **Hasło SSH**: [Do uzupełnienia]

## Specyfikacja (do uzupełnienia)

### Hardware
- **Płyta główna**: ASUS Z77 Series
- **CPU**: Intel Core i5/i7 (3. generacja - Ivy Bridge) [Do sprawdzenia]
- **RAM**: [Do sprawdzenia]
- **Dysk**: [Do sprawdzenia]
- **GPU**: [Do sprawdzenia]

### System Operacyjny
- **OS**: [Do sprawdzenia - Linux/Windows?]
- **Wersja**: [Do sprawdzenia]
- **Kernel**: [Do sprawdzenia]

## Sieć

- **IP**: 192.168.0.77 (statyczne/DHCP?)
- **MAC**: [Do sprawdzenia]
- **Połączenie**: Ethernet (przewodowe)
- **Gateway**: [[../network/gateway|192.168.0.10 (ASUS DSL-N16)]]

## Problem - Firefox nie wczytuje stron

### Objawy:
- Firefox ma problemy z wczytywaniem stron internetowych
- Data zgłoszenia: 2025-11-22

### Diagnostyka:
- [ ] SSH do karinam@192.168.0.77
- [ ] Sprawdzić łączność z gateway: `ping 192.168.0.10`
- [ ] Sprawdzić łączność z DNS: `ping 8.8.8.8`
- [ ] Sprawdzić rozdzielczość DNS: `nslookup google.com`
- [ ] Sprawdzić konfigurację sieci: `ip addr`, `ip route`
- [ ] Sprawdzić `/etc/resolv.conf`
- [ ] Sprawdzić logi systemowe
- [ ] Sprawdzić czy inne przeglądarki działają (Chrome, Chromium)
- [ ] Sprawdzić ustawienia proxy w Firefox
- [ ] Sprawdzić certyfikaty SSL w Firefox

### Możliwe przyczyny:
1. Problem z DNS (najprawdopodobniejsze)
2. Problem z routingiem
3. Firewall blokuje Firefox
4. Uszkodzona konfiguracja Firefox
5. Problem z certyfikatami SSL
6. Proxy misconfiguration

## Akcesoria / Peryferia

- **Monitor**: [Do uzupełnienia]
- **Klawiatura**: [Do uzupełnienia]
- **Mysz**: [Do uzupełnienia]
- **Inne**: [Do uzupełnienia]

## Zadania

- [ ] SSH do komputera i diagnoza problemu
- [ ] Uzupełnić specyfikację hardware
- [ ] Sprawdzić system operacyjny
- [ ] Rozwiązać problem z Firefox
- [ ] Backup ważnych danych (jeśli potrzebne)
- [ ] Zaktualizować system
- [ ] Dokumentacja akcesoriów

## Notatki

Komputer użytkowany przez Karinę. Płyta główna ASUS Z77 to starszy model (2012), ale wciąż funkcjonalny dla codziennego użytku.

💡 **Chipset Intel Z77**:
- Socket LGA 1155
- Obsługa CPU: Intel Core i3/i5/i7 (2. i 3. generacja)
- Pamięć: DDR3
- USB 3.0, SATA 3.0
- Overclocking (K-series CPU)

## Linki

- [[../network/gateway|Gateway (192.168.0.10)]]
- [[../../../usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/internet|TODO Internet]]
- [[../../../usr/karinam/karinam|Karinam (użytkownik)]]

## Data Dokumentacji

Utworzono: 2025-11-22
