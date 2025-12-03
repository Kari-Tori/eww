#!/usr/bin/env python3
"""
Odbudowa historii wersji z Git dla wszystkich plików Markdown.

Dla każdego pliku .md:
- created: data pierwszego commitu
- modified: data ostatniego commitu
- version: 0.0.{liczba_commitów_modyfikujących_plik}

Użycie:
    ./rebuild-version-history.py [--dry-run] [--verbose]
"""

import subprocess
import pathlib
import datetime
import re
import sys
from typing import Optional, Tuple

# Katalogi do pominięcia
SKIP_DIRS = {".git", ".obsidian", ".space", "node_modules", "vendor", ".vale", ".trash"}

def skip_path(p: pathlib.Path) -> bool:
    """Sprawdź czy ścieżka powinna być pominięta."""
    return any(part in SKIP_DIRS for part in p.parts)

def get_git_history(file_path: pathlib.Path) -> Optional[Tuple[str, str, int]]:
    """
    Pobierz historię pliku z Git.

    Returns:
        (created_date, modified_date, commit_count) lub None jeśli plik nie jest w Git
    """
    try:
        # Data pierwszego commitu (oldest)
        result = subprocess.run(
            ["git", "log", "--follow", "--format=%ai", "--", str(file_path)],
            capture_output=True,
            text=True,
            check=True
        )
        dates = [line.strip() for line in result.stdout.strip().split("\n") if line.strip()]

        if not dates:
            return None

        # Ostatnia data = najstarsza (git log pokazuje od najnowszego)
        created_raw = dates[-1]
        modified_raw = dates[0]

        # Parsuj daty ISO
        created = datetime.datetime.fromisoformat(created_raw.split()[0]).date().isoformat()
        modified = datetime.datetime.fromisoformat(modified_raw.split()[0]).date().isoformat()

        # Liczba commitów
        commit_count = len(dates)

        return (created, modified, commit_count)

    except subprocess.CalledProcessError:
        return None

def parse_frontmatter(lines: list) -> Tuple[Optional[int], Optional[int], dict]:
    """
    Parsuj frontmatter YAML.

    Returns:
        (start_idx, end_idx, fields_dict) lub (None, None, {}) jeśli brak FM
    """
    if not lines or lines[0].strip() != "---":
        return (None, None, {})

    try:
        end_idx = None
        for i, line in enumerate(lines[1:], start=1):
            if line.strip() == "---":
                end_idx = i
                break

        if end_idx is None:
            return (None, None, {})

        # Parsuj pola
        fm_lines = lines[1:end_idx]
        fields = {}
        current_key = None

        for line in fm_lines:
            # Klucz: wartość
            if ":" in line and not line.startswith(" ") and not line.startswith("\t"):
                key, _, value = line.partition(":")
                key = key.strip()
                value = value.strip()
                fields[key] = value
                current_key = key
            # Kontynuacja (lista/multiline)
            elif current_key and (line.startswith("  ") or line.startswith("\t")):
                if current_key not in fields:
                    fields[current_key] = []
                if isinstance(fields[current_key], list):
                    fields[current_key].append(line.strip())
                else:
                    fields[current_key] += " " + line.strip()

        return (0, end_idx, fields)

    except Exception:
        return (None, None, {})

def update_frontmatter(file_path: pathlib.Path, created: str, modified: str, version: str, dry_run: bool = False, verbose: bool = False) -> bool:
    """
    Aktualizuj frontmatter pliku z danymi z Git.

    Returns:
        True jeśli dokonano zmian, False w przeciwnym razie
    """
    try:
        content = file_path.read_text(encoding="utf-8", errors="ignore")
        lines = content.splitlines()

        start_idx, end_idx, fields = parse_frontmatter(lines)

        # Sprawdź czy trzeba coś zmienić
        needs_update = False
        if start_idx is None:
            needs_update = True
        else:
            if fields.get("version") != version:
                needs_update = True
            if fields.get("created") != created:
                needs_update = True
            if fields.get("modified") != modified:
                needs_update = True

        if not needs_update:
            if verbose:
                print(f"  ⏭️  Pomijam (aktualne): {file_path}")
            return False

        # Utwórz lub zaktualizuj frontmatter
        if start_idx is None:
            # Brak frontmattera - utwórz nowy
            new_fm = [
                "---",
                f"version: {version}",
                f"title: \"{file_path.stem}\"",
                f"created: {created}",
                f"modified: {modified}",
                "tags:",
                "  - auto-versioned",
                "---",
                "",
            ]
            new_content = "\n".join(new_fm + lines)
        else:
            # Zaktualizuj istniejący
            fm_lines = lines[1:end_idx]

            # Aktualizuj pola
            updated_fm = []
            version_set = created_set = modified_set = False

            for line in fm_lines:
                if line.strip().startswith("version:"):
                    updated_fm.append(f"version: {version}")
                    version_set = True
                elif line.strip().startswith("created:"):
                    updated_fm.append(f"created: {created}")
                    created_set = True
                elif line.strip().startswith("modified:"):
                    updated_fm.append(f"modified: {modified}")
                    modified_set = True
                else:
                    updated_fm.append(line)

            # Dodaj brakujące pola
            if not version_set:
                updated_fm.insert(0, f"version: {version}")
            if not created_set:
                updated_fm.insert(1 if version_set else 0, f"created: {created}")
            if not modified_set:
                updated_fm.insert(2 if version_set and created_set else (1 if version_set or created_set else 0), f"modified: {modified}")

            new_content = "\n".join(["---"] + updated_fm + ["---"] + lines[end_idx+1:])

        if dry_run:
            print(f"  🔍 [DRY-RUN] Zaktualizowałbym: {file_path}")
            print(f"     version: {version}, created: {created}, modified: {modified}")
            return True

        file_path.write_text(new_content, encoding="utf-8")
        print(f"  ✅ Zaktualizowano: {file_path}")
        print(f"     version: {version}, created: {created}, modified: {modified}")
        return True

    except Exception as e:
        print(f"  ❌ Błąd przy {file_path}: {e}", file=sys.stderr)
        return False

def main():
    """Główna funkcja skryptu."""
    import argparse

    parser = argparse.ArgumentParser(description="Odbudowa historii wersji z Git")
    parser.add_argument("--dry-run", action="store_true", help="Tylko pokaż co zostałoby zmienione")
    parser.add_argument("--verbose", "-v", action="store_true", help="Wyświetlaj szczegółowe informacje")
    args = parser.parse_args()

    root = pathlib.Path.cwd()
    md_files = [p for p in root.rglob("*.md") if not skip_path(p)]

    print(f"\n🔍 Znaleziono {len(md_files)} plików Markdown")
    print(f"{'🔍 [DRY-RUN] ' if args.dry_run else ''}Odbudowa historii wersji...\n")

    updated_count = 0
    skipped_count = 0
    no_git_count = 0

    for file_path in sorted(md_files):
        history = get_git_history(file_path)

        if history is None:
            if args.verbose:
                print(f"  ⚠️  Brak historii Git: {file_path}")
            no_git_count += 1
            continue

        created, modified, commit_count = history

        # Wersja bazuje na liczbie commitów
        # Dla 1 commita: 0.0.1, dla 5: 0.0.5, dla 100: 0.1.0
        if commit_count <= 99:
            version = f"0.0.{commit_count}"
        else:
            minor = commit_count // 100
            patch = commit_count % 100
            version = f"0.{minor}.{patch}"

        if update_frontmatter(file_path, created, modified, version, args.dry_run, args.verbose):
            updated_count += 1
        else:
            skipped_count += 1

    print(f"\n{'🔍 [DRY-RUN] ' if args.dry_run else ''}✅ Zakończono!")
    print(f"  📝 Zaktualizowano: {updated_count}")
    print(f"  ⏭️  Pominięto (aktualne): {skipped_count}")
    print(f"  ⚠️  Bez historii Git: {no_git_count}")
    print(f"  📊 Razem: {len(md_files)}\n")

if __name__ == "__main__":
    main()
