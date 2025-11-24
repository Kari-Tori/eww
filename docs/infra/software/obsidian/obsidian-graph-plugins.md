---
tags:
  - #automation
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21T14:00:00Z
modified: 2025-11-21T14:00:00Z
author: jakubc
title: "📊 Obsidian Graph Plugins - Zestaw Profesjonalny"






owner: jakubc
---

# 📊 Obsidian Graph Plugins - Zestaw Profesjonalny

## 🎯 Zainstalowane (do grafu)

### 🔵 Graph Analysis ⭐⭐⭐⭐⭐
**Repo:** `SkepticMystic/graph-analysis`
**Funkcja:** Zaawansowana analiza struktury grafu, clustering, community detection
```bash
gh release download -R SkepticMystic/graph-analysis -p '*.zip' -O /tmp/graph-analysis.zip
```

### 🔵 Extended Graph ⭐⭐⭐⭐⭐
**Repo:** `SkepticMystic/obsidian-extended-graph`
**Funkcja:** Rozszerzone opcje filtrowania i kolorowania grafu
```bash
gh release download -R SkepticMystic/obsidian-extended-graph -p '*.zip' -O /tmp/extended-graph.zip
```

### 🟢 Waypoint ⭐⭐⭐⭐
**Repo:** `IdreesInc/Waypoint`
**Funkcja:** Automatyczne folder notes z indexami
```bash
gh release download -R IdreesInc/Waypoint -p '*.zip' -O /tmp/waypoint.zip
```

### 🟣 Dataview ⭐⭐⭐⭐⭐
**Repo:** `blacksmithgu/obsidian-dataview`
**Funkcja:** Dynamiczne listy i queryowanie metadanych
```bash
gh release download -R blacksmithgu/obsidian-dataview -p '*.zip' -O /tmp/dataview.zip
```


## 🚀 REKOMENDOWANE (TOP 5 do doinstalowania)

### 1️⃣ Excalidraw ⭐⭐⭐⭐⭐
**Repo:** `zsviczian/obsidian-excalidraw-plugin`
**Funkcja:** Diagramy, schematy, visual thinking
**Dlaczego:** Idealne do tworzenia map myśli i schematów architektury
```bash
gh release download -R zsviczian/obsidian-excalidraw-plugin -p '*.zip' -O /tmp/excalidraw.zip
```

### 2️⃣ Breadcrumbs ⭐⭐⭐⭐⭐
**Repo:** `SkepticMystic/breadcrumbs`
**Funkcja:** Hierarchie, parent-child relationships, implied links
**Dlaczego:** Automatyczne tworzenie struktur hierarchicznych w grafie
```bash
gh release download -R SkepticMystic/breadcrumbs -p '*.zip' -O /tmp/breadcrumbs.zip
```

### 3️⃣ Journey ⭐⭐⭐⭐
**Repo:** `akaalias/obsidian-journey-plugin`
**Funkcja:** Znajdowanie ścieżek między notatkami w grafie
**Dlaczego:** Odkrywanie nieoczywistych połączeń
```bash
gh release download -R akaalias/obsidian-journey-plugin -p '*.zip' -O /tmp/journey.zip
```

### 4️⃣ Strange New Worlds ⭐⭐⭐⭐
**Repo:** `TfTHacker/obsidian42-strange-new-worlds`
**Funcja:** Backlinks panel, link discovery, related notes
**Dlaczego:** Lepsze odkrywanie powiązań
```bash
gh release download -R TfTHacker/obsidian42-strange-new-worlds -p '*.zip' -O /tmp/snw.zip
```

### 5️⃣ Smart Connections ⭐⭐⭐⭐⭐
**Repo:** `brianpetro/obsidian-smart-connections`
**Funkcja:** AI-powered semantic search i link suggestions
**Dlaczego:** Automatyczne sugerowanie powiązań semantycznych
```bash
gh release download -R brianpetro/obsidian-smart-connections -p '*.zip' -O /tmp/smart-connections.zip
```


## 🎨 WIZUALIZACJA I KOLOROWANIE

### 🌈 Colorful Tag ⭐⭐⭐⭐
**Repo:** `rien7/obsidian-colorful-tag`
**Funkcja:** Kolorowe tagi w grafie
```bash
gh release download -R rien7/obsidian-colorful-tag -p '*.zip' -O /tmp/colorful-tag.zip
```

### 🎯 Icon Folder ⭐⭐⭐⭐
**Repo:** `FlorianWoelki/obsidian-icon-folder`
**Funkcja:** Ikony dla folderów i plików
```bash
gh release download -R FlorianWoelki/obsidian-icon-folder -p '*.zip' -O /tmp/icon-folder.zip
```


## 🛠️ Skrypt instalacyjny

```bash
#!/usr/bin/env bash
# tools/install-graph-plugins.sh
set -euo pipefail

readonly VAULT="/home/jakubc/git/eww"
readonly PLUGIN_DIR="$VAULT/.obsidian/plugins"
readonly TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

install_plugin() {
    local repo="$1"
    local name="$2"
    
    echo "📥 Instaluję: $name..."
    gh release download -R "$repo" -p '*.zip' -D "$TMP_DIR" 2>/dev/null || {
        echo "⚠️  Brak release dla $name, próbuję build..."
        return 1
    }
    
    local zip_file=$(find "$TMP_DIR" -name "*.zip" -type f | head -1)
    if [[ -f "$zip_file" ]]; then
        mkdir -p "$PLUGIN_DIR/$name"
        unzip -qo "$zip_file" -d "$PLUGIN_DIR/$name/"
        echo "✅ $name zainstalowany"
    fi
}

# TOP 5 pluginów
install_plugin "zsviczian/obsidian-excalidraw-plugin" "excalidraw"
install_plugin "SkepticMystic/breadcrumbs" "breadcrumbs"
install_plugin "akaalias/obsidian-journey-plugin" "journey"
install_plugin "TfTHacker/obsidian42-strange-new-worlds" "strange-new-worlds"
install_plugin "brianpetro/obsidian-smart-connections" "smart-connections"

# Wizualizacja
install_plugin "rien7/obsidian-colorful-tag" "colorful-tag"
install_plugin "FlorianWoelki/obsidian-icon-folder" "icon-folder"

echo "🎉 Wszystkie pluginy zainstalowane!"
echo "🔄 Przeładuj Obsidiana i włącz w Community Plugins"
```


## 🎯 Konfiguracja kolorów tagów

```json
{
  "tag-colors": {
    "#obsidian": "#7c3aed",
    "#graph": "#3b82f6",
    "#visualization": "#06b6d4",
    "#tools": "#10b981",
    "#plugins": "#f59e0b",
    "#jakubc": "#3b82f6",
    "#karinam": "#ec4899",
    "#candy": "#f472b6",
    "#business": "#8b5cf6",
    "#technical": "#06b6d4",
    "#documentation": "#10b981",
    "#ai": "#f59e0b",
    "#automation": "#ef4444"
  }
}
```


## 📚 Źródła

- [[GitHub CLI Tools]]
- [[Obsidian Plugins Management]]
- [[Graph Visualization Best Practices]]

## 🔗 Backlinki

```dataview
LIST FROM [[]] AND !"Templates"
```


**Aktualizacja:** 2025-11-21  
**Autor:** jakubc  
**Status:** ✅ Gotowe do użycia
