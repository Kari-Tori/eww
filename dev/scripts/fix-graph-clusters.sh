#!/usr/bin/env bash
# fix-graph-clusters.sh - Konfiguracja grafów z izolowanymi klastrami kolorów
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

readonly OBSIDIAN_DIR=".obsidian"
readonly GRAPH_JSON="${OBSIDIAN_DIR}/graph.json"
readonly BACKUP_DIR="${OBSIDIAN_DIR}/backups"

log_info() {
    echo -e "${BLUE}[EWW]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW]${NC} ✅ $*"
}

log_warn() {
    echo -e "${YELLOW}[EWW]${NC} ⚠️  $*"
}

# Utwórz backup
create_backup() {
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$BACKUP_DIR"
    
    if [[ -f "$GRAPH_JSON" ]]; then
        cp "$GRAPH_JSON" "${BACKUP_DIR}/graph.json.${timestamp}"
        log_success "Backup utworzony: ${BACKUP_DIR}/graph.json.${timestamp}"
    fi
}

# Główna konfiguracja - każdy kolor = oddzielny klaster
configure_graph_clusters() {
    log_info "Konfiguracja grafów z izolowanymi klastrami..."
    
    cat > "$GRAPH_JSON" << 'EOF'
{
  "collapse-filter": false,
  "search": "",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "tag:#folder_note",
      "color": {
        "a": 1,
        "rgb": 9127187
      }
    },
    {
      "query": "tag:#eww OR tag:#core OR path:core/",
      "color": {
        "a": 1,
        "rgb": 16711680
      }
    },
    {
      "query": "tag:#config OR path:config/",
      "color": {
        "a": 1,
        "rgb": 65280
      }
    },
    {
      "query": "tag:#business OR path:business/",
      "color": {
        "a": 1,
        "rgb": 16776960
      }
    },
    {
      "query": "tag:#jakubc OR path:usr/jakubc/",
      "color": {
        "a": 1,
        "rgb": 65535
      }
    },
    {
      "query": "tag:#karinam OR path:usr/karinam/",
      "color": {
        "a": 1,
        "rgb": 16711935
      }
    },
    {
      "query": "tag:#star-wars OR path:usr/jakubc/hobby/star_wars/",
      "color": {
        "a": 1,
        "rgb": 14263361
      }
    },
    {
      "query": "tag:#lego OR path:usr/jakubc/hobby/lego/",
      "color": {
        "a": 1,
        "rgb": 16744192
      }
    },
    {
      "query": "tag:#docs OR path:docs/",
      "color": {
        "a": 1,
        "rgb": 5592575
      }
    },
    {
      "query": "tag:#infra OR path:infra/",
      "color": {
        "a": 1,
        "rgb": 10824234
      }
    },
    {
      "query": "tag:#scripts OR path:scripts/",
      "color": {
        "a": 1,
        "rgb": 16733525
      }
    },
    {
      "query": "tag:#tools OR path:tools/",
      "color": {
        "a": 1,
        "rgb": 8421504
      }
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1.2,
  "lineSizeMultiplier": 1,
  "collapse-forces": false,
  "centerStrength": 0.05,
  "repelStrength": 25,
  "linkStrength": 0.5,
  "linkDistance": 600,
  "scale": 1,
  "close": false
}
EOF
    
    log_success "Graph.json zaktualizowany z izolowanymi klastrami"
}

# Konfiguracja Extended Graph dla jeszcze lepszej separacji
configure_extended_graph() {
    local extended_graph="${OBSIDIAN_DIR}/plugins/extended-graph/data.json"
    
    if [[ ! -f "$extended_graph" ]]; then
        log_warn "Extended Graph plugin nie zainstalowany, pomijam..."
        return
    fi
    
    log_info "Konfiguracja Extended Graph dla separacji klastrów..."
    
    cat > "$extended_graph" << 'EOF'
{
  "maxNodes": 5000,
  "delay": 500,
  "recomputeStatsOnGraphChange": false,
  "fadeInElements": false,
  "enableFeatures": {
    "graph": {
      "auto-enabled": true,
      "tags": true,
      "properties": false,
      "property-key": false,
      "links": true,
      "linksSameColorAsNode": true,
      "folders": true,
      "imagesFromProperty": false,
      "imagesFromEmbeds": false,
      "imagesForAttachments": false,
      "focus": true,
      "shapes": true,
      "elements-stats": false,
      "names": true,
      "icons": true,
      "arrows": true,
      "layers": true
    }
  },
  "clusterByColor": true,
  "clusterStrength": 0.8,
  "interClusterRepulsion": 50
}
EOF
    
    log_success "Extended Graph skonfigurowany dla klastrów"
}

# Generuj dokumentację nowych klastrów
generate_cluster_docs() {
    log_info "Generowanie dokumentacji klastrów..."
    
    cat > "GRAPH-CLUSTERS.md" << 'EOF'
---
tags:
  - #automation
  - #graph
  - #eww
created: 2025-11-21T18:45:00Z
modified: 2025-11-21T18:45:00Z
author: jakubc
title: "🎨 GRAPH: Isolated Color Clusters"
---

# 🎨 GRAPH: Isolated Color Clusters

> **Każdy kolor = osobny klaster na grafie**

## 🎯 Konfiguracja

### Siły grafu
- **centerStrength**: 0.05 (bardzo słabe centrowanie)
- **repelStrength**: 25 (bardzo silne odpychanie)
- **linkStrength**: 0.5 (średnie łączenie w klastrze)
- **linkDistance**: 600 (bardzo duża odległość)

**Efekt**: Silna separacja klastrów, każdy kolor w osobnym gnieździe

### Efekt
Każda grupa kolorów tworzy **własne gniazdo** (cluster):
- 🔴 **Core** - czerwony klaster (path:core/)
- 🟢 **Config** - zielony klaster (path:config/)
- 🟡 **Business** - żółty klaster (path:business/)
- 🔵 **jakubc** - cyan klaster (path:usr/jakubc/)
- 🟣 **karinam** - magenta klaster (path:usr/karinam/)
- 🌟 **Star Wars** - beżowy klaster (path:usr/jakubc/hobby/star_wars/)
- 🟠 **Lego** - pomarańczowy klaster (path:usr/jakubc/hobby/lego/)
- 🔷 **Docs** - niebieski klaster (path:docs/)
- 🟤 **Infra** - khaki klaster (path:infra/)
- 🔴 **Scripts** - coral klaster (path:scripts/)
- ⚫ **Tools** - szary klaster (path:tools/)
- 🟫 **Folder Notes** - brązowy klaster (centrum)

## 📊 Grupy kolorów

| Kolor | Query | RGB | Ścieżka |
|-------|-------|-----|---------|
| 🟫 Brązowy | `tag:#folder_note` | 9127187 | Folder notes (centrum) |
| 🔴 Czerwony | `tag:#eww OR tag:#core` | 16711680 | path:core/ |
| 🟢 Zielony | `tag:#config` | 65280 | path:config/ |
| 🟡 Żółty | `tag:#business` | 16776960 | path:business/ |
| 🔵 Cyan | `tag:#jakubc` | 65535 | path:usr/jakubc/ |
| 🟣 Magenta | `tag:#karinam` | 16711935 | path:usr/karinam/ |
| 🌟 Beżowy | `tag:#star-wars` | 14263361 | path:usr/jakubc/hobby/star_wars/ |
| 🟠 Pomarańczowy | `tag:#lego` | 16744192 | path:usr/jakubc/hobby/lego/ |
| 🔷 Niebieski | `tag:#docs` | 5592575 | path:docs/ |
| 🟤 Khaki | `tag:#infra` | 10824234 | path:infra/ |
| 🔴 Coral | `tag:#scripts` | 16733525 | path:scripts/ |
| ⚫ Szary | `tag:#tools` | 8421504 | path:tools/ |

## 🎨 Kolorowe ścieżki

Każda ścieżka ma swój unikalny kolor:
- **path:core/** = 🔴 Czerwony
- **path:config/** = 🟢 Zielony  
- **path:business/** = 🟡 Żółty
- **path:usr/jakubc/** = 🔵 Cyan
- **path:usr/karinam/** = 🟣 Magenta
- **path:docs/** = 🔷 Niebieski
- **path:infra/** = 🟤 Khaki
- **path:scripts/** = 🔴 Coral
- **path:tools/** = ⚫ Szary

## 🚀 Użycie

### Filtruj konkretny klaster
```
tag:#jakubc
```
Zobaczysz tylko cyan klaster (jakubc).

### Pokaż relacje między klastrami
```
tag:#eww OR tag:#jakubc
```
Zobaczysz połączenia między zielonym a cyan.

### Local Graph
Każdy plik pokazuje swój klaster + bezpośrednie połączenia.

## 🎨 Wizualizacja

```
       [Folder Notes] 🟫
              |
    +---------+---------+
    |         |         |
 [EWW]🟢  [jakubc]🔵  [karinam]🟣
    |         |         |
  [Docs]   [SW]🟡   [Lego]🟠
   🔷        |         |
         [Scripts]  [Tools]
            🔴        ⚫
```

## ✅ Zalety

- ✅ **Przejrzystość** - każdy kolor to osobna sieć
- ✅ **Nawigacja** - łatwo znaleźć tematyczny content
- ✅ **Performance** - mniejsze klastry = szybszy render
- ✅ **Kontekst** - wizualnie widzisz separację tematów

## 🔧 Dostosowanie

Edytuj `.obsidian/graph.json`:
- **repelStrength** ↑ = więcej separacji
- **linkDistance** ↑ = większe gniazda
- **centerStrength** ↓ = luźniejsza struktura

## 🔗 Related
- [[GRAPH-MAP]] - Mapa główna
- [[GRAPH-OPTIMIZATION]] - Optymalizacje
- [[fix-graph-clusters.sh]] - Skrypt konfiguracyjny

**Restart Obsidian po zmianach!** 🔄
EOF
    
    log_success "Dokumentacja GRAPH-CLUSTERS.md utworzona"
}

main() {
    log_info "🎨 Konfiguracja grafów z izolowanymi klastrami kolorów"
    echo
    
    # Sprawdź czy jesteśmy w repo
    if [[ ! -d "$OBSIDIAN_DIR" ]]; then
        echo "❌ Błąd: Brak katalogu .obsidian/" >&2
        echo "Uruchom skrypt z głównego katalogu vault Obsidian" >&2
        exit 1
    fi
    
    # Backup
    create_backup
    
    # Konfiguracja
    configure_graph_clusters
    configure_extended_graph
    generate_cluster_docs
    
    echo
    log_success "Konfiguracja klastrów zakończona!"
    echo
    echo "📋 Następne kroki:"
    echo "  1. Restart Obsidian"
    echo "  2. Otwórz Graph View (Ctrl+G)"
    echo "  3. Zobacz izolowane klastry kolorów"
    echo "  4. Przeczytaj [[GRAPH-CLUSTERS]]"
    echo
    log_info "Backup: ${BACKUP_DIR}/"
}

main "$@"
