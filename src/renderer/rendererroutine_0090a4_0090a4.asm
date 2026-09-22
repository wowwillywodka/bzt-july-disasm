; $0090A4..$0090D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8F04] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$90A4
        fail "ROM start moved"
        endif

RendererRoutine_0090A4:
        tst.w        -$6e4c(a6)                                    ; $0090A4
        bmi.b        loc_0090C0                                    ; $0090A8
        move.l       #$40000040, -$6e46(a6)                        ; $0090AA
        move.l       #$40400000, -$6e42(a6)                        ; $0090B2
        move.w       #$1, d3                                       ; $0090BA
        rts                                                        ; $0090BE

loc_0090C0:
        move.l       #$c08080c0, -$6e46(a6)                        ; $0090C0
        move.l       #$c0c08080, -$6e42(a6)                        ; $0090C8
        move.w       #$1, d3                                       ; $0090D0
        rts                                                        ; $0090D4
        ifne *-$90D6
        fail "ROM end moved"
        endif
