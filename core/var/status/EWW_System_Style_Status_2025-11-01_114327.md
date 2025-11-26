---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T20:00:00Z
modified: 2025-11-21T20:00:00Z
author: jakubc
title: "🖌️ E-Waste Workshop — stan stylu systemu (Kubuntu/Plasma)"






owner: jakubc
---

# 🖌️ E-Waste Workshop — stan stylu systemu (Kubuntu/Plasma)

> **Baseline:** bezpieczny Breeze Dark + Breeze ikony + (na razie) brak wymuszonego AccentColor z CLI. Terminal z własnym schematem **EWW-Dark**.

## ✅ Aktywne teraz
- **Look & Feel:** `Breeze Dark` (`org.kde.breezedark.desktop`)
- **Schemat kolorów:** `BreezeDark`
- **Accent:** *(pusty/domyslny — ustawiany z GUI, nie przez CLI)*
- **Ikony:** `breeze`
- **Kursor:** `breeze_cursors`
- **Konsole (terminal):** `EWW-Dark` — plik: `~/.local/share/konsole/EWW-Dark.colorscheme`
- **KWin (stabilność):**
  - `blurEnabled = false`
  - `backgroundcontrastEnabled = false`
- **GTK (spójność):**
  - `~/.config/gtk-3.0/settings.ini`
  - `~/.config/gtk-4.0/settings.ini`
  - `gtk-theme-name=Breeze`, `gtk-icon-theme-name=breeze`, `gtk-application-prefer-dark-theme=1`

## 📦 Zainstalowane / zmienione elementy
- Czcionki: `fonts-inter`, `fonts-jetbrains-mono`
- Terminal: schemat **EWW-Dark** (własny)
- (Opcjonalnie dostępne) **Tela** icon theme — pobrane, **nie** ustawione jako domyślne

## 🚫 Świadomie nieaktywne
- Zewnętrzne „Global Themes” (Catppuccin/Tokyo Night/Orchis/Layan) — **nieaktywne**
- `papirus-icon-theme` / `papirus-folders` — **odrzucone** (źródło niestabilności)
- Custom `.colors` dla całej Plasmy — **wycofane** (powodowało crash powłoki)

## 🔎 Weryfikacja (kopiuj → wklej)
```bash
echo "L&F:        BreezeDark expected"
echo "Scheme:     $(kreadconfig6 --file kdeglobals --group General --key ColorScheme)"
echo "Accent:     $(kreadconfig6 --file kdeglobals --group General --key AccentColor)"
echo "Icons:      $(kreadconfig6 --file kdeglobals --group Icons --key Theme)"
echo "Cursor:     $(kreadconfig6 --file kcminputrc  --group Mouse   --key cursorTheme)"
test -f ~/.local/share/konsole/EWW-Dark.colorscheme && echo "Konsole: EWW-Dark OK" || echo "Konsole: brak"
```

## 📝 Notatki operacyjne
- Zmianę **AccentColor** wykonuj z **GUI**: *Ustawienia → Wygląd → Kolory → Akcent* (CLI potrafi u Ciebie rozhuśtać sesję i audio).
- Jeśli zechcesz przetestować **Tela-dark** tylko jako ikony, dam krótki blok „apply/revert” bez dotykania reszty środowiska.
