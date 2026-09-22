#!/usr/bin/env python3
"""Extract ignored build resources from an owner-supplied July prototype ROM."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import tempfile


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "metadata" / "extraction_manifest.json"


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def replace_generated(staging: Path, target: Path) -> None:
    if target.exists() and target.is_symlink():
        raise RuntimeError(f"Refusing to replace symlink: {target}")
    backup = target.with_name(target.name + ".previous")
    if backup.exists():
        shutil.rmtree(backup)
    if target.exists():
        target.rename(backup)
    try:
        os.replace(staging, target)
    except Exception:
        if backup.exists():
            backup.rename(target)
        raise
    shutil.rmtree(backup, ignore_errors=True)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--rom", required=True, type=Path, help="owner-supplied prototype ROM")
    args = ap.parse_args()
    manifest = json.loads(MANIFEST_PATH.read_text())
    rom_path = args.rom.expanduser().resolve()
    data = rom_path.read_bytes()
    identity = manifest["rom"]
    if len(data) != identity["size"]:
        ap.error(f"ROM size is {len(data):,}; expected {identity['size']:,}")
    if digest(data) != identity["sha256"]:
        ap.error("ROM SHA-256 is not the pinned July prototype")
    target = ROOT / "generated"
    staging = Path(tempfile.mkdtemp(prefix=".generated-tmp-", dir=ROOT))
    count = 0
    total = 0
    try:
        for row in manifest["resources"]:
            rel = Path(row["path"])
            if rel.is_absolute() or ".." in rel.parts or rel.parts[:2] != ("generated", "data"):
                raise RuntimeError(f"Unsafe manifest path: {row['path']}")
            payload = data[row["start"]:row["end"]]
            if len(payload) != row["end"] - row["start"] or digest(payload) != row["sha256"]:
                raise RuntimeError(f"Resource validation failed at ${row['start']:06X}")
            output = staging / rel.relative_to("generated")
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_bytes(payload)
            count += 1
            total += len(payload)
        replace_generated(staging, target)
    except Exception:
        shutil.rmtree(staging, ignore_errors=True)
        raise
    print(f"Extracted {count} resource partitions ({total:,} bytes) into {target}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
