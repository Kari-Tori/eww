#!/usr/bin/env python3
# generate-version-report.py - Generuje raport braków wersji w frontmatterach
"""
Generuje raport plików Markdown bez frontmatter lub bez pola version.
Wynik zapisywany jest w docs/reports/frontmatter-version-gap.md
"""

import pathlib
import sys

def main():
    root = pathlib.Path(".")
    skip_dirs = {".git", ".obsidian", ".space", "node_modules", "vendor", ".vale", ".trash"}

    md_files = []
    for p in root.rglob("*.md"):
        if any(part in skip_dirs for part in p.parts):
            continue
        md_files.append(p)

    no_fm = []
    fm_no_ver = []

    for p in sorted(md_files):
        try:
            text = p.read_text(encoding="utf-8", errors="ignore").splitlines()
            if not text or text[0].strip() != "---":
                no_fm.append(p)
                continue

            try:
                end = text[1:].index("---") + 1
            except ValueError:
                no_fm.append(p)
                continue

            fm_block = text[1:end]
            if not any(line.lstrip().startswith("version:") for line in fm_block):
                fm_no_ver.append(p)

        except Exception as e:
            print(f"Błąd przetwarzania {p}: {e}", file=sys.stderr)

    # Generuj raport
    print("# Frontmatter version gap report\n")
    print("## Brak frontmatteru")
    for p in no_fm:
        print(f"- {p}")
    print(f"\n**Razem:** {len(no_fm)} plików\n")

    print("## Frontmatter bez pola version")
    for p in fm_no_ver:
        print(f"- {p}")
    print(f"\n**Razem:** {len(fm_no_ver)} plików\n")

    print("---")
    print(f"**Łącznie plików do naprawy:** {len(no_fm) + len(fm_no_ver)}")

if __name__ == "__main__":
    main()
