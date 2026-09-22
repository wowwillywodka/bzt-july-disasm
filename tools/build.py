#!/usr/bin/env python3
"""Build both CPUs from editable sources. Does not read or extract the reference ROM."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
VASM_REPOSITORY='https://github.com/mbitsnbites/vasm-mirror.git'
VASM_REVISION='a13e7e728a3dd5a9ba468bf479119e0bc23e70fd'


def run(command, *, cwd=ROOT, log=None):
    p=subprocess.run(command,cwd=cwd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    if log:log.write_text(p.stdout)
    if p.returncode:
        print(p.stdout,file=sys.stderr)
        raise RuntimeError(f'Command failed ({p.returncode}): {command[0]}')
    return p.stdout


def assembler(cpu,syntax):
    override=os.environ.get('VASM_M68K' if cpu=='m68k' else 'VASM_Z80')
    if override:
        path=Path(override).expanduser().resolve()
        if not path.is_file():raise RuntimeError(f'Assembler not found: {path}')
        return path
    shared=ROOT.parent/'zt/.tools/vasm'/f'vasm{cpu}_{syntax}'
    if shared.is_file():return shared
    source=ROOT/'.tools/vasm'
    binary=source/f'vasm{cpu}_{syntax}'
    if binary.exists():return binary
    source.parent.mkdir(exist_ok=True)
    if not source.exists():
        print('Fetching pinned vasm source...',flush=True)
        run(['git','clone','--no-checkout',VASM_REPOSITORY,str(source)])
        run(['git','checkout','--detach',VASM_REVISION],cwd=source)
    revision=run(['git','rev-parse','HEAD'],cwd=source).strip()
    if revision!=VASM_REVISION:raise RuntimeError(f'Unexpected vasm source revision: {revision}')
    print(f'Compiling vasm {cpu}/{syntax}...',flush=True)
    run(['make',f'CPU={cpu}',f'SYNTAX={syntax}','-j4'],cwd=source,
        log=ROOT/'build'/f'toolchain-{cpu}.log')
    return binary


def build():
    out=ROOT/'build';out.mkdir(exist_ok=True)
    z80=assembler('z80','oldstyle');m68k=assembler('m68k','mot')
    # Write temporary products, so a failed build cannot masquerade as a new ROM.
    for program in ('gems','boot_reset','boot_legacy'):
        run([str(z80),'-Fbin','-L',f'build/{program}.lst','-o',f'build/{program}.tmp',
             f'src/sound/z80/{program}.asm'],log=out/f'{program}-assembly.log')
        (out/f'{program}.tmp').replace(out/f'{program}.bin')
    run([str(m68k),'-m68000','-Fbin','-no-opt','-spaces','-L','build/bztjuly.lst',
         '-o','build/bztjuly.tmp','main.asm'],log=out/'assembly.log')
    (out/'bztjuly.tmp').replace(out/'bztjuly.bin')
    print(f'Built {out/"bztjuly.bin"} ({(out/"bztjuly.bin").stat().st_size:,} bytes)')


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--bootstrap',action='store_true',help='only install the local pinned assemblers')
    args=ap.parse_args()
    try:
        (ROOT/'build').mkdir(exist_ok=True)
        if args.bootstrap:
            for cpu,syntax in [('m68k','mot'),('z80','oldstyle')]:print(assembler(cpu,syntax))
        else:build()
    except (RuntimeError,OSError) as e:
        print(str(e),file=sys.stderr);return 1
    return 0


if __name__=='__main__':sys.exit(main())
