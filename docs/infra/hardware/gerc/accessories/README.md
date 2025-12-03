---
version: 0.0.1
tags:
  - #accessories
  - #gerc
  - #peripherals
  - #folder_note
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "GERC - Akcesoria i peryferia"
parent_device: gerc
owner: jakubc
---

# GERC - Akcesoria i peryferia

Folder zawiera dokumentację wszystkich akcesoriów i peryferiów podłączonych do workstation GERC.

## 🖥️ Monitory

- **Samsung 65" TV** - Monitor główny (4K, HDMI)
- **Dell U2520D** - Monitor pomocniczy (TODO: weryfikacja modelu)
- Konfiguracja: Multi-display setup

📁 Szczegóły: [monitors/](monitors/)

## 🔊 Audio

- **Sony Soundbar** - Główne wyjście audio (HDMI z TV)
- **Słuchawki** - Do cichej pracy (TODO: model)

📁 Szczegóły: [audio/](audio/)

## ⌨️ Input Devices

- **Klawiatura** - TODO: model (Logitech?)
- **Mysz** - TODO: model (Logitech?)

📁 Szczegóły: [input/](input/)

## 🔌 Inne akcesoria

- **Webcam** - TODO: model
- **USB Hub** - TODO: model
- **Inne** - do zinwentaryzowania

📁 Szczegóły: [other/](other/)

## 📊 Konfiguracja

### Routing wideo
```
GERC GPU1 (GTX 980 Ti slot 1)
├── HDMI → Samsung 65" TV (primary)
└── DisplayPort → Dell U2520D (secondary)

GERC GPU2 (GTX 980 Ti slot 2)
└── (dostępne porty)
```

### Routing audio
```
HDMI → Samsung TV → Sony Soundbar (główne)
Onboard audio → Słuchawki (alternatywne)
```

## ✅ Zadania

- [ ] @karinam zinwentaryzować wszystkie monitory (modele, SN)
- [ ] @karinam dodać model klawiatury i myszy
- [ ] @karinam sprawdzić webcam i USB hub
- [ ] @karinam zrobić zdjęcia setup
- [ ] @jakubc udokumentować konfigurację PulseAudio

## 🔗 Powiązane

- [[gerc/gerc]] - Komputer macierzysty
- [[areas/workshop/layout]] - Rozmieszczenie fizyczne
- [[gerc/ops/]] - Historia zmian setup

## 📝 Historia zmian

| Data | Zmiana |
| --- | --- |
| 2025-11-22 | Utworzono strukturę accessories dla GERC |

## 🔗 Backlinks

- [[docs/infra/hardware/gerc/accessories/accessories]]
- [[docs/docs]]
- [[INDEX]]