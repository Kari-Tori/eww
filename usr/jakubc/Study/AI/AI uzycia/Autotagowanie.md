---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "Autotagowanie i aktualizacja YAML"






owner: jakubc
---

# Autotagowanie i aktualizacja YAML

## Cel
Automatyczne uzupełnianie metadanych tak aby użytkownik nie musiał pamiętać o ręcznym tagowaniu.

## Wejście
- Obiekt parsera.
- Kontekst z indeksu i z wektorów. Na przykład wiemy że coś podobnego było już oznaczone jako incident albo bastion/network.

## Wyjście
- Propozycja zmian w YAML dla danej notatki. Przykład
  - status: diagnostic
  - tags: ["eww", "phone", "battery", "charging_issue"]
  - location: "EWW/Stół_DIAG"
  - owner: "Karina"

## Zakres działania
- Rozpoznanie klasy obiektu
  - telefon
  - laptop
  - karta graficzna
  - VM
  - router
  - proces infrastrukturalny typu backup
- Rozpoznanie etapu procesu
  - intake
  - diagnostic
  - ready_for_sale
  - sold
  - shipped
- Rozpoznanie krytyczności
  - incident
  - backup_required
  - security_sensitive

## Aktualizacja
Dwie strategie:

1. Tryb automatyczny
   - AI modyfikuje YAML w pliku bez pytania.
   - Użyte przy notatkach niskiego ryzyka typu intake sprzętu.

2. Tryb propozycji
   - AI tworzy diff YAML i oznacza notatkę jako pending_review.
   - Człowiek akceptuje.

## Efekt biznesowy
- Spójne tagi.
- Stałe słownictwo procesu.
- Odoo, Obsidian i Secondbrain patrzą na te same pola status i owner.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
