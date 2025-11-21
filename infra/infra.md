---
tags:
  - #automation
  - #development
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🏗️ Infra"






---

# 🏗️ Infra

> **Infrastruktura i konfiguracja systemowa**

## 📋 Cel folderu

Zawiera wszystkie elementy infrastruktury systemowej: konfiguracje systemd, CI/CD, deployment, monitoring i backup.

## 📁 Struktura

```
infra/
├── systemd/          # Jednostki systemd
├── ci-cd/            # Konfiguracje CI/CD
├── deployment/       # Skrypty wdrożeniowe
├── monitoring/       # Monitoring i logi
└── backup/           # Strategie backup
```

## 📄 Index plików

### Systemd
- [[systemd-services]] - Usługi systemd
- [[systemd-timers]] - Timery automatyzacji
- [[systemd-units]] - Definicje jednostek

### CI/CD
- [[github-actions]] - Workflows GitHub Actions
- [[pre-commit-hooks]] - Hooki pre-commit
- [[deployment-pipeline]] - Pipeline wdrożeniowy

### Deployment
- [[install-script]] - Skrypt instalacyjny
- [[update-script]] - Automatyczne aktualizacje
- [[rollback-procedure]] - Procedura rollback

### Monitoring
- [[logging-strategy]] - Strategia logowania
- [[health-checks]] - Health check services
- [[metrics-collection]] - Zbieranie metryk

## 🔗 Powiązania

- [[config]] - Konfiguracja systemu
- [[scripts]] - Skrypty infrastrukturalne
- [[docs/architecture]] - Architektura
- [[var]] - Dane zmienne (logi, cache)

## 📊 Status

- **Typ**: Folder infrastrukturalny
- **Priorytet**: Wysoki
- **Maintainer**: [[usr/jakubc/jakubc|jakubc]]
- **Deployment**: Systemd + Git hooks


**Ostatnia aktualizacja**: 2025-11-21  
**Źródło**: Infrastruktura EWW
