#!/usr/bin/env python3
"""Reject a public source tree that contains ROM payloads outside generated/."""
from __future__ import annotations

import json
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
ALLOWED_TOP_LEVEL = {".gitignore", "Makefile", "README.md", "include", "main.asm", "metadata", "src", "tools"}
IGNORED_TOP_LEVEL = {".git", ".tools", "build", "generated", "__pycache__"}
DATA_DIRECTIVE = re.compile(r"^\s*dc\.[bwl]\b", re.MULTILINE | re.IGNORECASE)
INCBIN = re.compile(r'^\s*incbin\s+"([^"]+)"\s*$', re.MULTILINE | re.IGNORECASE)


def main() -> int:
    errors: list[str] = []
    layout = json.loads((ROOT / "metadata" / "layout.json").read_text())
    resources = json.loads((ROOT / "metadata" / "extraction_manifest.json").read_text())["resources"]
    resource_by_source = {row["source"]: row for row in resources}
    cursor = 0
    for row in layout:
        if row["start"] != cursor or row["end"] <= row["start"]:
            errors.append(f"invalid layout near ${cursor:06X}")
        cursor = row["end"]
    if cursor != 0x300000:
        errors.append("layout does not cover the complete ROM")
    for source, row in resource_by_source.items():
        path = ROOT / source
        if not path.is_file():
            errors.append(f"missing resource stub: {source}")
            continue
        text = path.read_text()
        if DATA_DIRECTIVE.search(text):
            errors.append(f"raw data directive in resource stub: {source}")
        targets = INCBIN.findall(text)
        if targets != [row["path"]]:
            errors.append(f"unexpected incbin target in {source}")
    for item in ROOT.iterdir():
        if item.name not in ALLOWED_TOP_LEVEL | IGNORED_TOP_LEVEL:
            errors.append(f"unexpected top-level publication file: {item.name}")
    for path in ROOT.rglob("*.bin"):
        if not any(part in IGNORED_TOP_LEVEL for part in path.relative_to(ROOT).parts):
            errors.append(f"binary file outside ignored build directories: {path.relative_to(ROOT)}")
    ignore = (ROOT / ".gitignore").read_text()
    for required in ("/build/", "/generated/", "/.tools/", "*.bin"):
        if required not in ignore:
            errors.append(f".gitignore lacks {required}")
    if errors:
        print("Public-release audit failed:")
        print("\n".join("- " + error for error in errors))
        return 1
    print(f"Public-release audit passed: {len(resources)} ROM resource stubs, no published payload files.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
