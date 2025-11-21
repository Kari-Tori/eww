#!/usr/bin/env bash
# File: dev/Playbooks/EWW_Style/eww-doctor.sh
# Author: 
# Created: 
# Updated: 
# Description: Skrypt Bash dla projektu EWW
set -euo pipefail
hdr(){ printf "\n== %s ==\n" "$*"; }

hdr "KDE kolory i styl"
kreadconfig6 --file kdeglobals --group General --key ColorScheme || true
kreadconfig6 --file kdeglobals --group General --key AccentColor || true
kreadconfig6 --file kdeglobals --group General --key AccentColorFromWallpaper || true
kreadconfig6 --file kdeglobals --group General --key UseCustomAccentColor || true
kreadconfig6 --file kdeglobals --group KDE --key widgetStyle || true

hdr "Ikony/Kursor"
kreadconfig6 --file kdeglobals --group Icons --key Theme || true
kreadconfig6 --file kcminputrc --group Mouse --key cursorTheme || true

hdr "QT env"
echo "QT_STYLE_OVERRIDE=${QT_STYLE_OVERRIDE:-}"

hdr "Plasma theme (plasmarc)"
kreadconfig6 --file plasmarc --group Theme --key name || true

hdr "GTK"
for d in "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"; do
  echo "-- $d/settings.ini --"
  [[ -r "$d/settings.ini" ]] && sed -n '1,50p' "$d/settings.ini" || echo "(brak)"
done

hdr "Konsole"
ls "$HOME/.local/share/konsole"/*.colorscheme 2>/dev/null || true
