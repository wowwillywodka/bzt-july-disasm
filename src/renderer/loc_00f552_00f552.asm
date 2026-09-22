; $00F552..$00F6AF | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$F552
        fail "ROM start moved"
        endif

loc_00F552:
        lea.l        rEpisodeMapCells(a6), a0                      ; $00F552
        adda.w       rCurrentFloorMapOffset(a6), a0                ; $00F556
        move.w       rPlayerX(a6), d0                              ; $00F55A
        lsr.w        #$8, d0                                       ; $00F55E
        add.w        rMapWindowOriginX(a6), d0                     ; $00F560
        adda.w       d0, a0                                        ; $00F564
        move.w       rPlayerY(a6), d0                              ; $00F566
        lsr.w        #$8, d0                                       ; $00F56A
        add.w        rMapWindowOriginY(a6), d0                     ; $00F56C
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $00F570
        adda.w       d0, a0                                        ; $00F574
        move.l       a0, rPlayerCellPointer(a6)                    ; $00F576
        move.l       a0, -(a7)                                     ; $00F57A
        lea.l        rVisibleMapWindow(a6), a0                     ; $00F57C
        move.w       rPlayerX(a6), d0                              ; $00F580
        lsr.w        #$8, d0                                       ; $00F584
        adda.w       d0, a0                                        ; $00F586
        move.w       rPlayerY(a6), d0                              ; $00F588
        lsr.w        #$8, d0                                       ; $00F58C
        lsl.w        #$5, d0                                       ; $00F58E
        adda.w       d0, a0                                        ; $00F590
        movem.l      d5/a2, -(a7)                                  ; $00F592
        bsr.w        EnvironmentRoutine_00ED6C                     ; $00F596
        movem.l      (a7)+, d5/a2                                  ; $00F59A
        movea.l      (a7)+, a0                                     ; $00F59E
        cmpa.l       rPreviousPlayerCellPointer(a6), a0            ; $00F5A0
        beq.b        loc_00F5B6                                    ; $00F5A4
        move.w       d5, -(a7)                                     ; $00F5A6
        move.l       a0, rPreviousPlayerCellPointer(a6)            ; $00F5A8
        move.l       a2, -(a7)                                     ; $00F5AC
        bsr.w        EnvironmentRoutine_00EDAA                     ; $00F5AE
        movea.l      (a7)+, a2                                     ; $00F5B2
        move.w       (a7)+, d5                                     ; $00F5B4

loc_00F5B6:
        lea.l        rCellTypeByIndex(a6), a5                      ; $00F5B6
        clr.w        d3                                            ; $00F5BA
        move.w       #$c81a, d2                                    ; $00F5BC
        lea.l        rEpisodeMapCells(a6), a3                      ; $00F5C0
        adda.w       rCurrentFloorMapOffset(a6), a3                ; $00F5C4
        lea.l        rPackedCellRenderState(a6), a0                ; $00F5C8
        move.w       rCurrentFloorMapOffset(a6), d0                ; $00F5CC
        lsr.w        #$1, d0                                       ; $00F5D0
        adda.w       d0, a0                                        ; $00F5D2
        move.w       -$720a(a6), d0                                ; $00F5D4
        asr.w        #$8, d0                                       ; $00F5D8
        subq.w       #$5, d0                                       ; $00F5DA
        add.w        rMapWindowOriginX(a6), d0                     ; $00F5DC
        adda.w       d0, a3                                        ; $00F5E0
        move.w       d0, d7                                        ; $00F5E2
        lsr.w        #$1, d0                                       ; $00F5E4
        adda.w       d0, a0                                        ; $00F5E6
        clr.b        -$42a4(a6)                                    ; $00F5E8
        andi.w       #$1, d7                                       ; $00F5EC
        beq.b        loc_00F5F8                                    ; $00F5F0
        move.b       #$1, -$42a4(a6)                               ; $00F5F2

loc_00F5F8:
        move.w       -$7208(a6), d0                                ; $00F5F8
        asr.w        #$8, d0                                       ; $00F5FC
        subq.w       #$5, d0                                       ; $00F5FE
        add.w        rMapWindowOriginY(a6), d0                     ; $00F600
        mulu.w       rCurrentFloorWidth(a6), d0                    ; $00F604
        adda.w       d0, a3                                        ; $00F608
        lsr.w        #$1, d0                                       ; $00F60A
        adda.w       d0, a0                                        ; $00F60C
        move.w       #$9, d7                                       ; $00F60E
        move.w       #$10a, d4                                     ; $00F612
        addq.w       #$5, d5                                       ; $00F616

loc_00F618:
        move.w       #$9, d6                                       ; $00F618
        movea.l      a0, a1                                        ; $00F61C
        movea.l      a3, a4                                        ; $00F61E
        addi.w       #$80, d2                                      ; $00F620
        move.w       d2, d0                                        ; $00F624
        move.w       d0, d1                                        ; $00F626
        andi.w       #$3fff, d1                                    ; $00F628
        ori.w        #$4000, d1                                    ; $00F62C
        swap         d1                                            ; $00F630
        lsr.w        #$8, d0                                       ; $00F632
        lsr.w        #$6, d0                                       ; $00F634
        move.w       d0, d1                                        ; $00F636
        move.l       d1, VDP_CONTROL.l                             ; $00F638
        clr.l        d0                                            ; $00F63E
        move.w       rCurrentFloorWidth(a6), d0                    ; $00F640
        adda.w       d0, a3                                        ; $00F644
        lsr.w        #$1, d0                                       ; $00F646
        adda.w       d0, a0                                        ; $00F648
        move.w       #$ea, d1                                      ; $00F64A

loc_00F64E:
        clr.w        d0                                            ; $00F64E
        clr.w        d3                                            ; $00F650
        move.b       -$42a4(a6), d3                                ; $00F652
        eori.b       #$1, -$42a4(a6)                               ; $00F656
        andi.w       #$1, d3                                       ; $00F65C
        bne.b        loc_00F66C                                    ; $00F660
        move.b       (a1), d0                                      ; $00F662
        lsr.w        #$4, d0                                       ; $00F664
        andi.w       #$f, d0                                       ; $00F666
        bra.b        loc_00F672                                    ; $00F66A

loc_00F66C:
        move.b       (a1)+, d0                                     ; $00F66C
        andi.w       #$f, d0                                       ; $00F66E

loc_00F672:
        clr.w        d3                                            ; $00F672
        move.b       (a4)+, d3                                     ; $00F674
        move.b       (a5, d3.w), d3                                ; $00F676
        move.b       d3, -$719c(a6)                                ; $00F67A
        clr.w        d3                                            ; $00F67E
        move.b       d0, d3                                        ; $00F680
        bsr.w        GetCellCollisionClass                         ; $00F682
        addi.w       #$e2ea, d3                                    ; $00F686
        move.w       #$0, VDP_DATA.l                               ; $00F68A
        addq.w       #$8, d1                                       ; $00F692
        dbra         d6, loc_00F64E                                ; $00F694
        addq.w       #$8, d4                                       ; $00F698
        dbra         d7, loc_00F618                                ; $00F69A
        subq.w       #$5, d5                                       ; $00F69E
        bsr.w        RendererRoutine_00F28C                        ; $00F6A0
        addq.w       #$5, d5                                       ; $00F6A4
        bsr.w        RendererRoutine_00F6B0                        ; $00F6A6
        move.l       a2, -$7fc2(a6)                                ; $00F6AA
        rts                                                        ; $00F6AE
        ifne *-$F6B0
        fail "ROM end moved"
        endif
