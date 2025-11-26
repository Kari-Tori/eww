#!/usr/bin/env bash
# File: dev/Playbooks/tools/install-deps.sh
# Author: 
# Created: 
# Updated: 
# Description: optional: molecule + docker driver
set -Eeuo pipefail
sudo apt update
sudo apt install -y shellcheck shfmt bats ansible ansible-lint yamllint python3-pip makeself git
# optional: molecule + docker driver
pip3 install --user 'molecule[docker]' pytest testinfra
