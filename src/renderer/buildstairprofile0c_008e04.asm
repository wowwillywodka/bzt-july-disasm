; $008E04..$008E35 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 8C64] ПРОФИЛЬ ЛЕСТНИЦ ct 0x0C-0x11 (семейство 8C64/8C96/8CC8/8D02/8D34/8D66): пишет 8 байт профиля граней в -0x6E4C/-0x6E48(a6) по знаку -0x6E52 (напр. 40407F7F/7F40407F вверх vs C0C00000/00C0C000 вниз — ТЕ ЖЕ значения, что ZT §9.1 ZT_TRANSIT_RENDER); June-аналог ZT-профилей -0x6e8c..-0x6e86
        ifne *-$8E04
        fail "ROM start moved"
        endif

BuildStairProfile0C:
        tst.w        -$6e4c(a6)                                    ; $008E04
        ble.b        loc_008E20                                    ; $008E08
        move.l       #$40407f7f, -$6e46(a6)                        ; $008E0A
        move.l       #$7f40407f, -$6e42(a6)                        ; $008E12
        move.w       #$1, d3                                       ; $008E1A
        rts                                                        ; $008E1E

loc_008E20:
        move.l       #$c0c00000, -$6e46(a6)                        ; $008E20
        move.l       #$c0c000, -$6e42(a6)                          ; $008E28
        move.w       #$1, d3                                       ; $008E30
        rts                                                        ; $008E34
        ifne *-$8E36
        fail "ROM end moved"
        endif
