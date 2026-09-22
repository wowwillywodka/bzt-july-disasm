; $008E68..$008EA1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8CC8] профиль ЛЕСТНИЦ (семейство 8C64-8D66, по одному на ct 0x0C-0x11): 8 байт граней → -0x6E4C/-0x6E48 по знаку -0x6E52
        ifne *-$8E68
        fail "ROM start moved"
        endif

BuildStairProfile0E:
        tst.w        -$6e4c(a6)                                    ; $008E68
        beq.b        loc_008E9C                                    ; $008E6C
        bmi.b        loc_008E86                                    ; $008E6E

loc_008E70:
        move.l       #$40404040, -$6e46(a6)                        ; $008E70
        move.l       #$40404040, -$6e42(a6)                        ; $008E78
        move.w       #$1, d3                                       ; $008E80
        rts                                                        ; $008E84

loc_008E86:
        move.l       #$c0c0c0c0, -$6e46(a6)                        ; $008E86
        move.l       #$c0c0c0c0, -$6e42(a6)                        ; $008E8E
        move.w       #$1, d3                                       ; $008E96
        rts                                                        ; $008E9A

loc_008E9C:
        tst.w        d0                                            ; $008E9C
        bmi.b        loc_008E70                                    ; $008E9E
        bra.b        loc_008E86                                    ; $008EA0
        ifne *-$8EA2
        fail "ROM end moved"
        endif
