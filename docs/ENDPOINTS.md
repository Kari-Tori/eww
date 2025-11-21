---
title: ENDPOINTS
description: ENDPOINTY — MkDocs (E-Waste Workshop — Wiki)
type: file
category: docs
filepath: docs/ENDPOINTS.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
aliases:
related:
  - docs/docs.md
  - docs/FULL-INDEX.md
  - docs/index.md
dependencies:
sources:
  - docs/ENDPOINTS.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# ENDPOINTY — MkDocs (E-Waste Workshop — Wiki)

## DEV
- UI: http://127.0.0.1:8000/  *(u Ciebie realnie 8010)*
- LiveReload WS: ws://127.0.0.1:8000/livereload

> Aby udostępnić w LAN: `-a 0.0.0.0:8000` -> `http://192.168.0.99:8000/` lub `http://gerc.local:8000/`.

## PROD
- Lokalnie: http://127.0.0.1:8080/
- LAN:     http://192.168.0.99:8080/  |  http://gerc.local:8080/

## Ścieżki
- Root: `~/git/eww`  |  Konf: `mkdocs.yml`  |  Źródła: `docs/`  |  Build: `site/`

## Usługi
- DEV:  mkdocs-serve.service
- PROD: mkdocs-prod.service

### Komendy
systemctl --user restart mkdocs-serve
systemctl --user restart mkdocs-prod
journalctl --user -u mkdocs-serve -f
journalctl --user -u mkdocs-prod -f
