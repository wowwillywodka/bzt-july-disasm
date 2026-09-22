; $01F364..$01F37F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Выбор кадра направления актёра (d0=1; d2=1/2/3 по $39), общий выход → $1f380 (постинг draw-пакета)
        ifne *-$1F364
        fail "ROM start moved"
        endif

ActorsRoutine_01F364:
        move.w       #$1, d0                                       ; $01F364
        move.w       #$1, d2                                       ; $01F368
        bra.b        ActorsRoutine_01F380                          ; $01F36C

loc_01F36E:
        move.w       #$1, d0                                       ; $01F36E
        move.w       #$2, d2                                       ; $01F372
        bra.b        ActorsRoutine_01F380                          ; $01F376

loc_01F378:
        move.w       #$1, d0                                       ; $01F378
        move.w       #$3, d2                                       ; $01F37C
        ifne *-$1F380
        fail "ROM end moved"
        endif
