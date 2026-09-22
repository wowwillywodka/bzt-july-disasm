#!/usr/bin/env python3
"""Check layout and exact identity of a rebuilt July prototype image."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
META = ROOT / "metadata"


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def verify(image: Path, reference: Path | None = None) -> dict:
    manifest = json.loads((META / "extraction_manifest.json").read_text())
    layout = json.loads((META / "layout.json").read_text())
    data = image.read_bytes()
    errors: list[str] = []
    identity = manifest["rom"]
    if len(data) != identity["size"]:
        errors.append(f"Size differs: {len(data)} != {identity['size']}")
    image_sha = sha256(data)
    if image_sha != identity["sha256"]:
        errors.append("ROM SHA-256 differs from pinned July prototype")
    cursor = 0
    for row in layout:
        if row["start"] != cursor or row["end"] <= row["start"]:
            errors.append(f"Layout gap/overlap at ${cursor:06X}")
        if not (ROOT / row["file"]).is_file():
            errors.append("Missing source: " + row["file"])
        cursor = row["end"]
    if cursor != identity["size"]:
        errors.append("Layout does not cover complete ROM")
    differences = None
    samples: list[dict] = []
    if reference is not None:
        original = reference.read_bytes()
        if sha256(original) != identity["sha256"]:
            errors.append("Reference is not the pinned July ROM")
        differences = sum(a != b for a, b in zip(data, original)) + abs(len(data) - len(original))
        if differences:
            errors.append(f"{differences} differing bytes")
            for address, (built, expected) in enumerate(zip(data, original)):
                if built != expected:
                    samples.append({"address": f"{address:06X}", "built": built, "reference": expected})
                    if len(samples) == 16:
                        break
    return {
        "ok": not errors,
        "size": len(data),
        "sha256": image_sha,
        "reference_compared": reference is not None,
        "differing_bytes": differences,
        "errors": errors,
        "first_differences": samples,
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("image", nargs="?", type=Path, default=ROOT / "build" / "bztjuly.bin")
    ap.add_argument("--reference", type=Path)
    args = ap.parse_args()
    result = verify(args.image, args.reference)
    (ROOT / "build").mkdir(exist_ok=True)
    (ROOT / "build" / "verification.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))
    return 0 if result["ok"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
