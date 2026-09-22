; $0033A2..$0033E3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка списка видимых объектов: сканирует сетку карты от (0x39fc,A6)+offset, сравнивает каждый байт клетки с маркером актёра (-0x790e,A6); при совпадении пишет координаты (col D0, row D1) в буфер (-0x429e,A6), терминирует список словом #-1
        ifne *-$33A2
        fail "ROM start moved"
        endif

CollectVisibleMapObjects:
        lea.l        rEpisodeMapCells(a6), a0                      ; $0033A2
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $0033A6
        lea.l        -$429e(a6), a1                                ; $0033AA
        move.w       rCurrentFloorHeight(a6), d7                   ; $0033AE
        move.b       -$790e(a6), d4                                ; $0033B2
        subq.w       #$1, d7                                       ; $0033B6
        clr.w        d1                                            ; $0033B8

loc_0033BA:
        clr.w        d0                                            ; $0033BA
        move.w       rCurrentFloorWidth(a6), d6                    ; $0033BC
        move.w       d6, d5                                        ; $0033C0
        subq.w       #$1, d6                                       ; $0033C2
        move.l       a0, -(a7)                                     ; $0033C4

loc_0033C6:
        cmp.b        (a0)+, d4                                     ; $0033C6
        bne.b        loc_0033CE                                    ; $0033C8
        move.b       d0, (a1)+                                     ; $0033CA
        move.b       d1, (a1)+                                     ; $0033CC

loc_0033CE:
        addq.w       #$1, d0                                       ; $0033CE
        dbra         d6, loc_0033C6                                ; $0033D0
        movea.l      (a7)+, a0                                     ; $0033D4
        addq.w       #$1, d1                                       ; $0033D6
        adda.w       d5, a0                                        ; $0033D8
        dbra         d7, loc_0033BA                                ; $0033DA
        move.w       #$ffff, (a1)+                                 ; $0033DE
        rts                                                        ; $0033E2
        ifne *-$33E4
        fail "ROM end moved"
        endif
