#!/usr/bin/env bash
# File: dev/Playbooks/EWW_Style/eww-installer.sh
# Author: 
# Created: 
# Updated: 
# Description: UI
set -Eeuo pipefail
[[ ${EWW_DEBUG:-0} -eq 1 ]] && set -x
umask 022
export LC_ALL=C.UTF-8 LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
VERSION="1.3.2"
MAIN_PID=$$

# UI
if [[ ${EWW_NO_COLOR:-0} -eq 1 ]]; then NC=0; elif [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then NC=$(tput colors||echo 0); else NC=0; fi
if [[ ${NC:-0} -ge 8 ]]; then BOLD=$(tput bold); DIM=$(tput dim); RESET=$(tput sgr0); RED=$(tput setaf 1); GREEN=$(tput setaf 2); YEL=$(tput setaf 3); BLUE=$(tput setaf 4); else BOLD=; DIM=; RESET=; RED=; GREEN=; YEL=; BLUE=; fi
ICON_OK=✅; ICON_FAIL=❌; ICON_WARN=⚠️; ICON_RUN=⏳; ICON_INFO=🛈
section(){ printf "\n%s\n▶ %s\n%s\n" "────────────────────────────────────────" "$*" "────────────────────────────────────────"; }
_box(){ local T=$1; shift; local title=$1; shift; local C= icon=; local P="${EWW_BOX_PAUSE:-0}"; case $T in INFO) C=$BLUE; icon=$ICON_INFO;; OK) C=$GREEN; icon=$ICON_OK;; WARN) C=$YEL; icon=$ICON_WARN;; FAIL) C=$RED; icon=$ICON_FAIL;; esac; local bar=────────────────────────────────────────────────────────
  printf '%b┌%s┐%b\n' "$C" "$bar" "$RESET"; [[ "$P" != 0 && "$P" != 0.0 ]] && sleep "$P"
  printf '%b│ %s %s%b\n' "$C" "$icon" "$title" "$RESET"; [[ "$P" != 0 && "$P" != 0.0 ]] && sleep "$P"
  printf '%b├%s┤%b\n' "$C" "$bar" "$RESET"
  if [[ $# -gt 0 ]]; then while IFS= read -r l; do printf '%b│ %s%b\n' "$C" "$l" "$RESET"; [[ "$P" != 0 && "$P" != 0.0 ]] && sleep "$P"; done <<<"$(printf '%s\n' "$@")"; fi
  printf '%b└%s┘%b\n' "$C" "$bar" "$RESET"; }
box_info(){ _box INFO "$1" "${2:-}"; }; box_ok(){ _box OK "$1" "${2:-}"; }; box_fail(){ _box FAIL "$1" "${2:-}"; }; msg(){ printf "%b\n" "$*"; }

# Artefakty
LOG_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/eww-installer"; STAMP=$(date +%F_%H%M%S); LOG_FILE="$LOG_DIR/run_$STAMP.log"; VERS_FILE="$LOG_DIR/versions_$STAMP.txt"
mkdir -p "$LOG_DIR"; :>"$LOG_FILE"; :>"$VERS_FILE"; exec 3>>"$LOG_FILE"
note_reset(){ : >"$LOG_DIR/.last_summary" 2>/dev/null || true; }; note(){ printf '%s\n' "$*" >>"$LOG_DIR/.last_summary" 2>/dev/null || true; }; note_get(){ [[ -r "$LOG_DIR/.last_summary" ]] && cat "$LOG_DIR/.last_summary" || true; }

# Sudo/KDE helpers
is_root(){ [[ ${EUID:-$(id -u)} -eq 0 ]]; }
SUDO=""; if ! is_root && command -v sudo >/dev/null 2>&1; then SUDO=sudo; fi
have_tty(){ [[ -t 0 ]]; }
require_user_context(){ if is_root && [[ ${EWW_ALLOW_ROOT:-0} -ne 1 ]]; then echo "Uruchom jako zwykły użytkownik (EWW_ALLOW_ROOT=1 aby wymusić)"; return 1; fi; }
sudo_keep(){ [[ -z $SUDO ]] && return 0; if $SUDO -n true 2>/dev/null; then ( exec >/dev/null 2>&1 < /dev/null; while sleep 60; do $SUDO -n true 2>/dev/null || exit; kill -0 "$MAIN_PID" 2>/dev/null || exit; done ) & SUDO_KEEP_PID=$!; note "sudo_keep: PID=$SUDO_KEEP_PID"; else note "sudo_keep: brak cache"; fi; }
sudo_prep(){ [[ -z $SUDO ]] && { note "sudo_prep: brak sudo/root"; return 0; }; [[ ${EWW_SUDO_OPTIONAL:-0} -eq 1 ]] && { note "sudo_prep: opcjonalny"; return 0; }; if $SUDO -n true 2>/dev/null; then note "sudo_prep: cache OK"; return 0; fi; if have_tty; then local t=${EWW_SUDO_TIMEOUT:-25}; if command -v timeout >/dev/null 2>&1; then timeout "$t" $SUDO -v && note "sudo_prep: cache (t=$t)" || note "sudo_prep: timeout ${t}s"; else $SUDO -v && note "sudo_prep: cache OK" || note "sudo_prep: FAIL"; fi; else note "sudo_prep: brak TTY"; fi; }

kw(){ local t; t=$(command -v kwriteconfig6 || command -v kwriteconfig5 || true); [[ -n $t ]] || return 1; "$t" "$@"; }
kr(){ local t; t=$(command -v kreadconfig6  || command -v kreadconfig5  || true);  [[ -n $t ]] || return 1; "$t" "$@"; }
reload_plasma(){ command -v plasmashell >/dev/null 2>&1 || return 0; kbuildsycoca6 >/dev/null 2>&1 || kbuildsycoca5 >/dev/null 2>&1 || true; kquitapp6 plasmashell >/dev/null 2>&1 || kquitapp5 plasmashell >/dev/null 2>&1 || true; (kstart6 plasmashell >/dev/null 2>&1 || kstart5 plasmashell >/dev/null 2>&1 || plasmashell --replace >/dev/null 2>&1 &) || true; sleep 1; }

# Runner/trapy
STEP_I=0; STEP_N=16
run(){ local title=$1; shift; local fn=$1; shift || true; STEP_I=$((STEP_I+1)); local prefix="[$(printf %02d "$STEP_I")/$(printf %02d "$STEP_N")]"; local start=$(date +%s); msg "${DIM}${ICON_RUN} ${prefix} ${title}${RESET}"; sleep "${EWW_STEP_PAUSE:-0}"; local rc=0; note_reset; ( "$fn" "$@" ) 2>&1 | tee -a "$LOG_FILE" || rc=${PIPESTATUS[0]}; local dur=$(( $(date +%s) - start )); local notes; notes=$(note_get); if [[ $rc -eq 0 ]]; then box_ok "$title" "czas: $((dur/60))m$((dur%60))s"$'\\n'"${notes}"; else box_fail "$title" "rc=$rc • log: $LOG_FILE"$'\\n'"${notes}"; fi; return $rc; }
cleanup(){ [[ -n ${SUDO_KEEP_PID:-} ]] && kill $SUDO_KEEP_PID 2>/dev/null || true; }
trap 'rc=$?; cleanup; [[ $rc -eq 0 ]] || box_fail "BŁĄD GLOBALNY" "rc=$rc • patrz: $LOG_FILE"; exit $rc' EXIT
trap 'cleanup; echo; box_fail "PRZERWANO" "Log: $LOG_FILE"; exit 130' INT
[[ ${EWW_TRAP_ERR:-1} -eq 1 ]] && trap 'box_fail "BŁĄD (ERR)" "rc=$? • krok: ${STEP_I:-?} • log: $LOG_FILE"' ERR || true

# APT/Git/Download
APT_OPTS=( -o Acquire::Retries=3 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 -o APT::Get::Assume-Yes=true -o Dpkg::Use-Pty=0 )
retry(){ local n=${1:-3}; shift; local i rc; for ((i=1;i<=n;i++)); do { "$@" ; } && return 0 || rc=$?; sleep $((i*i)); done; return $rc; }
detect_pkg(){ if command -v apt-get >/dev/null 2>&1; then PKG=apt; else echo "Wymagany APT/Kubuntu"; exit 1; fi; }
pkg_update(){ retry 3 ${SUDO:-} apt-get "${APT_OPTS[@]}" update; }
pkg_install(){ local pkgs=("$@"); retry 3 ${SUDO:-} apt-get "${APT_OPTS[@]}" install -y "${pkgs[@]}"; }
_dl(){ local url=$1 out=$2; mkdir -p "$(dirname "$out")"; echo "DL  $url -> $out"
  if command -v aria2c >/dev/null 2>&1; then aria2c -x16 -s16 -k1M --summary-interval=1 --console-log-level=notice -o "$(basename "$out")" -d "$(dirname "$out")" "$url" | tee -a "$LOG_FILE" || return 1
  else curl -fL --retry 3 --retry-delay 2 --progress-bar -o "$out" "$url" 2>&1 | tee -a "$LOG_FILE" || return 1; fi
  local sz=$(stat -c%s "$out" 2>/dev/null||echo 0); [[ $sz -gt 0 ]] || { echo "ERR size=0" | tee -a "$LOG_FILE"; return 1; }; echo "OK  ${sz} B" | tee -a "$LOG_FILE"; }
GH(){ curl -fsSL "$1"; }
latest_asset(){ local repo=$1 rx=$2; GH "https://api.github.com/repos/$repo/releases/latest" | jq -r --arg rx "$rx" '.assets[]? | select(.name|test($rx)) | .browser_download_url' | head -n1; }
git_safe(){ local url=$1 dst=$2 branch=${3:-}; local path="${url#https://github.com/}"; path="${path%.git}"; if [[ -d "$dst/.git" ]]; then git -C "$dst" fetch --depth=1 origin ${branch:+$branch} || true; git -C "$dst" reset --hard ${branch:+origin/$branch} || true; return 0; fi; if git clone --depth=1 ${branch:+-b "$branch"} "$url" "$dst"; then return 0; fi; local tmp; tmp=$(mktemp -d); for b in "${branch:-main}" master; do local zip="https://codeload.github.com/$path/zip/refs/heads/$b"; _dl "$zip" "$tmp/repo.zip" || continue; unzip -q "$tmp/repo.zip" -d "$tmp" || continue; local top="$tmp/$(basename "$path")-$b"; [[ -d $top ]] || continue; rm -rf "$dst"; mkdir -p "$(dirname "$dst")"; mv "$top" "$dst"; return 0; done; return 1; }

# Colors
hex_to_rgb(){ local h=${1#\\#}; printf "%d,%d,%d" 0x${h:0:2} 0x${h:2:2} 0x${h:4:2}; }
validate_hex(){ [[ "$1" =~ ^#?[0-9A-Fa-f]{6}$ ]]; }

# Steps
step_pkgs(){ pkg_install curl jq git unzip tar dos2unix aria2 software-properties-common ca-certificates qt5-style-kvantum qt6-style-kvantum kvantum-manager sddm plymouth-themes bibata-cursor-theme papirus-icon-theme papirus-folders || true; note "Pakiety: zainstalowane (best-effort)"; }
step_icons(){ command -v papirus-folders >/dev/null 2>&1 && { ${SUDO:-} papirus-folders -C "${EWW_PAPIRUS_ACCENT:-green}" --theme Papirus-Dark || true; }; kw --file kdeglobals --group Icons --key Theme Papirus-Dark || true; qdbus6 org.kde.KGlobalSettings /KGlobalSettings reparseConfiguration 2>/dev/null || true; note "Papirus-Dark ustawiony"; }
step_cursor(){ mkdir -p "$HOME/.icons/default"; cat > "$HOME/.icons/default/index.theme" <<'EOF'
[Icon Theme]
Inherits=Bibata-Modern-Classic
EOF
command -v plasma-apply-cursortheme >/dev/null 2>&1 && plasma-apply-cursortheme Bibata-Modern-Classic || true; note "Kursor Bibata"; }
step_kde(){ local repo=catppuccin/kde dst="$HOME/.local/share/eww/catppuccin-kde"; mkdir -p "$dst"; git_safe https://github.com/$repo "$dst"; mkdir -p "$HOME/.local/share/color-schemes" "$HOME/.config/Kvantum"; cp -rf "$dst"/KDE/* "$HOME/.local/share/" 2>/dev/null || true; cp -rf "$dst"/Kvantum/* "$HOME/.config/Kvantum/" 2>/dev/null || true; command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Catppuccin-Mocha || true; kw --file kdeglobals --group KDE --key widgetStyle kvantum || true; note "Catppuccin + Kvantum"; }
step_palette(){ local ACC_HEX_RAW="${EWW_ACCENT_HEX:-#00E676}" TECH_HEX_RAW="${EWW_TECH_HEX:-#00B4FF}"; local ACC_HEX TECH_HEX ACC_RGB TECH_RGB; [[ "$ACC_HEX_RAW" == \\#* ]] && ACC_HEX="$ACC_HEX_RAW" || ACC_HEX="#$ACC_HEX_RAW"; [[ "$TECH_HEX_RAW" == \\#* ]] && TECH_HEX="$TECH_HEX_RAW" || TECH_HEX="#$TECH_HEX_RAW"; validate_hex "$ACC_HEX" || ACC_HEX="#00E676"; validate_hex "$TECH_HEX" || TECH_HEX="#00B4FF"; ACC_RGB=$(hex_to_rgb "$ACC_HEX"); TECH_RGB=$(hex_to_rgb "$TECH_HEX"); local csdir="$HOME/.local/share/color-schemes"; mkdir -p "$csdir"; if [[ -r "$(dirname "$0")/palettes/EWW-Workshop.colors" ]]; then cp "$(dirname "$0")/palettes/EWW-Workshop.colors" "$csdir/EWW-Workshop.colors"; else cat > "$csdir/EWW-Workshop.colors" <<EOF
[General]
Name=EWW-Workshop
[Colors:Window]
BackgroundNormal=12,16,18
ForegroundNormal=224,230,233
DecorationFocus=$ACC_RGB
DecorationHover=$ACC_RGB
ForegroundLink=$TECH_RGB
ForegroundVisited=140,200,255
[Colors:View]
BackgroundNormal=12,16,18
BackgroundAlternate=16,20,22
ForegroundNormal=224,230,233
ForegroundInactive=179,188,194
ForegroundLink=$TECH_RGB
[Colors:Button]
BackgroundNormal=22,26,30
BackgroundAlternate=26,30,34
ForegroundNormal=229,233,240
ForegroundPositive=80,250,123
ForegroundNegative=250,82,82
ForegroundNeutral=255,212,59
[Colors:Selection]
BackgroundNormal=$TECH_RGB
ForegroundNormal=8,12,14
[Colors:Tooltip]
BackgroundNormal=18,22,24
ForegroundNormal=229,233,240
[Colors:Header]
BackgroundNormal=10,14,16
ForegroundNormal=229,233,240
DecorationFocus=$ACC_RGB
[Colors:Complementary]
BackgroundNormal=16,22,24
ForegroundNormal=220,228,232
EOF
fi
kw --file kdeglobals --group General --key AccentColor "$(hex_to_rgb "$ACC_HEX")" || true
kw --file kdeglobals --group General --key AccentColorFromWallpaper false || true
kw --file kdeglobals --group General --key UseCustomAccentColor true || true
kw --file kdeglobals --group General --key ColorScheme EWW-Workshop || true
kw --file kdeglobals --group KDE     --key colorScheme EWW-Workshop || true
kw --file kdeglobals --group Icons   --key Theme Papirus-Dark || true
kw --file kcminputrc --group Mouse   --key cursorTheme Bibata-Modern-Classic || true
for d in "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"; do mkdir -p "$d"; cat > "$d/settings.ini" <<GTK
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Breeze-Dark
gtk-icon-theme-name=Papirus-Dark
gtk-cursor-theme-name=Bibata-Modern-Classic
GTK
done
command -v plasma-apply-colorscheme >/dev/null 2>&1 && plasma-apply-colorscheme EWW-Workshop >/dev/null 2>&1 || true
qdbus6 org.kde.KGlobalSettings /KGlobalSettings reparseConfiguration 2>/dev/null || true
[[ ${EWW_RELOAD_AFTER_PALETTE:-1} -eq 1 ]] && reload_plasma || true
note "Paleta: Accent=$ACC_HEX Tech=$TECH_HEX"; }
step_plasma(){ local plasma="${EWW_PLASMA_THEME:-catppuccin-mocha}" kv="${EWW_KVANTUM_THEME:-Catppuccin-Mocha}" gtk="${EWW_GTK_THEME:-Breeze-Dark}"
case "$plasma" in
  breeze-dark)       command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Breeze-Dark || true ;;
  catppuccin-mocha)  command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Catppuccin-Mocha || true ;;
  tokyonight)        command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme TokyoNight  || true ;;
  nordic)            command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Nordic      || true ;;
  dracula)           command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Dracula     || true ;;
  rose-pine)         command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme RosePine    || true ;;
  fluent)            command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme FluentDark  || true ;;
  sweet)             command -v plasma-apply-desktoptheme >/dev/null 2>&1 && plasma-apply-desktoptheme Sweet       || true ;;
esac
kw --file kdeglobals --group KDE --key widgetStyle kvantum || true
if command -v kvantummanager >/dev/null 2>&1; then kvantummanager --set "$kv" || true; fi
mkdir -p "$HOME/.config/plasma-workspace/env" "$HOME/.config/environment.d"
cat > "$HOME/.config/plasma-workspace/env/99-eww-qt-style.sh" <<'EOF'
export QT_STYLE_OVERRIDE=kvantum
EOF
chmod +x "$HOME/.config/plasma-workspace/env/99-eww-qt-style.sh" 2>/dev/null || true
printf '%s\n' 'QT_STYLE_OVERRIDE=kvantum' > "$HOME/.config/environment.d/99-eww-qt-style.conf"
for d in "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"; do mkdir -p "$d"; awk -v t="$gtk" 'BEGIN{print "[Settings]\ngtk-application-prefer-dark-theme=1\ngtk-theme-name=" t}' >"$d/settings.ini"; done
qdbus6 org.kde.KGlobalSettings /KGlobalSettings reparseConfiguration 2>/dev/null || true
systemctl --user daemon-reload >/dev/null 2>&1 || true
note "Plasma=${plasma} Kvantum=${kv} GTK=${gtk}"; }
step_sddm(){ [[ ${EWW_ENABLE_SDDM:-0} -eq 1 ]] || { note "SDDM pominięty"; return 0; }
local repo=MarianArlt/sddm-sugar-candy theme=sugar-candy dir=/usr/share/sddm/themes/$theme tmp=$(mktemp -d)
pkg_install sddm || true
[[ -d $dir ]] || { git_safe https://github.com/$repo "$tmp/$theme"; ${SUDO:-} mkdir -p "/usr/share/sddm/themes"; ${SUDO:-} cp -r "$tmp/$theme" "$dir" || true; }
${SUDO:-} mkdir -p /etc/sddm.conf.d
${SUDO:-} tee /etc/sddm.conf.d/10-theme.conf >/dev/null <<EOF
[Theme]
Current=$theme
EOF
${SUDO:-} systemctl enable sddm >/dev/null 2>&1 || true
note "SDDM: $theme"; }
step_plymouth(){ [[ ${EWW_ENABLE_PLYMOUTH:-0} -eq 1 ]] || { note "Plymouth pominięty"; return 0; }
local repo=catppuccin/plymouth name=catppuccin-mocha dest=/usr/share/plymouth/themes/$name dir="$HOME/.local/share/eww/catppuccin-plymouth"
pkg_install plymouth-themes || true
[[ -d $dest ]] || { mkdir -p "$dir"; git_safe https://github.com/$repo "$dir"; ${SUDO:-} mkdir -p "$dest"; ${SUDO:-} cp -r "$dir/themes/$name"/* "$dest" || true; }
${SUDO:-} update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth "$dest/$name.plymouth" 110 || true
${SUDO:-} update-alternatives --set default.plymouth "$dest/$name.plymouth" || true
${SUDO:-} update-initramfs -u || true
note "Plymouth: $name"; }
step_cli_tools(){ pkg_install starship btop lsd fastfetch || true; command -v starship >/dev/null 2>&1 || curl -fsSL https://starship.rs/install.sh | bash -s -- -y || true; note "CLI: starship btop lsd fastfetch"; }
step_cli_cfg(){ mkdir -p "$HOME/.config" "$HOME/.config/btop/themes" "$HOME/.config/lsd"
cat > "$HOME/.config/starship.toml" <<'EOF'
add_newline = false
format = "$all$fill$time$line_break$character"
[fill]
symbol = " "
[time]
format = "[ $time ]"
disabled = false
[character]
success_symbol = "[❯](bold green)"
error_symbol   = "[❯](bold red)"
EOF
curl -fsSL https://raw.githubusercontent.com/catppuccin/btop/main/themes/catppuccin_mocha.theme -o "$HOME/.config/btop/themes/catppuccin_mocha.theme" || true
printf 'theme=catppuccin_mocha\n' >> "$HOME/.config/btop/btop.conf" 2>/dev/null || true
cat > "$HOME/.config/lsd/colors.yaml" <<'EOF'
user: cyan
group: green
permission: yellow
date: white
size: magenta
symlink: blue
EOF
note "CLI cfg zapisane"; }
step_konsole(){ mkdir -p "$HOME/.local/share/konsole"
curl -fsSL https://raw.githubusercontent.com/catppuccin/konsole/main/Catppuccin-Mocha.colorscheme -o "$HOME/.local/share/konsole/Catppuccin-Mocha.colorscheme" || true
if prof=$(ls "$HOME/.local/share/konsole"/*.profile 2>/dev/null | head -n1); then sed -i 's/^ColorScheme=.*/ColorScheme=Catppuccin-Mocha/' "$prof" || true
else
cat > "$HOME/.local/share/konsole/EWW.profile" <<'EOF'
[Appearance]
ColorScheme=Catppuccin-Mocha
[General]
Name=EWW
EOF
fi
note "Konsole: Catppuccin-Mocha"; }
step_fonts(){ pkg_install fonts-jetbrains-mono fonts-firacode fonts-inter || true; mkdir -p "$HOME/.local/share/fonts"
url=$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.assets[]? | select(.name|test("JetBrainsMono.*zip$")) | .browser_download_url' | head -n1) || true
if [[ -n "${url:-}" ]]; then tmp=$(mktemp -d); curl -fsSL "$url" -o "$tmp/jbm.zip" || true; unzip -o "$tmp/jbm.zip" -d "$HOME/.local/share/fonts" >/dev/null || true; fc-cache -f >/dev/null || true; fi
note "Fonty: JBM/FiraCode/Inter (+NerdFonts jeśli dostępne)"; }

verify_palette(){ local have acc from_wp use_custom; have=$(kr --file kdeglobals --group General --key ColorScheme 2>/dev/null||true); acc=$(kr --file kdeglobals --group General --key AccentColor 2>/dev/null||true); from_wp=$(kr --file kdeglobals --group General --key AccentColorFromWallpaper 2>/dev/null||true); use_custom=$(kr --file kdeglobals --group General --key UseCustomAccentColor 2>/dev/null||true); [[ "$have" == "EWW-Workshop" && -n "$acc" && "$from_wp" != "true" ]] || { echo "ColorScheme=$have Accent=$acc FromWallpaper=$from_wp UseCustom=$use_custom"; return 1; }; note "OK: ColorScheme=$have • Accent=$acc • FromWallpaper=$from_wp • UseCustom=$use_custom"; }
verify_files(){ local missing=0; for f in "$HOME/.local/share/color-schemes/EWW-Workshop.colors" "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini" "$HOME/.local/share/konsole/Catppuccin-Mocha.colorscheme" "$HOME/.config/starship.toml"; do [[ -r $f ]] || { echo "brak $f"; missing=1; }; done; ((missing==0)) || return 1; note "OK: pliki kolorów, GTK, Konsole, starship"; }

main(){
  section "Przygotowanie"
  box_info "O instalatorze" "v$VERSION
• PASS/FAIL, log na żywo.
• Log: ${XDG_CACHE_HOME:-$HOME/.cache}/eww-installer
• Pakiet: Catppuccin/Kvantum/Papirus/Bibata/EWW-Workshop + GTK dark."
  detect_pkg
  run "Walidacja kontekstu użytkownika" require_user_context
  run "Sudo preauth" sudo_prep

  section "Pakiety"
  run "Odśwież cache pakietów" pkg_update
  run "Instaluj pakiety bazowe" step_pkgs

  section "Ikony i Kursor"
  run "Papirus + akcent" step_icons
  run "Bibata" step_cursor

  section "Motywy KDE"
  run "KDE: Catppuccin + Kvantum" step_kde

  section "Kolory systemowe + GTK"
  run "Paleta EWW + Accent + GTK" step_palette

  section "Plasma i Qt"
  run "Plasma Theme + Kvantum + GTK fallback" step_plasma

  section "Logowanie i Boot"
  run "SDDM: sugar-candy" step_sddm
  run "Plymouth: Catppuccin Mocha" step_plymouth

  section "CLI"
  run "Narzędzia CLI" step_cli_tools
  run "Konfiguracje CLI" step_cli_cfg

  section "Konsole + Fonty"
  run "Konsole: Catppuccin" step_konsole
  run "Fonty + NerdFonts" step_fonts

  section "Weryfikacja"
  run "Paleta zastosowana" verify_palette
  run "Pliki na miejscu" verify_files

  section "Restart środowiska Plasma"
  run "Restart plasmy" reload_plasma

  section "Podsumowanie"
  _box OK "PODSUMOWANIE" "Log: $(echo ${XDG_CACHE_HOME:-$HOME/.cache}/eww-installer)/run_*.log"
}
main "$@"
