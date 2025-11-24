#!/usr/bin/env python3
"""
eww-connect-graph.py - Automatyczne łączenie grafu projektu
Znajduje izolowane pliki i tworzy inteligentne połączenia
"""

import os
import re
import sys
from pathlib import Path
from typing import List, Set, Dict
from collections import defaultdict

class GraphConnector:
    def __init__(self, root_path: Path):
        self.root = root_path
        self.files_metadata = {}  # filepath -> {tags, category, keywords}

    def scan_files(self, directory: str = "docs") -> List[Path]:
        """Zeskanuj wszystkie pliki .md"""
        target_dir = self.root / directory
        return list(target_dir.rglob("*.md"))

    def extract_metadata(self, filepath: Path) -> Dict:
        """Wyciągnij metadane z frontmatter"""
        metadata = {
            'tags': set(),
            'keywords': set(),
            'category': '',
            'title': '',
            'related': [],
            'backlinks': []
        }

        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Znajdź frontmatter
            match = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
            if not match:
                return metadata

            frontmatter = match.group(1)

            # Tags
            tags_match = re.search(r'tags:\s*\n((?:  - .+\n)+)', frontmatter)
            if tags_match:
                metadata['tags'] = set(re.findall(r'  - (.+)', tags_match.group(1)))

            # Keywords
            kw_match = re.search(r'keywords:\s*\n((?:  - .+\n)+)', frontmatter)
            if kw_match:
                metadata['keywords'] = set(re.findall(r'  - (.+)', kw_match.group(1)))

            # Category
            cat_match = re.search(r'category:\s*(.+)', frontmatter)
            if cat_match:
                metadata['category'] = cat_match.group(1).strip()

            # Title
            title_match = re.search(r'title:\s*(.+)', frontmatter)
            if title_match:
                metadata['title'] = title_match.group(1).strip()

            # Related
            rel_match = re.search(r'related:\s*\n((?:  - .+\n)+)', frontmatter)
            if rel_match:
                metadata['related'] = re.findall(r'  - (.+)', rel_match.group(1))

            # Backlinks
            back_match = re.search(r'backlinks:\s*\[(.*?)\]', frontmatter)
            if back_match:
                bl = back_match.group(1).strip()
                if bl:
                    metadata['backlinks'] = [b.strip() for b in bl.split(',')]

        except Exception as e:
            print(f"⚠️  Błąd czytania {filepath}: {e}", file=sys.stderr)

        return metadata

    def is_isolated(self, metadata: Dict) -> bool:
        """Sprawdź czy plik jest izolowany"""
        return (not metadata['related'] or metadata['related'] == []) and \
               (not metadata['backlinks'] or metadata['backlinks'] == [])

    def find_related(self, filepath: Path, metadata: Dict, limit: int = 5) -> List[str]:
        """Znajdź powiązane pliki"""
        candidates = defaultdict(int)  # filepath -> score

        for other_path, other_meta in self.files_metadata.items():
            if other_path == filepath:
                continue

            score = 0

            # Wspólne tagi (+3 za każdy)
            common_tags = metadata['tags'] & other_meta['tags']
            score += len(common_tags) * 3

            # Wspólne keywords (+2 za każdy)
            common_kw = metadata['keywords'] & other_meta['keywords']
            score += len(common_kw) * 2

            # Ta sama kategoria (+5)
            if metadata['category'] and metadata['category'] == other_meta['category']:
                score += 5

            # Podobne tytuły (+4)
            if metadata['title'] and other_meta['title']:
                title1_words = set(metadata['title'].lower().split())
                title2_words = set(other_meta['title'].lower().split())
                common_words = title1_words & title2_words
                if len(common_words) >= 2:
                    score += 4

            if score > 0:
                rel_path = other_path.relative_to(self.root)
                candidates[str(rel_path)] = score

        # Zwróć top N
        sorted_candidates = sorted(candidates.items(), key=lambda x: x[1], reverse=True)
        return [path for path, score in sorted_candidates[:limit]]

    def update_frontmatter(self, filepath: Path, new_related: List[str], dry_run: bool = False) -> bool:
        """Zaktualizuj related w frontmatter"""
        if not new_related:
            return False

        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Znajdź frontmatter
            frontmatter_match = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
            if not frontmatter_match:
                print(f"  ⚠️  Brak frontmatter w {filepath}")
                return False

            frontmatter = frontmatter_match.group(1)

            # Zbuduj nowe related
            related_block = 'related:\n' + '\n'.join([f'  - {rel}' for rel in new_related])

            # Sprawdź czy jest related:
            if re.search(r'^related:', frontmatter, re.MULTILINE):
                # Zamień istniejący - usuń stary blok related do następnego pola lub końca
                new_frontmatter = re.sub(
                    r'^related:.*?(?=\n[a-z_]+:|$)',
                    related_block,
                    frontmatter,
                    flags=re.MULTILINE | re.DOTALL
                )
            else:
                # Dodaj przed cssclasses: lub na końcu frontmatter
                if 'cssclasses:' in frontmatter:
                    new_frontmatter = frontmatter.replace(
                        'cssclasses:',
                        related_block + '\ncssclasses:'
                    )
                else:
                    # Dodaj na końcu
                    new_frontmatter = frontmatter.rstrip() + '\n' + related_block

            # Zamień cały frontmatter
            new_content = content.replace(
                f'---\n{frontmatter}\n---',
                f'---\n{new_frontmatter}\n---',
                1
            )

            if dry_run:
                return True

            # Zapisz
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)

            return True

        except Exception as e:
            print(f"  ❌ Błąd aktualizacji {filepath}: {e}")
            return False

    def connect_graph(self, directory: str = "docs", dry_run: bool = False):
        """Główna funkcja łącząca graf"""
        print("🔍 Skanowanie plików...")
        files = self.scan_files(directory)
        print(f"   Znaleziono {len(files)} plików .md\n")

        print("📊 Wydobywanie metadanych...")
        for filepath in files:
            self.files_metadata[filepath] = self.extract_metadata(filepath)
        print(f"   Przetworzono {len(self.files_metadata)} plików\n")

        print("🔗 Łączenie izolowanych węzłów...\n")

        isolated_count = 0
        connected_count = 0
        failed_count = 0

        for filepath, metadata in self.files_metadata.items():
            if not self.is_isolated(metadata):
                continue

            isolated_count += 1
            rel_path = filepath.relative_to(self.root)
            print(f"🔴 Izolowany: {rel_path}")

            # Znajdź powiązania
            related = self.find_related(filepath, metadata)

            if not related:
                print(f"   ❌ Brak kandydatów")
                failed_count += 1
                continue

            print(f"   ✅ Znaleziono {len(related)} powiązań:")
            for r in related:
                print(f"      → {r}")

            if self.update_frontmatter(filepath, related, dry_run):
                connected_count += 1
                if not dry_run:
                    print(f"   ✅ Zaktualizowano")
            else:
                failed_count += 1

            print()

        print("=" * 60)
        print("📊 PODSUMOWANIE")
        print("=" * 60)
        print(f"Znalezione izolowane: {isolated_count}")
        print(f"Połączone: {connected_count}")
        print(f"Błędy: {failed_count}")
        print(f"Pozostałe: {isolated_count - connected_count - failed_count}")

    def generate_report(self, directory: str = "docs"):
        """Generuj raport grafu"""
        files = self.scan_files(directory)

        for filepath in files:
            self.files_metadata[filepath] = self.extract_metadata(filepath)

        total = len(self.files_metadata)
        isolated = sum(1 for meta in self.files_metadata.values() if self.is_isolated(meta))
        connected = total - isolated

        print("=" * 60)
        print("📊 RAPORT GRAFU PROJEKTU")
        print("=" * 60)
        import datetime
        print(f"Data: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}")
        print()
        print(f"Pliki .md: {total}")
        print(f"Połączone: {connected} ({connected*100//total if total > 0 else 0}%)")
        print(f"Izolowane: {isolated} ({isolated*100//total if total > 0 else 0}%)")
        print()
        print("🔴 Izolowane pliki (próbka 20):")

        count = 0
        for filepath, metadata in self.files_metadata.items():
            if self.is_isolated(metadata) and count < 20:
                rel_path = filepath.relative_to(self.root)
                print(f"  - {rel_path}")
                count += 1

def main():
    import argparse

    parser = argparse.ArgumentParser(description='Automatyczne łączenie grafu projektu')
    parser.add_argument('-d', '--dry-run', action='store_true', help='Podgląd bez zmian')
    parser.add_argument('-r', '--report', action='store_true', help='Generuj raport grafu')
    parser.add_argument('-t', '--target', default='docs', help='Katalog docelowy')

    args = parser.parse_args()

    root = Path(__file__).parent.parent
    connector = GraphConnector(root)

    if args.report:
        connector.generate_report(args.target)
    else:
        connector.connect_graph(args.target, args.dry_run)

if __name__ == '__main__':
    main()
