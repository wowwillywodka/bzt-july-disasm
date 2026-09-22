; $009F80..$009F9B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг поворота игрока (вариант 1): сдвиг угла (-0x71d8) на 1, сброс инерции (-0x71d6/-0x71d2), выставление флага направления поворота в (-0x7205) при сброшенном бите 7
        ifne *-$9F80
        fail "ROM start moved"
        endif

CollisionRoutine_009F80:
        asr.w        -$71d8(a6)                                    ; $009F80
        clr.w        -$71d6(a6)                                    ; $009F84
        clr.w        -$71d2(a6)                                    ; $009F88
        btst.b       #$7, -$7205(a6)                               ; $009F8C
        bne.b        loc_009F9A                                    ; $009F92
        move.b       #$80, -$7205(a6)                              ; $009F94

loc_009F9A:
        rts                                                        ; $009F9A
        ifne *-$9F9C
        fail "ROM end moved"
        endif
