#!/usr/bin/env bash
# File: core/installers/kubuntu.sh
# Author: 
# Created: 
# Updated: 
# Description: narzędzia
set -euo pipefail

WITH_DOCKER=0
if [[ "${1:-}" == "--with-docker" ]]; then WITH_DOCKER=1; fi

if ! grep -qiE 'ubuntu|kubuntu' /etc/os-release; then
  echo "Tylko (K)Ubuntu." >&2
  exit 1
fi

sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git git-lfs curl aria2 make unzip zip build-essential \
  python3 python3-venv python3-pip pipx \
  neovim ripgrep fd-find fzf jq yq lsof htop \
  sops age ansible

git lfs install || true
pipx ensurepath || true
export PATH="$HOME/.local/bin:$PATH"

# narzędzia
pipx install pre-commit || true
pipx install mdformat    || true
pipx install yamllint    || true
pipx install mkdocs      || true
pipx inject mkdocs mkdocs-material pymdown-extensions mkdocs-awesome-pages-plugin mkdocs-git-revision-date-localized-plugin || true

# fd alias (Ubuntu -> fdfind)
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/div/null 2>&1; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

# docker opcjonalnie
if [[ "$WITH_DOCKER" -eq 1 ]]; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker.io docker-compose-plugin
  sudo usermod -aG docker "$USER" || true
fi

# git defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.autocrlf input

mkdir -p "$HOME/git/eww" "$HOME/.config/systemd/user"

echo "Kubuntu bootstrap OK."
if [[ "$WITH_DOCKER" -eq 1 ]]; then
  echo "Dodano docker — zaloguj się ponownie, by aktywować grupę."
fi
