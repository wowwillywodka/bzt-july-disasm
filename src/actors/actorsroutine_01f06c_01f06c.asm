; $01F06C..$01F07F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Выбор параметров анимации (d0=2 ряд, d2=1 столбец) для направленного кадра актёра, общий хвост → $1f088 (lea -$6fdc(a6),a0; jmp $1ffcc)
        ifne *-$1F06C
        fail "ROM start moved"
        endif

ActorsRoutine_01F06C:
        move.w       #$2, d0                                       ; $01F06C
        move.w       #$1, d2                                       ; $01F070
        bra.b        loc_01F088                                    ; $01F074

loc_01F076:
        move.w       #$2, d0                                       ; $01F076
        move.w       #$2, d2                                       ; $01F07A
        bra.b        loc_01F088                                    ; $01F07E
        ifne *-$1F080
        fail "ROM end moved"
        endif
