---
title: ENDPOINTY — MkDocs (E-Waste Workshop — Wiki)
description: Dokument
type: document
category: documentation
tags:
  - document
language: pl
created: 2025-11-09
updated: 2025-11-09
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
