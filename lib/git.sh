# shell lib: git helpers
repo_root(){ git rev-parse --show-toplevel 2>/dev/null || pwd; }
