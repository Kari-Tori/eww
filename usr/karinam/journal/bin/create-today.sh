#!/usr/bin/env bash
# create-today.sh - tworzy dziennik na dziś z szablonu jeśli jeszcze nie istnieje
set -euo pipefail

# Skrypt tworzy plik Daily/daily-YYYY-MM-DD.md z Templates/daily.md lub Templates/daily-templater.md
# Opcje:
#   --open    - spróbuje otworzyć plik (xdg-open lub Obsidian URI gdy ustawione EWW_JOURNAL_VAULT)
#   --vault NAME - nazwa vaulta Obsidian (używana przy otwieraniu przez obsidian://)

JOURNAL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES_DIR="$JOURNAL_ROOT/Templates"
DAILY_DIR="$JOURNAL_ROOT/Daily"

open_file=0
vault_name=""

while [[ ${#} -gt 0 ]]; do
  case "$1" in
    --open) open_file=1; shift ;;
    --vault) vault_name="$2"; shift 2 ;;
    -h|--help) echo "Użycie: $0 [--open] [--vault NAZWA]"; exit 0 ;;
    *) echo "Nieznana opcja: $1"; exit 2 ;;
  esac
done

mkdir -p "$DAILY_DIR"

today=$(date +%Y-%m-%d)
weekday=$(date +%A)
dest="$DAILY_DIR/daily-$today.md"

if [[ -f "$dest" ]]; then
  echo "Plik już istnieje: $dest"
else
  # Preferuj templater variant jeśli jest
  if [[ -f "$TEMPLATES_DIR/daily-templater.md" ]]; then
    cp "$TEMPLATES_DIR/daily-templater.md" "$dest"
  elif [[ -f "$TEMPLATES_DIR/daily.md" ]]; then
    # podstaw proste placeholdery
    sed "s/{{date:YYYY-MM-DD}}/$today/g; s/{{date:dddd}}/$weekday/g; s/{{time:HH:mm}}/$(date +%H:%M)/g" \
      "$TEMPLATES_DIR/daily.md" > "$dest"
  else
    echo "Brak szablonu w $TEMPLATES_DIR" >&2
    exit 1
  fi
  echo "Utworzono: $dest"
fi

if [[ $open_file -eq 1 ]]; then
  # Jeśli podano vault_name, spróbuj otworzyć przez Obsidian URI
  if [[ -n "$vault_name" ]]; then
    uri="obsidian://open?vault=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$vault_name")&file=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "usr/karinam/journal/Daily/daily-$today.md")"
    if command -v xdg-open >/dev/null 2>&1; then
      xdg-open "$uri" >/dev/null 2>&1 || echo "Nie udało się otworzyć Obsidian URI" >&2
    else
      echo "Brak xdg-open — nie mogę otworzyć Obsidian URI" >&2
    fi
  else
    # fallback: otwórz plik przez xdg-open (powiązane z domyślnym edytorem)
    if command -v xdg-open >/dev/null 2>&1; then
      xdg-open "$dest" >/dev/null 2>&1 || echo "Nie udało się otworzyć pliku: $dest" >&2
    else
      echo "$dest"
    fi
  fi
fi

exit 0
#!/usr/bin/env bash
# create-today.sh - tworzy dzisiejszy plik dziennika z szablonu jeśli nie istnieje
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES_DIR="$ROOT_DIR/Templates"
DAILY_DIR="$ROOT_DIR/Daily"
ATTACHMENTS_DIR="$ROOT_DIR/Attachments"

mkdir -p "$DAILY_DIR" "$ATTACHMENTS_DIR"

DATE="$(date +%F)"              # YYYY-MM-DD
DAY_NAME="$(date +%A)"          # nazwa dnia (zależna od lokalizacji)
TIME_NOW="$(date +%H:%M)"

TARGET_FILE="$DAILY_DIR/daily-$DATE.md"

if [[ -f "$TARGET_FILE" ]]; then
  echo "Plik już istnieje: $TARGET_FILE"
  echo "$TARGET_FILE"
  exit 0
fi

# Preferuj templaterowy szablon jeśli istnieje
if [[ -f "$TEMPLATES_DIR/daily.md" ]]; then
  sed \
    -e "s/{{date:YYYY-MM-DD}}/$DATE/g" \
    -e "s/{{date:dddd}}/$DAY_NAME/g" \
    -e "s/{{time:HH:mm}}/$TIME_NOW/g" \
    "$TEMPLATES_DIR/daily.md" > "$TARGET_FILE"
elif [[ -f "$TEMPLATES_DIR/daily-templater.md" ]]; then
  # Nie podstawiamy Templater placeholderów — kopiujemy bez zmian
  cp "$TEMPLATES_DIR/daily-templater.md" "$TARGET_FILE"
else
  echo "Brak szablonu w $TEMPLATES_DIR (daily.md lub daily-templater.md)" >&2
  exit 1
fi

echo "Utworzono: $TARGET_FILE"
echo "$TARGET_FILE"

# Jeśli użytkownik chce otworzyć plik w Obsidian (domyślnie próbujemy xdg-open)
if [[ "${1:-}" == "--open" ]]; then
  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$TARGET_FILE" || true
  else
    echo "Brak xdg-open — otwórz plik ręcznie: $TARGET_FILE"
  fi
fi

exit 0
