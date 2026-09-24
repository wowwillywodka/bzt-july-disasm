#!/usr/bin/env python3
"""July BZT's nine-character *ordinary* password bit format.

Tables are read from a locally built ROM. No alphabet or password payload is
embedded in this script. Cheat phrases take an earlier, separate ROM path.
"""
from __future__ import annotations

import argparse
from dataclasses import dataclass
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
KEY = 0x56CA2D69


@dataclass(frozen=True)
class Tables:
    alphabet: str
    keyboard: str
    permutation: tuple[int, ...]
    capacities: tuple[int, ...]
    stage_gate: tuple[int, ...]
    cheats: tuple[tuple[str, int], ...]


def tables_from_rom(rom: bytes) -> Tables:
    alphabet = rom[0x29AD8:0x29B18].decode('ascii')
    keyboard = rom[0x29A90:0x29AD0].decode('ascii')
    permutation = tuple(rom[0x29B18:0x29B4E])
    capacities = tuple(int.from_bytes(rom[0x11F24 + i * 2:0x11F26 + i * 2], 'big')
                       for i in range(18))
    stage_gate = tuple(rom[0x2A410:0x2A450])
    cheat_compare_addresses = (
        (0x29F62, 0x29F68, 0x29F70, 0x29F78, 0x29F80, 0x29F88, 0x29F90, 0x29F98, 0x29FA0),
        (0x29FB6, 0x29FBC, 0x29FC4, 0x29FCC, 0x29FD4, 0x29FDC, 0x29FE4, 0x29FEC, 0x29FF4),
        (0x2A00A, 0x2A012, 0x2A01C, 0x2A026, 0x2A02E, 0x2A036, 0x2A03E, 0x2A046, 0x2A04E),
    )
    cheats = tuple((''.join(chr(rom[address + 3]) for address in addresses),
                    rom[selection_address + 3])
                   for addresses, selection_address in zip(
                       cheat_compare_addresses, (0x29FAC, 0x2A000, 0x2A08E)))
    if (len(alphabet) != 64 or len(set(alphabet)) != 64 or
            len(keyboard) != 64 or set(alphabet) != set(keyboard) or
            sorted(permutation) != list(range(54)) or len(stage_gate) != 64 or
            len(capacities) != 18):
        raise ValueError('July password tables do not match the reviewed ROM')
    return Tables(alphabet, keyboard, permutation, capacities, stage_gate, cheats)


def little_bits(data: bytes, count: int) -> list[int]:
    return [(data[i // 8] >> (i % 8)) & 1 for i in range(count)]


def pack_bits(bits: list[int], size: int) -> bytes:
    data = bytearray(size)
    for i, bit in enumerate(bits):
        data[i // 8] |= (bit & 1) << (i % 8)
    return bytes(data)


def bits_of(value: int, count: int) -> list[int]:
    return [(value >> i) & 1 for i in range(count)]


def value_of(bits: list[int]) -> int:
    return sum(bit << i for i, bit in enumerate(bits))


def checksum(payload: list[int]) -> int:
    if len(payload) != 46:
        raise ValueError('password payload must contain 46 bits')
    return (sum(value_of(payload[i:i + 8]) for i in range(0, 40, 8)) +
            value_of(payload[40:46])) & 0xFF


def xor_stream(data: bytes) -> bytes:
    key = KEY
    result = bytearray()
    for byte in data:
        result.append(byte ^ (key & 0xFF))
        key = ((key >> 7) | (key << 25)) & 0xFFFFFFFF
        key = ((key & 0xFFFF) << 16) | (key >> 16)
    return bytes(result)


def encode_fields(tables: Tables, *, available: list[int], item_ids: list[int],
                  quantity_codes: list[int], health_code: int, episode_code: int) -> str:
    """Encode the values consumed by EncodeProgressPassword, before scaling.

    quantity_codes are five three-bit values aligned with ascending item IDs;
    unused positions are still serialized. episode_code is the full six bits
    emitted by the encoder, although the decoder keeps only its low nibble.
    """
    if len(available) != 5 or any(value not in (0, 1) for value in available):
        raise ValueError('available must contain five bits')
    if (len(item_ids) > 5 or len(set(item_ids)) != len(item_ids) or
            any(not 1 <= value <= 14 for value in item_ids)):
        raise ValueError('item_ids must contain at most five unique IDs 1..14')
    if len(quantity_codes) != 5 or any(not 0 <= value < 8 for value in quantity_codes):
        raise ValueError('quantity_codes must contain five values 0..7')
    if not 0 <= health_code < 64 or not 0 <= episode_code < 64:
        raise ValueError('health_code and episode_code must be 0..63')
    mask = sum(1 << (item_id - 1) for item_id in item_ids)
    payload = list(available) + bits_of(mask, 14)
    for value in quantity_codes:
        payload.extend(bits_of(value, 3))
    payload.extend(bits_of(health_code, 6))
    payload.extend(bits_of(episode_code, 6))
    payload.extend(bits_of(checksum(payload), 8))
    assert len(payload) == 54
    scrambled = [0] * 54
    for index, target in enumerate(tables.permutation):
        scrambled[target] = payload[index]
    encrypted = xor_stream(pack_bits(scrambled, 7))
    encoded_bits = little_bits(encrypted, 54)
    return ''.join(tables.alphabet[value_of(encoded_bits[i:i + 6])]
                   for i in range(0, 54, 6))


def decode_ordinary(tables: Tables, code: str) -> dict:
    """Decode the ordinary path. Unknown ASCII maps to index $2D in ROM."""
    if len(code) != 9:
        raise ValueError('July passwords contain exactly nine characters')
    alphabet_index = {char: i for i, char in enumerate(tables.alphabet)}
    unknown = [char for char in code if char not in alphabet_index]
    values = [alphabet_index.get(char, 0x2D) for char in code]
    encoded_bits = [bit for value in values for bit in bits_of(value, 6)]
    # The game's seven-byte XOR touches two unprinted high bits. They never
    # enter the 54-bit payload because the valid permutation is 0..53.
    scrambled = xor_stream(pack_bits(encoded_bits, 7))
    scrambled_bits = little_bits(scrambled, 54)
    plain = [scrambled_bits[index] for index in tables.permutation]
    expected = checksum(plain[:46])
    found = value_of(plain[46:54])
    flags = plain[:5]
    mask = value_of(plain[5:19])
    item_ids = [i for i in range(1, 15) if mask & (1 << (i - 1))]
    amounts = [value_of(plain[19 + i * 3:22 + i * 3]) for i in range(5)]
    health_code = value_of(plain[34:40])
    episode_code = value_of(plain[40:46])
    status = ('bad-checksum' if found != expected else
              'too-many-items' if len(item_ids) > 5 else
              'stage-table-reject' if not tables.stage_gate[1] else 'ok')
    applied = status == 'ok'
    return {
        'status': status, 'code': code, 'unknown_characters_mapped_to_index_45': unknown,
        'checksum': {'stored': found, 'calculated': expected},
        'available': flags, 'item_ids': item_ids, 'quantity_codes': amounts,
        'health_code': health_code, 'episode_code': episode_code,
        'applied_state': ({
            'geometry_episode': episode_code & 0xF, 'level_selection': 1,
            'item_ids': item_ids,
            'item_amounts': [((2 * amounts[i] + 1) * tables.capacities[item_id]) >> 12
                             for i, item_id in enumerate(item_ids)],
            'health': ((2 * health_code + 1) * 100) >> 7,
        } if applied else None),
        'partial_saved_state_write_on_item_overflow': status == 'too-many-items',
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--rom', type=Path, default=ROOT / 'build/bztjuly.bin',
                        help='locally built July ROM (default: build/bztjuly.bin)')
    commands = parser.add_subparsers(dest='command', required=True)
    decode = commands.add_parser('decode', help='decode an ordinary nine-character password')
    decode.add_argument('code')
    encode = commands.add_parser('encode', help='encode pre-quantized password fields')
    encode.add_argument('--available', default='11111', help='five 0/1 character flags')
    encode.add_argument('--items', default='', help='comma-separated item IDs 1..14')
    encode.add_argument('--quantities', default='0,0,0,0,0',
                        help='five three-bit amount codes in ascending item-ID order')
    encode.add_argument('--health', type=int, required=True, help='six-bit health code')
    encode.add_argument('--episode', type=int, required=True, help='six-bit episode code')
    args = parser.parse_args()
    tables = tables_from_rom(args.rom.read_bytes())
    if args.command == 'decode':
        special = next(((index, selection) for index, (phrase, selection)
                        in enumerate(tables.cheats) if phrase == args.code), None)
        result = ({'status': 'special-phrase', 'code': args.code,
                   'special_index': special[0], 'level_selection': special[1],
                   'geometry_episode_written': False}
                  if special is not None else decode_ordinary(tables, args.code))
    else:
        code = encode_fields(tables, available=[int(x) for x in args.available],
                             item_ids=[int(x) for x in args.items.split(',') if x],
                             quantity_codes=[int(x) for x in args.quantities.split(',')],
                             health_code=args.health, episode_code=args.episode)
        result = {'code': code, 'decoded': decode_ordinary(tables, code)}
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
