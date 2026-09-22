; $008F06..$008F4F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8D66] профиль ЛЕСТНИЦ (семейство 8C64-8D66, по одному на ct 0x0C-0x11): 8 байт граней → -0x6E4C/-0x6E48 по знаку -0x6E52
        ifne *-$8F06
        fail "ROM start moved"
        endif

BuildStairProfile11:
        tst.w        -$6e4c(a6)                                    ; $008F06
        beq.b        loc_008F3A                                    ; $008F0A
        bmi.b        loc_008F24                                    ; $008F0C
        move.l       #$40407f00, -$6e46(a6)                        ; $008F0E
        move.l       #$40407f, -$6e42(a6)                          ; $008F16
        move.w       #$1, d3                                       ; $008F1E
        rts                                                        ; $008F22

loc_008F24:
        move.l       #$c0c00080, -$6e46(a6)                        ; $008F24
        move.l       #$80c0c000, -$6e42(a6)                        ; $008F2C
        move.w       #$1, d3                                       ; $008F34
        rts                                                        ; $008F38

loc_008F3A:
        move.l       #$40c00000, -$6e46(a6)                        ; $008F3A
        move.l       #$40c000, -$6e42(a6)                          ; $008F42
        move.w       #$1, d3                                       ; $008F4A
        rts                                                        ; $008F4E
        ifne *-$8F50
        fail "ROM end moved"
        endif
