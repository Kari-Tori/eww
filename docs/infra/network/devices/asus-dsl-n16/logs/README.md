---
tags:
  - #logs
  - #router
  - #diagnostyka
created: 2025-11-22T17:18:00Z
modified: 2025-11-22T17:18:00Z
author: jakubc
title: "Logi ASUS DSL-N16"
owner: jakubc
---

# Logi ASUS DSL-N16

Folder zawiera logi systemowe i diagnostyczne routera.

## 📋 Typy logów

- System logs (logi ogólne)
- DSL connection logs (logi połączenia DSL)
- Firewall logs
- DHCP logs
- WiFi connection logs

## 🔧 Jak pobrać logi

1. Zaloguj się do http://192.168.0.10
2. Przejdź do: System Log
3. Wybierz zakładkę z odpowiednim typem logu
4. Skopiuj zawartość lub zrób screenshot
5. Zapisz jako: `log-TYPE-YYYY-MM-DD.txt`

## 📊 Znane problemy (2025-11-22)

### Brak dostępu do internetu
- Status: Aktywny problem
- Symptom: Brak routingu WAN
- Do sprawdzenia w logach:
  - DSL sync status
  - PPPoE authentication
  - WAN connection errors
  - NAT table issues

## 📝 Lista plików

*Brak logów - do zebrania podczas diagnozy*

- [ ] Pobrać logi DSL connection
- [ ] Pobrać system logs
- [ ] Sprawdzić logi firewall
