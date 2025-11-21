#!/usr/bin/env bats

# Test: listuje zainstalowane wtyczki i zawiera nazwy oraz wersje

setup() {
  VAULT_DIR="$(mktemp -d)"
  mkdir -p "$VAULT_DIR/.obsidian/plugins/plugin-a"
  mkdir -p "$VAULT_DIR/.obsidian/plugins/plugin-b"

  cat > "$VAULT_DIR/.obsidian/plugins/plugin-a/manifest.json" <<'JSON'
{
  "id": "plugin-a",
  "name": "Plugin A",
  "version": "1.2.3",
  "description": "Opis Plugin A"
}
JSON

  cat > "$VAULT_DIR/.obsidian/plugins/plugin-b/manifest.json" <<'JSON'
{
  "id": "plugin-b",
  "name": "Plugin B",
  "version": "0.0.7",
  "description": "Opis Plugin B"
}
JSON
}

teardown() {
  rm -rf "$VAULT_DIR"
  rm -f /tmp/eww_code_plugins_list.txt 2>/dev/null || true
}

@test "skrypt wypisuje nazwy i wersje pluginów" {
  run bash ./scripts/list_code_plugins.sh "$VAULT_DIR"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Plugin A"* ]]
  [[ "$output" == *"1.2.3"* ]]
  [[ "$output" == *"Plugin B"* ]]
  [[ "$output" == *"0.0.7"* ]]
}
