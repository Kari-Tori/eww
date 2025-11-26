#!/usr/bin/env python3
"""
Zapewnia, że każdy folder note (#folder_note) ma sekcję Backlinks
z co najmniej 5 linkami (docelowo 5-7), dodając brakujące
odniesienia do głównych indeksów repozytorium.
"""
from __future__ import annotations

import re
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

MIN_LINKS = 5
MAX_SUGGESTED = 7

CANONICAL_LINKS = [
    ("EWW-MAP", "[[EWW-MAP]]"),
    ("GRAPH-MAP", "[[GRAPH-MAP]]"),
    ("GRAPH-CORE", "[[GRAPH-CORE]]"),
    ("GRAPH-BUSINESS", "[[GRAPH-BUSINESS]]"),
    ("GRAPH-CONFIG", "[[GRAPH-CONFIG]]"),
    ("INDEX", "[[INDEX]]"),
    ("STATUS-REPO", "[[STATUS-REPO]]"),
    ("GRAPH-READY", "[[GRAPH-READY]]"),
    ("TAG-STRATEGY", "[[TAG-STRATEGY]]"),
    ("AI-AUTO-TAG-PLAN", "[[AI-AUTO-TAG-PLAN]]"),
    ("README", "[[README]]"),
    ("CHANGELOG", "[[CHANGELOG]]"),
]

BACKLINK_SECTION_RE = re.compile(
    r'(?:\n|\A)(##\s+🔗\s+Backlink\w*[^\n]*\n(?:.*?))(?:\n##\s|\Z)',
    flags=re.IGNORECASE | re.DOTALL,
)

WIKILINK_RE = re.compile(r"\[\[([^\]|]+)(?:\|([^\]]+))?\]\]")


def extract_frontmatter(content: str) -> str | None:
    """Zwraca treść frontmattera (pierwszy blok --- ... ---) lub None."""
    match = re.search(r"---\n(.*?)\n---\n", content, flags=re.DOTALL)
    if not match:
        return None
    return match.group(1)


def is_folder_note(content: str) -> bool:
    """Sprawdza, czy plik ma tag #folder_note w frontmatterze."""
    frontmatter = extract_frontmatter(content)
    if not frontmatter:
        return False
    return "#folder_note" in frontmatter


def parse_links(block: str) -> list[tuple[str, str]]:
    """Zwraca listę (target, wikilink) z sekcji backlinków (bez duplikatów)."""
    seen = set()
    links: list[tuple[str, str]] = []
    for match in WIKILINK_RE.finditer(block):
        target = match.group(1).strip()
        alias = match.group(2).strip() if match.group(2) else None
        display = f"[[{target}|{alias}]]" if alias else f"[[{target}]]"
        if target not in seen:
            seen.add(target)
            links.append((target, display))
    return links


def build_block(links: list[tuple[str, str]]) -> str:
    """Składa sekcję backlinków zgodną z konwencją."""
    limited = links[:MAX_SUGGESTED] if len(links) > MAX_SUGGESTED else links
    lines = ["## 🔗 Backlinks", ""]
    lines.extend(f"- {display}" for _, display in limited)
    lines.append("")
    return "\n".join(lines)


def ensure_links(links: list[tuple[str, str]]) -> list[tuple[str, str]]:
    """Uzupełnia listę linków do minimum wymaganego progu."""
    if len(links) >= MIN_LINKS:
        return links

    existing = {target for target, _ in links}
    extended = list(links)

    for target, display in CANONICAL_LINKS:
        if len(extended) >= MIN_LINKS:
            break
        if target not in existing:
            extended.append((target, display))
            existing.add(target)

    return extended


def update_file(path: Path) -> tuple[bool, int]:
    """Aktualizuje folder note, zwraca (czy_zmieniono, liczba_linków)."""
    try:
        content = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return False, 0

    if not is_folder_note(content):
        return False, 0

    match = BACKLINK_SECTION_RE.search(content)

    if match:
        existing_links = parse_links(match.group(1))
    else:
        existing_links = []

    ensured_links = ensure_links(existing_links)
    if len(ensured_links) < MIN_LINKS:
        # Nie udało się zapełnić – brak kandydatów
        return False, len(ensured_links)

    if len(existing_links) >= MIN_LINKS:
        # Sekcja istnieje i spełnia minimum – nic nie rób
        return False, len(existing_links)

    new_block = build_block(ensured_links)

    if match:
        start, end = match.span(1)
        updated_content = content[:start] + new_block + "\n\n" + content[end:]
    else:
        updated_content = content.rstrip() + "\n\n" + new_block + "\n"

    path.write_text(updated_content, encoding="utf-8")
    return True, len(ensured_links)


def main() -> None:
    updated = 0
    skipped = 0

    for md_file in sorted(REPO_ROOT.rglob("*.md")):
        # Pomijaj ukryte katalogi
        rel_parts = md_file.relative_to(REPO_ROOT).parts
        if any(part.startswith(".") for part in rel_parts):
            continue

        changed, links = update_file(md_file)
        if changed:
            updated += 1
            rel_path = md_file.relative_to(REPO_ROOT)
            print(f"[update] {rel_path} -> {links} backlinks")
        else:
            skipped += 1

    print("\n✅ Backlink enforcement complete")
    print(f"   Zaktualizowano: {updated}")
    print(f"   Pomiętych/już OK: {skipped}")


if __name__ == "__main__":
    main()
