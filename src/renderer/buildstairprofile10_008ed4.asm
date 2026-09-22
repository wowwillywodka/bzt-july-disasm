; $008ED4..$008F05 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8D34] профиль ЛЕСТНИЦ (семейство 8C64-8D66, по одному на ct 0x0C-0x11): 8 байт граней → -0x6E4C/-0x6E48 по знаку -0x6E52
        ifne *-$8ED4
        fail "ROM start moved"
        endif

BuildStairProfile10:
        tst.w        -$6e4c(a6)                                    ; $008ED4
        bmi.b        loc_008EF0                                    ; $008ED8
        move.l       #$40400000, -$6e46(a6)                        ; $008EDA
        move.l       #$404000, -$6e42(a6)                          ; $008EE2
        move.w       #$1, d3                                       ; $008EEA
        rts                                                        ; $008EEE

loc_008EF0:
        move.l       #$c0c08080, -$6e46(a6)                        ; $008EF0
        move.l       #$80c0c080, -$6e42(a6)                        ; $008EF8
        move.w       #$1, d3                                       ; $008F00
        rts                                                        ; $008F04
        ifne *-$8F06
        fail "ROM end moved"
        endif
