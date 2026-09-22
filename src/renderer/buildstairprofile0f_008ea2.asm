; $008EA2..$008ED3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8D02] профиль ЛЕСТНИЦ (семейство 8C64-8D66, по одному на ct 0x0C-0x11): 8 байт граней → -0x6E4C/-0x6E48 по знаку -0x6E52
        ifne *-$8EA2
        fail "ROM start moved"
        endif

BuildStairProfile0F:
        tst.w        -$6e4c(a6)                                    ; $008EA2
        bmi.b        loc_008EBE                                    ; $008EA6
        move.l       #$40404040, -$6e46(a6)                        ; $008EA8
        move.l       #$40404040, -$6e42(a6)                        ; $008EB0
        move.w       #$1, d3                                       ; $008EB8
        rts                                                        ; $008EBC

loc_008EBE:
        move.l       #$c0c0c0c0, -$6e46(a6)                        ; $008EBE
        move.l       #$c0c0c0c0, -$6e42(a6)                        ; $008EC6
        move.w       #$1, d3                                       ; $008ECE
        rts                                                        ; $008ED2
        ifne *-$8ED4
        fail "ROM end moved"
        endif
