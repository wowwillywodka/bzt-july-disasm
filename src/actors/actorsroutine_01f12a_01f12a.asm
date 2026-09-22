; $01F12A..$01F145 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Выбор кадра направления актёра (d0=2; d2=1/2/3 по $39) и общий выход → $1f146 (постинг draw-пакета в $1ffcc)
        ifne *-$1F12A
        fail "ROM start moved"
        endif

ActorsRoutine_01F12A:
        move.w       #$2, d0                                       ; $01F12A
        move.w       #$1, d2                                       ; $01F12E
        bra.b        ActorsRoutine_01F146                          ; $01F132

loc_01F134:
        move.w       #$2, d0                                       ; $01F134
        move.w       #$2, d2                                       ; $01F138
        bra.b        ActorsRoutine_01F146                          ; $01F13C

loc_01F13E:
        move.w       #$2, d0                                       ; $01F13E
        move.w       #$3, d2                                       ; $01F142
        ifne *-$1F146
        fail "ROM end moved"
        endif
