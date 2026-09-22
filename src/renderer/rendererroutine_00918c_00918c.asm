; $00918C..$0091BD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8FEC] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$918C
        fail "ROM start moved"
        endif

RendererRoutine_00918C:
        tst.w        -$6e4c(a6)                                    ; $00918C
        bmi.b        loc_0091A8                                    ; $009190
        move.l       #$404000, -$6e46(a6)                          ; $009192
        move.l       #$4040, -$6e42(a6)                            ; $00919A
        move.w       #$1, d3                                       ; $0091A2
        rts                                                        ; $0091A6

loc_0091A8:
        move.l       #$80c0c080, -$6e46(a6)                        ; $0091A8
        move.l       #$8080c0c0, -$6e42(a6)                        ; $0091B0
        move.w       #$1, d3                                       ; $0091B8
        rts                                                        ; $0091BC
        ifne *-$91BE
        fail "ROM end moved"
        endif
