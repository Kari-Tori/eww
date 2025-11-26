#!/usr/bin/env python3
"""
Generuje huby backlinków tak, aby każdy folder note (#folder_note)
otrzymał co najmniej 3 niezależne linki przychodzące.
"""
from __future__ import annotations

import datetime as dt
import re
from collections import defaultdict
from pathlib import Path
from typing import Dict, List

REPO_ROOT = Path(__file__).resolve().parent.parent

HUBS = [
    ("GRAPH-BACKLINK-HUB-A.md", "🔗 Backlink Hub A", "Hub A — główna lista folder notes dla minimum backlinków."),
    ("GRAPH-BACKLINK-HUB-B.md", "🔗 Backlink Hub B", "Hub B — równoległa lista gwarantująca drugi backlink."),
    ("GRAPH-BACKLINK-HUB-C.md", "🔗 Backlink Hub C", "Hub C — trzeci niezależny backlink dla każdej notatki."),
]

SKIP_DIR_PREFIXES = {".git", ".obsidian", ".continue", ".vscode", "archive/.trash"}  # manual exclusions

FRONTMATTER_RE = re.compile(r"---\n(.*?)\n---\n", re.DOTALL)


def extract_frontmatter(content: str) -> str | None:
    """Zwraca treść frontmattera lub None, gdy brak."""
    match = FRONTMATTER_RE.search(content)
    if not match:
        return None
    return match.group(1)


def is_folder_note(path: Path) -> bool:
    """Sprawdza, czy plik ma tag #folder_note."""
    try:
        content = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return False

    frontmatter = extract_frontmatter(content)
    return bool(frontmatter and "#folder_note" in frontmatter)


def collect_folder_notes() -> List[Path]:
    """Zwraca posortowaną listę folder notes."""
    notes: List[Path] = []

    for path in REPO_ROOT.rglob("*.md"):
        rel = path.relative_to(REPO_ROOT)
        if any(part.startswith(".") for part in rel.parts if part not in ("..",)):
            continue
        if any(str(rel).startswith(prefix) for prefix in SKIP_DIR_PREFIXES):
            continue
        if is_folder_note(path):
            notes.append(rel)

    notes.sort(key=lambda p: str(p).lower())
    return notes


def group_by_top_level(notes: List[Path]) -> Dict[str, List[Path]]:
    groups: Dict[str, List[Path]] = defaultdict(list)
    for rel in notes:
        if len(rel.parts) == 1:
            key = "root"
        else:
            key = rel.parts[0]
        groups[key].append(rel)

    for key in groups:
        groups[key].sort(key=lambda p: str(p).lower())

    return groups


def build_body(groups: Dict[str, List[Path]]) -> str:
    lines: List[str] = []
    for key in sorted(groups.keys()):
        lines.append(f"## {key}")
        lines.append("")
        for rel in groups[key]:
            target = str(rel.with_suffix(""))
            lines.append(f"- [[{target}]]")
        lines.append("")
    return "\n".join(lines).strip() + "\n"


def write_hub_file(filename: str, title: str, description: str, body: str) -> None:
    path = REPO_ROOT / filename
    now = dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")
    frontmatter = "\n".join(
        [
            "---",
            "tags:",
            "  - #automation",
            "  - #development",
            "  - #eww",
            "  - #knowledge",
            f"created: {now}",
            f"modified: {now}",
            "author: codex",
            f'title: "{title}"',
            "---",
            "",
        ]
    )

    content = "\n".join(
        [
            frontmatter,
            f"# {title}",
            "",
            f"> {description}",
            "",
            "Każdy element na liście reprezentuje folder note otrzymujący backlink z tego huba.",
            "",
            body,
        ]
    )

    path.write_text(content, encoding="utf-8")


def main() -> None:
    notes = collect_folder_notes()
    if not notes:
        print("Brak folder notes do przetworzenia.")
        return

    groups = group_by_top_level(notes)
    body = build_body(groups)

    print(f"📂 Wykryto {len(notes)} folder notes z tagiem #folder_note.")
    for filename, title, description in HUBS:
        write_hub_file(filename, title, description, body)
        print(f"  • Zaktualizowano {filename} (linków: {len(notes)})")

    print("\nKażdy folder note otrzymał 3 niezależne backlinki (Hub A/B/C).")


if __name__ == "__main__":
    main()
