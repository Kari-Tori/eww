---
version: 0.0.1
tags:
  - #monitors
  - #gerc
  - #display
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "GERC - Monitory"
owner: jakubc
---

# GERC - Monitory

## 🖥️ Monitor główny

### Samsung 65" TV
- **Model:** Samsung 65" (TODO: dokładny model)
- **Typ:** TV LED 4K
- **Rozdzielczość:** 3840×2160 (4K UHD)
- **Połączenie:** HDMI (GTX 980 Ti GPU1)
- **Status:** Aktywny
- **Audio out:** HDMI → Sony Soundbar

📄 Szczegóły: [samsung-65-tv.md](samsung-65-tv.md)

## 🖥️ Monitor pomocniczy

### Dell U2520D (?)
- **Model:** TODO: weryfikacja
- **Rozdzielczość:** TODO
- **Połączenie:** DisplayPort (GTX 980 Ti GPU1)
- **Status:** TODO: weryfikacja czy podłączony

📄 Szczegóły: [dell-u2520d.md](dell-u2520d.md)

## 🔌 Konfiguracja multi-display

```
┌─────────────────┐
│   GTX 980 Ti    │
│     (GPU1)      │
└────────┬────────┘
         │
         ├─[HDMI]────────► Samsung 65" TV (Primary)
         │                 │
         │                 └─[HDMI ARC]─► Sony Soundbar
         │
         └─[DisplayPort]─► Dell U2520D (Secondary)
```

## ✅ Zadania

- [ ] Dodać dokładny model Samsung TV
- [ ] Zweryfikować model Dell monitor
- [ ] Dodać numery seryjne
- [ ] Udokumentować konfigurację xrandr/display settings
- [ ] Zrobić zdjęcia setup

## 📝 Notatki

- TV Samsung służy jako główny monitor i centrum multimedialne
- Soundbar podłączony przez HDMI ARC dla lepszego audio
- Konfiguracja audio udokumentowana w [[gerc/gerc]] sekcja Audio

## 🔗 Backlinks

- [[docs/infra/hardware/gerc/accessories/monitors/monitors]]
- [[docs/docs]]
- [[INDEX]]