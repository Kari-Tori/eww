---
tags:
  - #config
  - #router
  - #backup
created: 2025-11-22T17:18:00Z
modified: 2025-11-22T17:18:00Z
author: jakubc
title: "Konfiguracja ASUS DSL-N16"
owner: jakubc
---

# Konfiguracja ASUS DSL-N16

Ten folder zawiera pliki konfiguracyjne i backupy ustawień routera ASUS DSL-N16.

## 📋 Backupy konfiguracji

- [ ] Utworzyć regularny backup konfiguracji routera
- [ ] Zapisywać wersjonowane kopie po każdej zmianie
- [ ] Format plików: `.cfg` lub `.xml` z datą w nazwie

## 🔧 Procedura backup

1. Zaloguj się do http://192.168.0.10
2. Przejdź do: Administration → Restore/Save/Upload Setting
3. Kliknij "Save" aby pobrać aktualną konfigurację
4. Zapisz jako: `asus-dsl-n16-backup-YYYY-MM-DD.cfg`
5. Skopiuj do tego folderu

## 📝 Lista plików

*Brak plików konfiguracyjnych - do utworzenia*

## 🔒 Uwagi bezpieczeństwa

> [!warning] Hasła i dane wrażliwe
> - Pliki konfiguracyjne zawierają hasła ISP i WiFi
> - NIE commituj plików backup do publicznego repo
> - Używaj `.gitignore` dla plików `.cfg`
> - Rozważ szyfrowanie backupów

## 🔗 Backlinks

- [[docs/infra/hardware/network/devices/asus-dsl-n16/config/config]]
- [[docs/docs]]
- [[INDEX]]
