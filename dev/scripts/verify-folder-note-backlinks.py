#!/usr/bin/env python3
"""
Weryfikuje, że każdy folder note (tag #folder_note) posiada ≥3 backlinki.
"""
from __future__ import annotations

import re
from collections import defaultdict
from pathlib import Path
from typing import Dict, List, Set

REPO_ROOT = Path(__file__).resolve().parent.parent

FRONTMATTER_RE = re.compile(r"---\n(.*?)\n---\n", re.DOTALL)
WIKILINK_RE = re.compile(r"\[\[(.*?)\]\]")

SKIP_DIRS = {
    ".git",
    ".github",
    ".obsidian",
    ".continue",
    ".vscode",
    "node_modules",
    "archive/.trash",
}


def extract_frontmatter(content: str) -> str | None:
    match = FRONTMATTER_RE.search(content)
    if not match:
        return None
    return match.group(1)


def is_folder_note(path: Path) -> bool:
    try:
        content = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return False

    frontmatter = extract_frontmatter(content)
    return bool(frontmatter and "#folder_note" in frontmatter)


def list_markdown_files() -> List[Path]:
    files: List[Path] = []
    for path in REPO_ROOT.rglob("*.md"):
        rel = path.relative_to(REPO_ROOT)
        if any(part.startswith(".") for part in rel.parts):
            continue
        if any(str(rel).startswith(skip) for skip in SKIP_DIRS):
            continue
        files.append(path)
    return files


def collect_folder_notes(files: List[Path]) -> Dict[str, Path]:
    notes: Dict[str, Path] = {}
    for path in files:
        if is_folder_note(path):
            rel = path.relative_to(REPO_ROOT)
            key = str(rel.with_suffix(""))
            notes[key] = path
    return notes


def build_backlink_map(files: List[Path], notes: Dict[str, Path]) -> Dict[str, Set[str]]:
    backlinks: Dict[str, Set[str]] = defaultdict(set)

    keys = set(notes.keys())
    basenames = {Path(k).name: k for k in keys}

    for path in files:
        rel = path.relative_to(REPO_ROOT)
        try:
            content = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue

        for match in WIKILINK_RE.finditer(content):
            target = match.group(1).strip()
            if not target:
                continue

            normalized = target.split("|")[0]
            normalized = normalized.strip()

            if normalized in keys:
                backlinks[normalized].add(str(rel))
            elif normalized in basenames:
                backlinks[basenames[normalized]].add(str(rel))

    return backlinks


def main() -> None:
    files = list_markdown_files()
    notes = collect_folder_notes(files)

    if not notes:
        print("Brak folder notes.")
        return

    backlinks = build_backlink_map(files, notes)

    missing: List[tuple[str, int]] = []
    for key in sorted(notes.keys()):
        count = len(backlinks.get(key, set()))
        if count < 3:
            missing.append((key, count))

    print(f"📂 Folder notes wykryte: {len(notes)}")
    print(f"✅ Folder notes z ≥3 backlinkami: {len(notes) - len(missing)}")
    print(f"⚠️ Folder notes <3 backlinków: {len(missing)}")

    if missing:
        print("\nLista plików wymagających dodatkowych backlinków:")
        for key, count in missing[:50]:
            print(f" - {key} ({count})")
        if len(missing) > 50:
            print(f"... i {len(missing) - 50} więcej")
    else:
        print("\nWszystkie folder notes spełniają wymaganie.")


if __name__ == "__main__":
    main()
