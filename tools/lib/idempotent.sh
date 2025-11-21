#!/usr/bin/env bash
# File: lib/idempotent.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
set -Euo pipefail

ts() { date '+%F %T'; }
log() { printf '%s %s\n' "$(ts)" "$*"; }
ok() { log "OK   $*"; }
chg() { log "CHG  $*"; }
skp() { log "SKIP $*"; }
run() {
	log "RUN  $*"
	"$@"
}

_sha() { [[ -f "$1" ]] && sha256sum "$1" | awk '{print $1}' || echo ""; }

# Zapewnij blokadę dla zadania
ensure_lock() {
	local name="${1:-job}"
	local dir="${XDG_RUNTIME_DIR:-$HOME/.cache}/eww/locks"
	mkdir -p "$dir"
	exec {__eww_lock_fd}>"$dir/$name.lock"
	flock -n "${__eww_lock_fd}" || {
		log "JUŻ URUCHOMIONE $name"
		exit 0
	}
	ok "blokada $name uzyskana"
}

# Zapewnij istnienie katalogu z odpowiednimi uprawnieniami
ensure_dir() {
	local path="$1" mode="${2:-0755}" owner="${3:-$(id -un)}" group="${4:-$(id -gn)}"
	if [[ -d "$path" ]]; then
		chmod "$mode" "$path" 2>/dev/null || true
		chown "$owner:$group" "$path" 2>/dev/null || true
		ok "katalog $path istnieje"
	else
		install -d -m "$mode" -o "$owner" -g "$group" "$path"
		chg "katalog $path utworzony"
	fi
}

# Zapewnij plik z określoną zawartością
ensure_file() {
	local path="$1" content="$2" mode="${3:-0644}" owner="${4:-$(id -un)}" group="${5:-$(id -gn)}"
	local tmp
	tmp="$(mktemp)"
	printf '%s' "$content" >"$tmp"
	local want cur
	want="$(_sha "$tmp")"
	cur="$(_sha "$path")"
	if [[ "$want" != "$cur" ]]; then
		install -D -m "$mode" -o "$owner" -g "$group" "$tmp" "$path"
		chg "plik $path zaktualizowany"
	else
		rm -f "$tmp"
		ok "plik $path już w żądanym stanie"
	fi
}

# Zapewnij obecność linii w pliku
ensure_line() {
	local path="$1" line="$2" mode="${3:-0644}"
	touch "$path"
	if grep -Fxq "$line" "$path"; then
		ok "linia obecna w $path"
	else
		printf '%s\n' "$line" >>"$path"
		chmod "$mode" "$path" 2>/dev/null || true
		chg "linia dodana do $path"
	fi
}

# Zapewnij dowiązanie symboliczne
ensure_symlink() {
	local target="$1" link="$2"
	local cur=""
	[[ -L "$link" ]] && cur="$(readlink -f "$link" || true)"
	local tgt
	tgt="$(readlink -f "$target" || echo "$target")"
	if [[ "$cur" == "$tgt" ]]; then
		ok "dowiązanie $link -> $target ok"
	else
		ln -sfn "$target" "$link"
		chg "dowiązanie $link -> $target"
	fi
}

# Zapewnij zainstalowany pakiet (tylko Debian/Ubuntu)
ensure_pkg() {
	command -v apt-get >/dev/null 2>&1 || {
		skp "ensure_pkg: system nie-Debian"
		return 0
	}
	local updated="${EWW_APT_UPDATED:-0}"
	for p in "$@"; do
		if dpkg -s "$p" >/dev/null 2>&1; then
			ok "pakiet $p obecny"
		else
			if [[ "$updated" -eq 0 ]]; then
				run sudo apt-get update -y
				updated=1
				export EWW_APT_UPDATED=1
			fi
			run sudo apt-get install -y "$p"
			chg "pakiet $p zainstalowany"
		fi
	done
}

# Zapewnij włączenie i uruchomienie usługi systemd
ensure_service_enabled() {
	local svc="$1"
	if systemctl is-enabled "$svc" >/dev/null 2>&1; then
		ok "usługa $svc włączona"
	else
		run sudo systemctl enable --now "$svc"
		chg "usługa $svc włączona i uruchomiona"
	fi
}
