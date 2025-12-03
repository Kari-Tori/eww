---
version: 0.0.3
tags:
  - #automation
  - #books
  - #development
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-11-24
author: jakubc
title: "EWW Playbooks Stack"






owner: jakubc
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

## 🔗 Backlinks

- [[dev/Playbooks/Playbooks]]
- [[dev/dev]]
- [[dev/Development]]