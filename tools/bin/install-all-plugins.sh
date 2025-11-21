#!/usr/bin/env bash
# File: bin/install-all-plugins.sh
# Author: jakubc
# Created: 2025-11-21
# Updated: 2025-11-21
# Description: install-all-plugins.sh - Instalacja wszystkich rekomendowanych pluginów
# install-all-plugins.sh - Instalacja wszystkich rekomendowanych pluginów
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }

cat <<'BANNER'
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║        🔌 INSTALACJA WSZYSTKICH PLUGINÓW                       ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
BANNER

if ! command -v code &> /dev/null; then
    log_warn "VS Code nie zainstalowane!"
    exit 1
fi

echo ""
log_info "Instaluję VS Code extensions..."
echo ""

# AI & Productivity
log_info "→ AI & Code Assistance"
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension Continue.continue
code --install-extension tabnine.tabnine-vscode
code --install-extension visualstudioexptteam.vscodeintellicode

# Git & GitHub
log_info "→ Git & GitHub"
code --install-extension eamodio.gitlens
code --install-extension github.vscode-pull-request-github
code --install-extension donjayamanne.githistory
code --install-extension mhutchie.git-graph

# Markdown
log_info "→ Markdown & Documentation"
code --install-extension yzhang.markdown-all-in-one
code --install-extension davidanson.vscode-markdownlint
code --install-extension bierner.markdown-mermaid
code --install-extension yzane.markdown-pdf

# Code Quality
log_info "→ Code Quality"
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension timonwong.shellcheck
code --install-extension usernamehw.errorlens
code --install-extension sonarsource.sonarlint-vscode

# DevOps
log_info "→ DevOps & Infrastructure"
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension redhat.vscode-yaml
code --install-extension ms-vscode-remote.remote-ssh

# Productivity
log_info "→ Productivity"
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension oderwat.indent-rainbow
code --install-extension pkief.material-icon-theme
code --install-extension wayou.vscode-todo-highlight

# Data & Visualization
log_info "→ Data Tools"
code --install-extension mechatroner.rainbow-csv
code --install-extension humao.rest-client
code --install-extension eriklynd.json-tools

echo ""
log_success "VS Code extensions zainstalowane!"

# GitHub CLI extensions
if command -v gh &> /dev/null; then
    echo ""
    log_info "Instaluję GitHub CLI extensions..."
    
    gh extension install github/gh-copilot 2>/dev/null || log_warn "Copilot już zainstalowany"
    gh extension install dlvhdr/gh-dash 2>/dev/null || log_warn "gh-dash już zainstalowany"
    gh extension install mislav/gh-branch 2>/dev/null || log_warn "gh-branch już zainstalowany"
    gh extension install seachicken/gh-poi 2>/dev/null || log_warn "gh-poi już zainstalowany"
    
    log_success "GitHub CLI extensions zainstalowane!"
fi

echo ""
echo "─────────────────────────────────────────────────────────"
echo ""

cat <<'SUMMARY'
✅ INSTALACJA ZAKOŃCZONA

📦 Zainstalowane:
   • 25+ VS Code extensions
   • 4+ GitHub CLI extensions

🎯 Co dalej:
   1. Restart VS Code
   2. Skonfiguruj Copilot: Sign in
   3. Skonfiguruj Continue.dev: ~/.continue/config.json
   4. Sprawdź: code --list-extensions

📚 Dokumentacja:
   • docs/PLUGINS.md
   • docs/GITHUB-TOOLS.md

SUMMARY

log_success "Gotowe!"
