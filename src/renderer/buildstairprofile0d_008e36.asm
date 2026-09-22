; $008E36..$008E67 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8C96] профиль ЛЕСТНИЦ (семейство 8C64-8D66, по одному на ct 0x0C-0x11): 8 байт граней → -0x6E4C/-0x6E48 по знаку -0x6E52
        ifne *-$8E36
        fail "ROM start moved"
        endif

BuildStairProfile0D:
        tst.w        -$6e4c(a6)                                    ; $008E36
        ble.b        loc_008E52                                    ; $008E3A
        move.l       #$40404040, -$6e46(a6)                        ; $008E3C
        move.l       #$40404040, -$6e42(a6)                        ; $008E44
        move.w       #$1, d3                                       ; $008E4C
        rts                                                        ; $008E50

loc_008E52:
        move.l       #$c0c0c0c0, -$6e46(a6)                        ; $008E52
        move.l       #$c0c0c0c0, -$6e42(a6)                        ; $008E5A
        move.w       #$1, d3                                       ; $008E62
        rts                                                        ; $008E66
        ifne *-$8E68
        fail "ROM end moved"
        endif
