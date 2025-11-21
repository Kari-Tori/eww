---
id: sb-yaml
title: YAML frontmatter
type: spec/standard
status: draft
owner: Jakub
tags:
  - yaml
  - metadata
  - secondbrain
  - personal
  - blue
  - jakubc
created: 2025-10-27
updated: 2025-11-21
aliases: [YAML frontmatter]
linter-yaml-title-alias: YAML frontmatter
date created: poniedziałek, październik 27. 2025, 1:46:36 pm
date modified: poniedziałek, październik 27. 2025, 1:48:01 pm
color: blue
---

# YAML frontmatter

## Cel
Frontmatter to API między Obsidian, Odoo, Secondbrain i modułami AI.

## Minimalny szablon

```yaml
---
id: eww-asset-iphone11-2025-10-27
title: iPhone 11 intake
type: asset/device
status: intake
owner: Karina
priority: normal
location: EWW/Szafka_Technika/Telefony
tags:
  - eww
  - phone
  - intake
created: 2025-10-27
updated: 2025-10-27
odoo_id: PROD-IPH11-001
serial: FCGH12345
ai_vectors: true
---
```

## Kluczowe pola
- id: unikalny identyfikator rekordu.
- title: nazwa czytelna dla człowieka.
- type: klasa obiektu. Przykład asset/device, incident, procedure, sop, research.
- status: etap procesu. Przykład intake, diagnostic, ready_for_sale, sold.
- owner: osoba odpowiedzialna.
- location: fizyczne położenie lub VM.
- tags: klasyfikacja domenowa.
- created i updated: kontrola wersji czasowej.
- odoo_id: powiązanie ERP.
- serial: numer seryjny sprzętu gdy dotyczy.
- ai_vectors: flaga czy ta notatka ma trafić do indeksu wektorowego.

## Zasady
- YAML zawsze na początku pliku.
- Po YAML pusta linia i dopiero treść.
- Żadne pole nie może być opisane tylko w tekście jeśli może być opisane w YAML. Przykład status, lokalizacja.
