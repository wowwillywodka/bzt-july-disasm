; $0078BC..$007903 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Драйвер компоновки колонок (FPS-оружие/HUD) в буфер -$1db6(A6): цикл D1=0x1f, A4=$FF884A(0xa4a,A6); tst.w (A4)+ — при НУЛЕ bsr 0x7904 блитит колонку (move.b (A5)+ шаг 4), при НЕ-нуле колонку ПРОПУСКАЕТ; A5 ±0x50, A0 +=0x13d между строками
        ifne *-$78BC
        fail "ROM start moved"
        endif

ComposeColumnBlocks:
        lea.l        -$1db6(a6), a0                                ; $0078BC
        lea.l        $a4a(a6), a4                                  ; $0078C0
        move.w       #$1f, d1                                      ; $0078C4
        lea.l        $b4a(a6), a5                                  ; $0078C8

loc_0078CC:
        lea.l        $50(a5), a5                                   ; $0078CC
        tst.w        (a4)+                                         ; $0078D0
        bne.b        loc_0078D6                                    ; $0078D2
        bsr.b        CopySevenPixelColumn                          ; $0078D4

loc_0078D6:
        addq.w       #$1, a0                                       ; $0078D6
        lea.l        -$50(a5), a5                                  ; $0078D8
        tst.w        (a4)+                                         ; $0078DC
        bne.b        loc_0078E2                                    ; $0078DE
        bsr.b        CopySevenPixelColumn                          ; $0078E0

loc_0078E2:
        addq.w       #$1, a0                                       ; $0078E2
        lea.l        $50(a5), a5                                   ; $0078E4
        tst.w        (a4)+                                         ; $0078E8
        bne.b        loc_0078EE                                    ; $0078EA
        bsr.b        CopySevenPixelColumn                          ; $0078EC

loc_0078EE:
        addq.w       #$1, a0                                       ; $0078EE
        lea.l        -$50(a5), a5                                  ; $0078F0
        tst.w        (a4)+                                         ; $0078F4
        bne.b        loc_0078FA                                    ; $0078F6
        bsr.b        CopySevenPixelColumn                          ; $0078F8

loc_0078FA:
        adda.w       #$13d, a0                                     ; $0078FA
        dbra         d1, loc_0078CC                                ; $0078FE
        rts                                                        ; $007902
        ifne *-$7904
        fail "ROM end moved"
        endif
