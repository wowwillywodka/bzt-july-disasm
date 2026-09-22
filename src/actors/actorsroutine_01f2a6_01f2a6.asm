; $01F2A6..$01F2B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Выбор кадра направления актёра (d0=1; d2=1/2/3 по $39), общий выход → $1f2c2 (постинг draw-пакета)
        ifne *-$1F2A6
        fail "ROM start moved"
        endif

ActorsRoutine_01F2A6:
        move.w       #$1, d0                                       ; $01F2A6
        move.w       #$1, d2                                       ; $01F2AA
        bra.b        ActorsRoutine_01F2C2                          ; $01F2AE

loc_01F2B0:
        move.w       #$1, d0                                       ; $01F2B0
        move.w       #$2, d2                                       ; $01F2B4
        bra.b        ActorsRoutine_01F2C2                          ; $01F2B8
        ifne *-$1F2BA
        fail "ROM end moved"
        endif
