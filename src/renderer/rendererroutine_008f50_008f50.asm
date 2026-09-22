; $008F50..$008F81 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8DB0] ПРОФИЛИ ТРАНЗИТОВ ct 0x38-0x4B по направлениям (семейство 8DB0-901E, по одному на ct)
        ifne *-$8F50
        fail "ROM start moved"
        endif

RendererRoutine_008F50:
        tst.w        -$6e4c(a6)                                    ; $008F50
        ble.b        loc_008F6C                                    ; $008F54
        move.l       #$7f7f4040, -$6e46(a6)                        ; $008F56
        move.l       #$407f7f40, -$6e42(a6)                        ; $008F5E
        move.w       #$1, d3                                       ; $008F66
        rts                                                        ; $008F6A

loc_008F6C:
        move.l       #$c0c0, -$6e46(a6)                            ; $008F6C
        move.l       #$c00000c0, -$6e42(a6)                        ; $008F74
        move.w       #$1, d3                                       ; $008F7C
        rts                                                        ; $008F80
        ifne *-$8F82
        fail "ROM end moved"
        endif
