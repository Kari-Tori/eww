#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo "[FAIL] line $LINENO: $BASH_COMMAND" >&2' ERR

REPO="/git/eww.git"
say(){ echo "== $* =="; }

say "Sprawdzam /git"
if [[ ! -d /git || ! -w /git ]]; then
  sudo mkdir -p /git
  sudo chown "$(id -u)":"$(id -g)" /git
fi

say "Repo: $REPO"
mkdir -p "$REPO"
cd "$REPO"

say "Git init (jeśli brak)"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || git init -b main >/dev/null

say "Struktura katalogów"
mkdir -p scripts MkDocs/docs Git .github/workflows

say "Manifest"
cat > eww-manifest.yml <<'YAML'
name: eww
root: /git/eww.git

paths:
  - .
  - scripts
  - MkDocs
  - MkDocs/docs
  - Git
  - .github/workflows

files:
  - README.md
  - Makefile
  - makefile.make
  - CODEOWNERS
  - CONTRIBUTING.md

options:
  autocreate: false
YAML

say "Makefile"
cat > Makefile <<'MK'
.DEFAULT_GOAL := help
include makefile.make
MK

say "makefile.make"
cat > makefile.make <<'MK'
.RECIPEPREFIX := >
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.PHONY: help bootstrap manifest-check lint docs-serve docs-build pre-commit-install status

help: ## pokaż cele
> grep -E '^[a-zA-Z0-9_.-]+:.*?##' makefile.make | sed 's/:.*##/: /' | sort

bootstrap: ## bootstrap repo (tworzy brakujące ścieżki i pliki bazowe)
> AUTOCREATE=true FIX=1 CHECK_PATHS=0 scripts/eww_check_paths.sh eww-manifest.yml >/dev/null || true
> scripts/eww_bootstrap.sh
> echo "Bootstrap done."

manifest-check: ## verify manifest (CHECK_PATHS=1, aby wymusić zgodność)
> scripts/eww_check_paths.sh eww-manifest.yml

lint: ## lint (yaml/shell/md gdy narzędzia dostępne)
> command -v yamllint >/dev/null && yamllint -s . || echo "yamllint: skip"
> command -v shellcheck >/dev/null && ls scripts/*.sh >/dev/null 2>&1 && shellcheck -x scripts/*.sh || echo "shellcheck: skip"
> command -v markdownlint >/dev/null && markdownlint '**/*.md' || echo "markdownlint: skip"

docs-serve: ## mkdocs serve na :8000 (jeśli plik istnieje)
> [ -f MkDocs/mkdocs.yml ] && ( cd MkDocs; mkdocs serve -a 127.0.0.1:8000 ) || echo "MkDocs: brak MkDocs/mkdocs.yml"

docs-build: ## mkdocs build (jeśli plik istnieje)
> [ -f MkDocs/mkdocs.yml ] && ( cd MkDocs; mkdocs build ) || echo "MkDocs: brak MkDocs/mkdocs.yml"

status: ## status repo i mkdocs
> scripts/eww_status.sh

pre-commit-install: ## zainstaluj hooki pre-commit (jeśli dostępny)
> command -v pre-commit >/dev/null && pre-commit install || echo "pre-commit: skip"
MK

say "scripts/eww_check_paths.sh"
cat > scripts/eww_check_paths.sh <<'SH2'
#!/usr/bin/env bash
set -Eeuo pipefail
manifest="${1:-eww-manifest.yml}"
repo_root="$(git rev-parse --show-toplevel)"
cfg_root="$(awk '/^root:/{print $2; exit}' "$manifest" || true)"
check="${CHECK_PATHS:-0}"
errors=0

if [[ -n "${cfg_root:-}" && "$cfg_root" != "$repo_root" ]]; then
  echo "ERR: root mismatch: manifest=$cfg_root repo=$repo_root" >&2
  ((errors++))
fi

extract_list() {
  local key="$1"
  awk -v key="$key" '
    function trim(s){ gsub(/^[ \t\r\n]+|[ \t\r\n]+$/, "", s); return s }
    BEGIN{ inlist=0 }
    $0 ~ "^"key":" {
      inlist=0
      if (match($0, /\[[^]]*\]/)) {
        s=substr($0, RSTART+1, RLENGTH-2)
        gsub(/"/, "", s); n=split(s, a, / *, */)
        for(i=1;i<=n;i++){ x=trim(a[i]); if(x!="") print x }
      } else { inlist=1 }
      next
    }
    inlist==1 && /^\s*-\s*/ {
      line=$0; sub(/^\s*-\s*/,"",line); line=trim(line); gsub(/^"|"$/,"",line)
      if(line!="") print line; next
    }
    inlist==1 && /^[^[:space:]-]/ { inlist=0 }
  ' "$manifest"
}

mapfile -t paths < <(extract_list "paths")
for d in "${paths[@]}"; do
  [[ -z "$d" ]] && continue
  if [[ ! -e "$repo_root/$d" ]]; then
    if [[ "${FIX:-0}" = "1" || "${AUTOCREATE:-false}" = "true" ]] && [[ "$check" != "1" ]]; then
      mkdir -p "$repo_root/$d"; echo "MKDIR $d"
    else
      echo "MISSING $d" >&2; ((errors++))
    fi
  fi
done

mapfile -t files < <(extract_list "files")
for f in "${files[@]}"; do
  [[ -z "$f" ]] && continue
  [[ -f "$repo_root/$f" ]] || { echo "MISSING_FILE $f" >&2; ((errors++)); }
done

echo "SUMMARY: {\"file\":\"$manifest\",\"path_check\":$([[ $check == 1 ]] && echo true || echo false),\"errors\":$errors}"
if [[ "$check" == "1" && $errors -gt 0 ]]; then exit 2; fi
SH2
chmod +x scripts/eww_check_paths.sh

say "scripts/eww_bootstrap.sh"
cat > scripts/eww_bootstrap.sh <<'SH3'
#!/usr/bin/env bash
set -Eeuo pipefail
root="$(git rev-parse --show-toplevel)"
cat > "$root/.editorconfig" <<'EOF'
root = true
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
EOF
cat > "$root/.pre-commit-config.yaml" <<'YAML'
repos:
- repo: https://github.com/pre-commit/pre-commit-hooks
  rev: v4.6.0
  hooks:
  - id: end-of-file-fixer
  - id: trailing-whitespace
  - id: check-yaml
- repo: https://github.com/adrienverge/yamllint
  rev: v1.35.1
  hooks:
  - id: yamllint
    args: [ -s ]
YAML
[[ -f "$root/CODEOWNERS" ]] || cat > "$root/CODEOWNERS" <<'EOF'
*            @jakubc @karina
/scripts/*   @jakubc
/MkDocs/**   @jakubc
EOF
[[ -f "$root/CONTRIBUTING.md" ]] || cat > "$root/CONTRIBUTING.md" <<'MD'
# Contributing
- Commit: `type: scope — message`
- Przed push: `CHECK_PATHS=1 make manifest-check`
- Styl: UTF-8, LF.
MD
SH3
chmod +x scripts/eww_bootstrap.sh

say "scripts/eww_status.sh"
cat > scripts/eww_status.sh <<'SH4'
#!/usr/bin/env bash
set -Eeuo pipefail
echo "== Git =="; git remote -v || true; git status -s || true
echo "== MkDocs :8000 =="; ss -ltnp 2>/dev/null | grep ':8000' || echo "mkdocs: not listening"
SH4
chmod +x scripts/eww_status.sh

say "MkDocs"
cat > MkDocs/mkdocs.yml <<'YAML'
site_name: EWW — Wiki
site_dir: site
theme:
  name: material
  features: [content.code.copy, navigation.sections]
nav:
  - Start: index.md
markdown_extensions:
  - admonition
  - toc
  - tables
  - pymdownx.details
  - pymdownx.superfences
YAML
cat > MkDocs/docs/index.md <<'MD'
# Start
E-Waste Workshop — dokumentacja wewnętrzna.
MD

cat > Git/README.md <<'MD'
# Git folder
Opis elementów Git dla repo. `.git/` tworzy `git init` i nie jest śledzony.
MD

cat > README.md <<'MD'
# E-Waste Workshop (EWW)
Metoda repo: manifest → Makefile → skrypty → hooki.

## Start
make bootstrap
CHECK_PATHS=1 make manifest-check
make lint
MD

say "DONE"
