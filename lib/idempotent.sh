#!/usr/bin/env bash
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

ensure_lock() {
	local name="${1:-job}"
	local dir="${XDG_RUNTIME_DIR:-$HOME/.cache}/eww/locks"
	mkdir -p "$dir"
	exec {__eww_lock_fd}>"$dir/$name.lock"
	flock -n "${__eww_lock_fd}" || {
		log "ALREADY RUNNING $name"
		exit 0
	}
	ok "lock $name acquired"
}

ensure_dir() {
	local path="$1" mode="${2:-0755}" owner="${3:-$(id -un)}" group="${4:-$(id -gn)}"
	if [[ -d "$path" ]]; then
		chmod "$mode" "$path" 2>/dev/null || true
		chown "$owner:$group" "$path" 2>/dev/null || true
		ok "dir $path exists"
	else
		install -d -m "$mode" -o "$owner" -g "$group" "$path"
		chg "dir $path created"
	fi
}

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
		chg "file $path updated"
	else
		rm -f "$tmp"
		ok "file $path already desired"
	fi
}

ensure_line() {
	local path="$1" line="$2" mode="${3:-0644}"
	touch "$path"
	if grep -Fxq "$line" "$path"; then
		ok "line present in $path"
	else
		printf '%s\n' "$line" >>"$path"
		chmod "$mode" "$path" 2>/dev/null || true
		chg "line added to $path"
	fi
}

ensure_symlink() {
	local target="$1" link="$2"
	local cur=""
	[[ -L "$link" ]] && cur="$(readlink -f "$link" || true)"
	local tgt
	tgt="$(readlink -f "$target" || echo "$target")"
	if [[ "$cur" == "$tgt" ]]; then
		ok "symlink $link -> $target ok"
	else
		ln -sfn "$target" "$link"
		chg "symlink $link -> $target"
	fi
}

ensure_pkg() {
	command -v apt-get >/dev/null 2>&1 || {
		skp "ensure_pkg: non-Debian"
		return 0
	}
	local updated="${EWW_APT_UPDATED:-0}"
	for p in "$@"; do
		if dpkg -s "$p" >/dev/null 2>&1; then
			ok "pkg $p present"
		else
			if [[ "$updated" -eq 0 ]]; then
				run sudo apt-get update -y
				updated=1
				export EWW_APT_UPDATED=1
			fi
			run sudo apt-get install -y "$p"
			chg "pkg $p installed"
		fi
	done
}

ensure_service_enabled() {
	local svc="$1"
	if systemctl is-enabled "$svc" >/dev/null 2>&1; then
		ok "svc $svc enabled"
	else
		run sudo systemctl enable --now "$svc"
		chg "svc $svc enabled+started"
	fi
}
