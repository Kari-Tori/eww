#!/usr/bin/env bash
# File: dev/Playbooks/EWW_Style/eww-rollback.sh
# Author: 
# Created: 
# Updated: 
# Description: Skrypt Bash dla projektu EWW
set -euo pipefail

kwriteconfig6 --file kdeglobals --group General --key AccentColorFromWallpaper true || true
kwriteconfig6 --file kdeglobals --group General --key UseCustomAccentColor false || true
kwriteconfig6 --file kdeglobals --group General --key ColorScheme BreezeDark || true
kwriteconfig6 --file kdeglobals --group KDE     --key colorScheme BreezeDark || true
kwriteconfig6 --file kdeglobals --group KDE     --key widgetStyle Breeze || true
kwriteconfig6 --file kdeglobals --group Icons   --key Theme breeze || true
kwriteconfig6 --file kcminputrc --group Mouse   --key cursorTheme Breeze || true

rm -f "$HOME/.config/plasma-workspace/env/99-eww-qt-style.sh" 2>/dev/null || true
rm -f "$HOME/.config/environment.d/99-eww-qt-style.conf" 2>/dev/null || true

for d in "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"; do
  mkdir -p "$d"
  cat > "$d/settings.ini" <<GTK
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Breeze-Dark
gtk-icon-theme-name=breeze
gtk-cursor-theme-name=Breeze
GTK
done

qdbus6 org.kde.KGlobalSettings /KGlobalSettings reparseConfiguration 2>/dev/null || true
kbuildsycoca6 >/dev/null 2>&1 || true
kquitapp6 plasmashell >/dev/null 2>&1 || true
(kstart6 plasmashell >/dev/null 2>&1 || plasmashell --replace >/dev/null 2>&1 &) || true

echo "Rollback wykonany."
