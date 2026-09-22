; $008FBC..$008FED | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8E1C] профиль ТРАНЗИТА ct 0x38-0x4B (семейство 8DB0-901E, направленные варианты)
        ifne *-$8FBC
        fail "ROM start moved"
        endif

RendererRoutine_008FBC:
        tst.w        -$6e4c(a6)                                    ; $008FBC
        bmi.b        loc_008FD8                                    ; $008FC0
        move.l       #$4040, -$6e46(a6)                            ; $008FC2
        move.l       #$40000040, -$6e42(a6)                        ; $008FCA
        move.w       #$1, d3                                       ; $008FD2
        rts                                                        ; $008FD6

loc_008FD8:
        move.l       #$8080c0c0, -$6e46(a6)                        ; $008FD8
        move.l       #$c08080c0, -$6e42(a6)                        ; $008FE0
        move.w       #$1, d3                                       ; $008FE8
        rts                                                        ; $008FEC
        ifne *-$8FEE
        fail "ROM end moved"
        endif
