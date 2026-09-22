; $07F564..$07F611 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка горизонтального индикатора/полосы: цикл D4 от 0xFF вниз, по порогам (0x18/0xC8) выбирает значение тайла 0x140 либо 0x0 и пишет его через 0x07fe0a — заполнение строки бара цветными/пустыми ячейками
        ifne *-$7F564
        fail "ROM start moved"
        endif

DrawHorizontalGauge:
        move.w       #$ff, d4                                      ; $07F564

loc_07F568:
        move.w       d4, -(a7)                                     ; $07F568
        cmpi.w       #$18, d4                                      ; $07F56A
        bhi.w        loc_07F57A                                    ; $07F56E

loc_07F572:
        move.w       #$140, d0                                     ; $07F572
        bra.w        loc_07F584                                    ; $07F576

loc_07F57A:
        cmpi.w       #$c8, d4                                      ; $07F57A
        bhi.b        loc_07F572                                    ; $07F57E
        move.w       #$0, d0                                       ; $07F580

loc_07F584:
        jsr          WriteTextPlaneCell.l                          ; $07F584
        move.w       (a7)+, d4                                     ; $07F58A
        dbra         d4, loc_07F568                                ; $07F58C
        rts                                                        ; $07F590

loc_07F592:
        move.w       #$41, d0                                      ; $07F592
        jsr          loc_07ACE4(pc)                                ; $07F596
        lea.l        loc_081C5C.l, a0                              ; $07F59A
        move.w       #$1, d0                                       ; $07F5A0
        move.w       #$3aa, d1                                     ; $07F5A4
        jsr          UploadTiles.l                                 ; $07F5A8
        lea.l        loc_081C5C.l, a0                              ; $07F5AE
        movea.w      #$0, a1                                       ; $07F5B4
        move.w       #$28, d0                                      ; $07F5B8
        move.w       #$1c, d1                                      ; $07F5BC
        move.w       #$80, d2                                      ; $07F5C0
        move.w       #$1, d3                                       ; $07F5C4
        jsr          loc_021EFA.l                                  ; $07F5C8
        lea.l        loc_081C5C.l, a0                              ; $07F5CE
        lea.l        $ff0778.l, a1                                 ; $07F5D4
        jsr          CopyOneTile.l                                 ; $07F5DA
        lea.l        InterfacePalettes.l, a0                       ; $07F5E0
        lea.l        $ff07d8.l, a1                                 ; $07F5E6
        jsr          CopyOneTile.l                                 ; $07F5EC
        lea.l        $ff0778.l, a0                                 ; $07F5F2
        move.w       #$4, d1                                       ; $07F5F8
        jsr          loc_022010.l                                  ; $07F5FC
        lea.l        BriefingDayOneText.l, a0                      ; $07F602
        jsr          RunBriefingTextLoop.l                         ; $07F608
        bra.w        loc_07F6A2                                    ; $07F60E
        ifne *-$7F612
        fail "ROM end moved"
        endif
