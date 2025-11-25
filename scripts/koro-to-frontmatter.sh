#!/usr/bin/env bash
set -euo pipefail

# Skrypt: konwertuje KoroFileHeader (HTML comment) na YAML frontmatter
# Użycie: ./scripts/koro-to-frontmatter.sh ścieżka/do/pliku.md

log_info() { printf '[EWW] %s\n' "$1"; }
log_error() { printf '[EWW] [ERROR] %s\n' "$1" >&2; }

if [[ "${#}" -ne 1 ]]; then
    log_error "Użycie: $0 <plik.md>"
    exit 2
fi

plik="$1"

if [[ ! -f "$plik" ]]; then
    log_error "Plik nie istnieje: $plik"
    exit 3
fi

# Jeśli plik już ma frontmatter YAML na początku, pomiń
if awk 'NR==1 && /^---/ {print "yes"; exit}' "$plik" | grep -q yes; then
    log_info "Plik już zawiera frontmatter YAML — pomijam: $plik"
    exit 0
fi

# Wyciągnij pierwszy blok HTML-komentarza <!-- ... -->
header=$(awk '
  BEGIN {in=0}
  /^<!--[[:space:]]*/ { in=1; next }
  /-->/ && in==1 { in=0; exit }
  in==1 { print }
' "$plik" || true)

if [[ -z "${header// }" ]]; then
    log_error "Nie znaleziono KoroFileHeader (<!-- ... -->) w pliku: $plik"
    exit 4
fi

# Funkcja: wyciąga wartość pola po kluczu (np. @Author:)
wyciagnij() {
    local key="$1"
    echo "$header" | sed -n "s/.*${key}:[[:space:]]*\\(.*\\)/\\1/p" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

author=$(wyciagnij '@Author')
date_raw=$(wyciagnij '@Date')
last_edit_time=$(wyciagnij '@LastEditTime')
last_editors=$(wyciagnij '@LastEditors')
file_path_orig=$(wyciagnij '@FilePath')
description=$(wyciagnij '@Description')

# Zbuduj YAML frontmatter (tylko pola istniejące)
yaml="---\n"
[[ -n "$author" ]] && yaml+=$(printf 'author: "%s"\n' "$author")
[[ -n "$date_raw" ]] && yaml+=$(printf 'created: "%s"\n' "$date_raw")
[[ -n "$last_edit_time" ]] && yaml+=$(printf 'last_edit: "%s"\n' "$last_edit_time")
[[ -n "$last_editors" ]] && yaml+=$(printf 'last_editor: "%s"\n' "$last_editors")
[[ -n "$file_path_orig" ]] && yaml+=$(printf 'original_filepath: "%s"\n' "$file_path_orig")
[[ -n "$description" ]] && yaml+=$(printf 'description: "%s"\n' "$description")
yaml+="---\n\n"

# Wypisz resztę pliku bez pierwszego bloku <!-- ... -->
tmp="$(mktemp)"
awk 'BEGIN{skip=0}
  /<!--[[:space:]]*/ && NR==1 { skip=1; next }
  /<!--[[:space:]]*/ && skip==0 { skip=1; next }
  /-->/ && skip==1 { skip=0; next }
  !skip { print }
' "$plik" > "${tmp}.body"

# Zapisz wynik (atomowo)
{
    printf "%s" "$yaml"
    cat "${tmp}.body"
} > "$tmp"

mv "$tmp" "$plik"
rm -f "${tmp}.body"

log_info "Skonwertowano Koro header -> YAML frontmatter: $plik"
exit 0
