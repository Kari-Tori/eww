---
title: OpenHands - Autonomous Coding Agent
category: AI Tools
type: Autonomous Agent
status: Advanced
cost: FREE (core) + Paid (cloud)
ollama_support: YES
created: 2025-11-25
---

# OpenHands - Autonomous Coding Agent

## Podstawowe informacje

- **Poprzednia nazwa:** All-Hands AI
- **Typ:** Autonomous task executor agent
- **Integracja:** CLI / Web GUI / SDK
- **Licencja:** MIT (core) / Source-available (enterprise)
- **Koszt:** FREE (local) / $10 credit (cloud) / Enterprise pricing
- **Repozytorium:** https://github.com/OpenHands/OpenHands
- **Dokumentacja:** https://docs.openhands.dev
- **Gwiazdki:** 65.2k ⭐

## Główne funkcje

### 1. Autonomiczny Agent
- **Dajesz zadanie** → Agent sam wykonuje
- Nie wymaga interakcji po starcie
- Sam podejmuje decyzje
- Autonomiczne commitowanie

### 2. Software Development Lifecycle
- Implementacja całych features
- Debugging i fixing
- Refactoring
- Pisanie testów
- Dokumentacja

### 3. Integracje
- Git / GitHub
- Slack
- Jira
- Linear
- CI/CD pipelines

## Komponenty

### 1. OpenHands SDK
```python
# Definiuj agentów w kodzie
from openhands import Agent

agent = Agent(
    model="ollama/qwen2.5-coder:7b",
    task="Implement user authentication"
)
agent.run()
```

### 2. OpenHands CLI
```bash
# Najprostszy sposób użycia
openhands "Fix all failing tests"
```

### 3. OpenHands Local GUI
```bash
# Web interface + REST API
docker run -p 3000:3000 ghcr.io/openhands/openhands:main
```

### 4. OpenHands Cloud
- Hosted solution
- $10 free credit
- https://app.all-hands.dev/

### 5. OpenHands Enterprise
- Self-hosted in VPC
- Kubernetes deployment
- Extended support
- Source-available (wymaga licencji)

## Instalacja

### Minimalna (Docker)
```bash
docker run -it --pull=always \
  -e SANDBOX_USER_ID=$(id -u) \
  -e LLM_MODEL="ollama/qwen2.5-coder:7b" \
  -e LLM_BASE_URL="http://host.docker.internal:11434" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/workspace:/opt/workspace_base \
  -p 3000:3000 \
  ghcr.io/openhands/openhands:main
```

### Z Ollama lokalnie
```bash
# 1. Upewnij się że Ollama działa
ollama serve

# 2. Pull modelu
ollama pull qwen2.5-coder:7b

# 3. Uruchom OpenHands
docker run -it --pull=always \
  -e SANDBOX_USER_ID=$(id -u) \
  -e LLM_API_KEY="ollama" \
  -e LLM_BASE_URL="http://host.docker.internal:11434" \
  -e LLM_MODEL="ollama/qwen2.5-coder:7b" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 3000:3000 \
  ghcr.io/openhands/openhands:main
```

### CLI Installation
```bash
pip install openhands-cli
openhands config set llm.model "ollama/qwen2.5-coder:7b"
openhands config set llm.base_url "http://localhost:11434"
```

## Użycie

### Przykładowe zadania

#### Feature Implementation
```bash
openhands "Add user registration endpoint with email validation"
```

#### Bug Fixing
```bash
openhands "Fix the authentication bug in src/auth.py"
```

#### Refactoring
```bash
openhands "Refactor the database layer to use repository pattern"
```

#### Testing
```bash
openhands "Write unit tests for all functions in src/utils.py"
```

### Web GUI
1. Otwórz http://localhost:3000
2. Wpisz zadanie w natural language
3. Agent rozpoczyna pracę
4. Możesz obserwować progress
5. Agent commituje zmiany

## Zalety

✅ **Autonomiczny** - robi całe taski sam  
✅ **Kompleksowy** - od kodu po testy i docs  
✅ **Integracje** - Slack, Jira, GitHub  
✅ **Open Source** - core MIT license  
✅ **Ollama support** - działa lokalnie  
✅ **Skalowalny** - od local do cloud  
✅ **Active development** - 65k+ stars, 431 contributors

## Wady

⚠️ **Złożony setup** - wymaga Docker, konfiguracji  
⚠️ **Mniej kontroli** - agent sam decyduje  
⚠️ **Wymaga review** - musisz sprawdzić co zrobił  
⚠️ **Resource-heavy** - Docker, więcej RAM  
⚠️ **Learning curve** - bardziej zaawansowany  
⚠️ **Overkill** - dla prostych tasków za dużo

## Przypadki użycia

### Idealne dla:
- Implementacja całych features
- "Zrób X od A do Z"
- Duże refaktoringi
- Fixing test suites
- Batch operations
- Team automation
- CI/CD integration

### NIE idealne dla:
- Quick questions
- Code explanations
- Simple autocomplete
- Interactive coding
- Learning (chcesz widzieć proces)

## Architektura

```
┌─────────────────┐
│   User Input    │
│  "Add feature"  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  OpenHands      │
│  Controller     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   LLM Agent     │
│ (Ollama/GPT)    │
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌───────┐ ┌───────┐
│ Code  │ │ Tests │
│ Edit  │ │ Run   │
└───┬───┘ └───┬───┘
    │         │
    └────┬────┘
         ▼
    ┌─────────┐
    │  Git    │
    │ Commit  │
    └─────────┘
```

## Konfiguracja z Ollama

### config.toml
```toml
[llm]
model = "ollama/qwen2.5-coder:7b"
base_url = "http://localhost:11434"
api_key = "ollama"

[agent]
memory_enabled = true
memory_max_threads = 4

[workspace]
base_path = "/opt/workspace_base"
mount_mode = "rw"
```

## Porównanie z Continue

| Aspekt | OpenHands | Continue |
|--------|-----------|----------|
| **Autonomia** | Wysoka (robi sam) | Niska (asystent) |
| **Kontrola** | Mniejsza | Większa |
| **Setup** | 30+ min (Docker) | 5 min (extension) |
| **Interface** | CLI/Web | VS Code |
| **Use case** | Całe taski | Daily coding |
| **Learning curve** | Stroma | Płytka |

## Strategie użycia

### Workflow 1: Full Autonomous
```bash
# Dajesz zadanie i zostawiasz
openhands "Implement OAuth2 authentication with Google"
# Agent robi wszystko sam
# Sprawdzasz wynik i mergujesz
```

### Workflow 2: Supervised
```bash
# Uruchamiasz GUI
# Dajesz zadanie
# Obserwujesz progress
# Interweniujesz gdy potrzeba
# Akceptujesz zmiany
```

### Workflow 3: CI/CD Integration
```yaml
# .github/workflows/openhands.yml
- name: OpenHands Auto-fix
  run: |
    openhands "Fix all linting errors"
    git push
```

## Koszt

### FREE (Local)
- ✅ Core engine
- ✅ CLI
- ✅ GUI
- ✅ SDK
- ✅ Ollama integration
- ❌ Cloud hosting
- ❌ Team features

### OpenHands Cloud ($10 credit)
- ✅ Hosted infrastructure
- ✅ No Docker needed
- ✅ Faster models
- 💰 Pay per use

### Enterprise (Custom pricing)
- ✅ Self-hosted in VPC
- ✅ Kubernetes
- ✅ Team collaboration
- ✅ RBAC
- ✅ Extended support
- 💰 License required

## Rekomendacja

### Kiedy użyć OpenHands?
- ✅ Masz duże, autonomiczne taski
- ✅ Chcesz "hands-off" development
- ✅ Team automation
- ✅ CI/CD integration
- ✅ Batch operations

### Kiedy NIE używać?
- ❌ Quick coding assistance (użyj Continue)
- ❌ Learning (chcesz widzieć proces)
- ❌ Simple questions
- ❌ Nie masz Dockera

## Bezpieczeństwo

⚠️ **UWAGA:** Agent ma pełny dostęp do:
- Systemu plików
- Git repo
- Terminal commands
- Network calls

**Środki ostrożności:**
- Uruchamiaj w sandboxie (Docker)
- Review przed merge
- Nie dawaj dostępu do production
- Używaj na lokalnych kopiach

## Podsumowanie

**OpenHands = potężny autonomiczny agent dla zaawansowanych tasków**

- Robi całe features sam
- Wymaga więcej setupu i zaufania
- Idealne dla dużych, powtarzalnych tasków
- Complement do Continue (nie replacement)

## Status
⚠️ **Do rozważenia** - bardziej zaawansowane niż Continue

## Strategia użycia
1. **START:** Continue (daily coding)
2. **PÓŹNIEJ:** OpenHands (big tasks)
3. **RAZEM:** Continue + OpenHands = kompletny toolkit

## Następne kroki (opcjonalne)
1. Zainstaluj Docker
2. Pull obrazu OpenHands
3. Skonfiguruj z Ollama
4. Testuj na małych taskach
5. Scale up do większych
