---
title: README
description: EWW Playbooks Stack
filepath: dev/Playbooks/README.md
color: yellow
author: 
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
tags:
  - documentation
  - markdown
  - readme
  - development
  - code
related:
  - AGENTS.md
  - CHANGELOG.md
  - FULL-INDEX.md
sources:
  - dev/Playbooks/README.md
backlinks: []
---


# EWW Playbooks Stack

Minimal stack for Shell + Ansible playbooks.

## Quick start
```bash
./tools/install-deps.sh
make all
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml
```

## Contents
- `script.sh` — robust Bash skeleton
- `ansible/playbook.yml` — base play with `roles/common`
- `molecule/` — optional role tests
- `test/` — BATS examples
- `Makefile` — fmt, lint, test targets
- `.pre-commit-config.yaml` — format and lint hooks
- `.github/workflows/ci.yml` — CI
