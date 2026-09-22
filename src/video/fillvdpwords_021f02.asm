; $021F02..$021F0F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Заливка VRAM/CRAM словом D0: цикл dbf на D1 раз пишет D0 в порт данных VDP $C00000 (fill-петля)
        ifne *-$21F02
        fail "ROM start moved"
        endif

FillVdpWords:
        subq.w       #$1, d1                                       ; $021F02

loc_021F04:
        move.w       d0, VDP_DATA.l                                ; $021F04
        dbra         d1, loc_021F04                                ; $021F0A
        rts                                                        ; $021F0E
        ifne *-$21F10
        fail "ROM end moved"
        endif
