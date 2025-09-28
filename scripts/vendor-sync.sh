#!/usr/bin/env bash
set -euo pipefail

export REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export SOURCES_FILE="$REPO_ROOT/scripts/doc_sync/sources.yml"

if [[ ! -f "$SOURCES_FILE" ]]; then
  echo "[!] sources.yml not found at $SOURCES_FILE" >&2
  exit 1
fi

python3 - <<'PY'
import sys
import os
import yaml
import requests
import re
from html import unescape

repo_root = os.environ.get("REPO_ROOT")
sources_file = os.environ.get("SOURCES_FILE")

def html_to_markdown(html: str) -> str:
    cleaned = re.sub(r"(?is)<(script|style).*?</\1>", "", html)
    cleaned = re.sub(r"<br\s*/?>", "\n", cleaned)
    cleaned = re.sub(r"</(p|div|li|h[1-6])>", "\n", cleaned)
    cleaned = re.sub(r"<[^>]+>", "", cleaned)
    cleaned = unescape(cleaned)
    lines = [line.strip() for line in cleaned.splitlines()]
    return "\n".join(line for line in lines if line)

with open(sources_file, "r", encoding="utf-8") as f:
    data = yaml.safe_load(f)

sources = data.get("sources", {})
if not sources:
    print("[!] No sources defined in sources.yml", file=sys.stderr)
    sys.exit(1)

for name, meta in sources.items():
    url = meta.get("url")
    outfile = meta.get("outfile")
    title = meta.get("title", name.replace("_", " ").title())
    if not url or not outfile:
        print(f"[!] Skipping {name}; missing url or outfile", file=sys.stderr)
        continue

    dest_path = os.path.join(repo_root, outfile)
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)

    print(f"[*] Fetch {name}: {url}")
    resp = requests.get(url, timeout=30)
    resp.raise_for_status()

    body = html_to_markdown(resp.text)
    header = f"# {title}\n\nSource: {url}\n\n"

    with open(dest_path, "w", encoding="utf-8") as out_f:
        out_f.write(header)
        out_f.write(body)

print("[*] Vendor sync complete")
PY
