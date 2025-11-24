#!/usr/bin/env bash
# filepath: scripts/install-ai-toolkit.sh
set -euo pipefail

DEFAULT_OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-$HOME/Obsidian/code}"
SCRIPT_NAME="$(basename "$0")"

APT_PACKAGES=(
  jq
  ripgrep
  fzf
  httpie
  tldr
)

VSCODE_EXTENSIONS=(
  "GitHub.copilot"
  "GitHub.copilot-chat"
  "Continue.continue"
  "tabnine.tabnine-vscode"
  "visualstudioexptteam.vscodeintellicode"
  "eamodio.gitlens"
  "github.vscode-pull-request-github"
  "donjayamanne.githistory"
  "mhutchie.git-graph"
  "yzhang.markdown-all-in-one"
  "davidanson.vscode-markdownlint"
  "bierner.markdown-mermaid"
  "dbaeumer.vscode-eslint"
  "esbenp.prettier-vscode"
  "timonwong.shellcheck"
  "usernamehw.errorlens"
  "ms-azuretools.vscode-docker"
  "ms-kubernetes-tools.vscode-kubernetes-tools"
  "redhat.vscode-yaml"
  "streetsidesoftware.code-spell-checker"
  "oderwat.indent-rainbow"
  "pkief.material-icon-theme"
)

# Lista repozytoriów community plugins (Obsidian)
OBSIDIAN_PLUGIN_REPOS=(
  "mgmeyers/obsidian-kanban"
  "blacksmithgu/obsidian-dataview"
  "schemar/obsidian-tasks"
  "SilentVoid13/Templater"
  "chhoumann/quickadd"
  "Vinzent03/obsidian-advanced-uri"
  "liamcain/obsidian-calendar-plugin"
  "liamcain/obsidian-periodic-notes"
  "denolehov/obsidian-git"
  "platers/obsidian-linter"
)

log() {
  printf '[AI-SETUP] %s\n' "$*"
}

warn() {
  printf '[AI-SETUP][WARN] %s\n' "$*" >&2
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    warn "Brak polecenia: $1"
    exit 1
  fi
}

maybe_sudo() {
  if [[ $EUID -eq 0 ]]; then
    "$@"
  else
    sudo "$@"
  fi
}

install_cli_prereqs() {
  if ! command -v apt-get >/dev/null 2>&1; then
    warn "Nie znaleziono apt-get – pomiń instalację pakietów CLI."
    return
  fi

  log "Instalacja pakietów CLI: ${APT_PACKAGES[*]}"
  maybe_sudo apt-get update -y
  maybe_sudo apt-get install -y "${APT_PACKAGES[@]}"
}

install_vscode_extensions() {
  if ! command -v code >/dev/null 2>&1; then
    warn "Polecenie 'code' nie jest dostępne – pomiń instalację rozszerzeń VS Code."
    return
  fi

  for ext in "${VSCODE_EXTENSIONS[@]}"; do
    log "VS Code: instaluję rozszerzenie ${ext}"
    code --install-extension "${ext}" >/dev/null 2>&1 || warn "Nie udało się zainstalować ${ext}"
  done
}

download_latest_release() {
  local repo="$1"
  curl -fsSL "https://api.github.com/repos/${repo}/releases/latest"
}

install_obsidian_plugins() {
  require_command curl
  require_command jq

  local vault="${1:-$DEFAULT_OBSIDIAN_VAULT}"
  local plugins_dir="${vault}/.obsidian/plugins"

  if [[ ! -d "$vault" ]]; then
    warn "Vault nie istnieje: $vault"
    return 1
  fi
  mkdir -p "$plugins_dir"

  for repo in "${OBSIDIAN_PLUGIN_REPOS[@]}"; do
    log "Obsidian: pobieram plugin z repo ${repo}"
    local release_json
    if ! release_json="$(download_latest_release "$repo")"; then
      warn "Nie udało się pobrać release API dla ${repo}"
      continue
    fi

    local tmp_dir
    tmp_dir="$(mktemp -d)"
    local files_downloaded=0
    for artifact in main.js manifest.json styles.css; do
      local asset_url
      asset_url="$(jq -r --arg name "$artifact" '.assets[]? | select(.name==$name) | .browser_download_url' <<<"$release_json")"
      if [[ -n "$asset_url" && "$asset_url" != "null" ]]; then
        if curl -fsSL "$asset_url" -o "$tmp_dir/$artifact"; then
          ((files_downloaded++))
        else
          warn "Nie udało się pobrać ${artifact} dla ${repo}"
        fi
      fi
    done

    if [[ $files_downloaded -eq 0 ]]; then
      warn "Brak artefaktów main.js/manifest/styles dla ${repo}"
      rm -rf "$tmp_dir"
      continue
    fi

    local manifest="$tmp_dir/manifest.json"
    if [[ ! -f "$manifest" ]]; then
      warn "Brak manifestu dla ${repo}"
      rm -rf "$tmp_dir"
      continue
    fi

    local plugin_id
    plugin_id="$(jq -r '.id' "$manifest")"
    if [[ -z "$plugin_id" || "$plugin_id" == "null" ]]; then
      warn "Nie znaleziono pola 'id' w manifeście ${repo}"
      rm -rf "$tmp_dir"
      continue
    fi

    local target_dir="${plugins_dir}/${plugin_id}"
    rm -rf "$target_dir"
    mkdir -p "$(dirname "$target_dir")"
    mv "$tmp_dir" "$target_dir"
    log "Zainstalowano plugin ${plugin_id} w ${target_dir}"
  done
}

usage() {
  cat <<'EOF'
Użycie: scripts/install-ai-toolkit.sh [all|cli|vscode|obsidian] [vault_path]

  all        - instalacja pakietów CLI, rozszerzeń VS Code oraz pluginów Obsidian (domyślnie)
  cli        - tylko pakiety CLI (apt)
  vscode     - tylko rozszerzenia VS Code
  obsidian   - tylko pluginy Obsidian (drugi argument = ścieżka do vaulta)

Zmienne środowiskowe:
  OBSIDIAN_VAULT  - domyślna ścieżka do vaulta (domyślnie ~/Obsidian/code)
EOF
}

main() {
  local action="${1:-all}"
  case "$action" in
    cli)
      install_cli_prereqs
      ;;
    vscode)
      install_vscode_extensions
      ;;
    obsidian)
      install_obsidian_plugins "${2:-$DEFAULT_OBSIDIAN_VAULT}"
      ;;
    all)
      install_cli_prereqs
      install_vscode_extensions
      install_obsidian_plugins "${2:-$DEFAULT_OBSIDIAN_VAULT}"
      ;;
    *)
      usage
      exit 1
      ;;
  esac
}

main "$@"
