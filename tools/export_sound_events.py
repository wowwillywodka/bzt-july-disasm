#!/usr/bin/env python3
"""Export the July GEMS event table from a locally built ROM.

The CSV is written under build/ and is deliberately not a published source asset.
"""
import argparse
import csv
import hashlib
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ROM_SHA256 = '8f0af150b642e1e190566a96d19732695164d926244764407560949cee02d8b0'
TABLE_START = 0x7AA98
TABLE_END = 0x7AC27
EVENT_COUNT = (TABLE_END - TABLE_START) // 3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--rom', type=Path, default=ROOT / 'build/bztjuly.bin')
    parser.add_argument('--output', type=Path, default=ROOT / 'build/sound_events.csv')
    args = parser.parse_args()
    rom = args.rom.read_bytes()
    if hashlib.sha256(rom).hexdigest() != ROM_SHA256:
        parser.error('input is not the pinned July ROM')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('w', newline='', encoding='utf-8') as output:
        writer = csv.writer(output)
        writer.writerow(('event_id_hex', 'rom_offset_hex', 'class', 'parameter_1_hex', 'parameter_2_hex'))
        for event_id in range(EVENT_COUNT):
            offset = TABLE_START + event_id * 3
            event_class, first, second = rom[offset:offset + 3]
            if event_class > 3:
                parser.error(f'unexpected event class {event_class} at ${offset:06X}')
            writer.writerow((f'{event_id:02X}', f'{offset:06X}', event_class, f'{first:02X}', f'{second:02X}'))
    print(f'Exported {EVENT_COUNT} events to {args.output}')


if __name__ == '__main__':
    main()
