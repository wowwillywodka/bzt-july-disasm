; $021DB0..$021DC1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Ожидание кадров VBlank: читает счётчик кадров (-0x8000,A6), прибавляет D0, busy-wait пока счётчик не достигнет цели — синхронизация на N кадров
        ifne *-$21DB0
        fail "ROM start moved"
        endif

WaitVBlankFrames:
        move.l       d1, -(a7)                                     ; $021DB0
        move.w       rVBlankCounter(a6), d1                        ; $021DB2
        add.w        d0, d1                                        ; $021DB6

loc_021DB8:
        cmp.w        rVBlankCounter(a6), d1                        ; $021DB8
        bgt.b        loc_021DB8                                    ; $021DBC
        move.l       (a7)+, d1                                     ; $021DBE
        rts                                                        ; $021DC0
        ifne *-$21DC2
        fail "ROM end moved"
        endif
