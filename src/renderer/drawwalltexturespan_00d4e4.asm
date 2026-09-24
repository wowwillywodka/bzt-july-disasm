; $00D4E4..$00D899 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Clip projected columns to 0..127 before computing framebuffer/depth pointers;
; interpolate reciprocal-depth scale and U,
; and keep a column only when its scale is >= the stored column depth word.
; Scale <= $50 selects an indexed scaler; larger scales copy the full 80-pixel
; upper/lower viewport column. Tile-pair words index 512-byte wall tiles.
; See docs/WALL_PROJECTION.md.
        ifne *-$D4E4
        fail "ROM start moved"
        endif

DrawWallTextureSpan:
; A2/A3 point to projected B/A endpoint records; U is already clipped.
        move.w       $c(a2), rWallSpanStartInverseDepth(a6)                            ; $00D4E4
        bpl.b        loc_00D4EE                                    ; $00D4EA

loc_00D4EC:
        rts                                                        ; $00D4EC

loc_00D4EE:
        move.w       $c(a3), rWallSpanEndInverseDepth(a6)                            ; $00D4EE
        bmi.b        loc_00D4EC                                    ; $00D4F4
        move.w       $e(a3), rWallSpanEndColumn(a6)                            ; $00D4F6
        bmi.b        loc_00D4EC                                    ; $00D4FC
        move.w       $e(a2), rWallSpanStartColumn(a6)                            ; $00D4FE
        bpl.b        loc_00D50A                                    ; $00D504
        clr.w        rWallSpanStartColumn(a6)                                    ; $00D506

loc_00D50A:
        cmpi.w       #$80, rWallSpanStartColumn(a6)                              ; $00D50A
        bge.b        loc_00D4EC                                    ; $00D510
        cmpi.w       #$80, rWallSpanEndColumn(a6)                              ; $00D512
        blt.b        loc_00D520                                    ; $00D518
        move.w       #$7f, rWallSpanEndColumn(a6)                              ; $00D51A

loc_00D520:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00D520
        beq.b        loc_00D534                                    ; $00D524
        cmpi.w       #$40, rWallSpanEndColumn(a6)                              ; $00D526
        bcs.b        loc_00D534                                    ; $00D52C

loc_00D52E:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00D52E
        bne.b        loc_00D52E                                    ; $00D532

loc_00D534:
        movea.l      rCurrentWallTilePair(a6), a3                  ; $00D534
; Upper tile: signed word * 512. Lower tile follows at descriptor +2. Pixel tile has 16 packed-byte columns of 32 rows (32x32, 4bpp).
        move.w       (a3)+, d4                                     ; $00D538
        ext.l        d4                                            ; $00D53A
        lsl.l        #$8, d4                                       ; $00D53C
        lsl.l        #$1, d4                                       ; $00D53E
        movea.l      rZoneWallTiles(a6), a1                        ; $00D540
        movea.l      a1, a2                                        ; $00D544
        adda.l       d4, a1                                        ; $00D546
        move.w       (a3)+, d4                                     ; $00D548
        ext.l        d4                                            ; $00D54A
        lsl.l        #$8, d4                                       ; $00D54C
        lsl.l        #$1, d4                                       ; $00D54E
        adda.l       d4, a2                                        ; $00D550
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $00D552
        move.w       rWallSpanStartColumn(a6), d0                                ; $00D556
        lea.l        rScreenColumnDepthWords(a6), a4                                  ; $00D55A
        adda.w       d0, a4                                        ; $00D55E
        adda.w       d0, a4                                        ; $00D560
        lea.l        rSceneBackgroundColumns(a6), a5                                  ; $00D562
        btst.l       #$0, d0                                       ; $00D566
        bne.b        loc_00D570                                    ; $00D56A
        adda.w       #$50, a5                                      ; $00D56C

loc_00D570:
        move.w       d0, d1                                        ; $00D570
        andi.w       #$3, d0                                       ; $00D572
        adda.w       d0, a0                                        ; $00D576
        neg.w        d0                                            ; $00D578
        addq.w       #$3, d0                                       ; $00D57A
        andi.w       #$fffc, d1                                    ; $00D57C
        ext.l        d1                                            ; $00D580
        lsl.l        #$4, d1                                       ; $00D582
        adda.l       d1, a0                                        ; $00D584
        lsl.l        #$2, d1                                       ; $00D586
        adda.l       d1, a0                                        ; $00D588
        move.w       rWallSpanEndColumn(a6), d5                                ; $00D58A
        sub.w        rWallSpanStartColumn(a6), d5                                ; $00D58E
        addq.w       #$1, d5                                       ; $00D592
        beq.w        loc_00D756                                    ; $00D594
        bmi.w        loc_00D756                                    ; $00D598
; Store the clipped projected end even if later per-column depth tests reject pixels.
        move.w       rWallSpanEndColumn(a6), rWallSpanEndColumnForRaySkip(a6)                        ; $00D59C
        move.w       rWallSpanEndInverseDepth(a6), d1                                ; $00D5A2
        ext.l        d1                                            ; $00D5A6
        lsl.l        #$8, d1                                       ; $00D5A8
        move.w       rWallSpanStartInverseDepth(a6), d2                                ; $00D5AA
        ext.l        d2                                            ; $00D5AE
        lsl.l        #$8, d2                                       ; $00D5B0
        sub.l        d2, d1                                        ; $00D5B2
        divs.w       d5, d1                                        ; $00D5B4
        ext.l        d1                                            ; $00D5B6
        move.w       rWallTextureUEnd(a6), d6                                ; $00D5B8
        sub.w        rWallTextureUStart(a6), d6                                ; $00D5BC
        lsl.w        #$6, d6                                       ; $00D5C0
        ext.l        d6                                            ; $00D5C2
        divs.w       d5, d6                                        ; $00D5C4
        clr.w        rWallTextureColumnByteOffset(a6)                                    ; $00D5C6
        move.w       rWallTextureUStart(a6), d4                                ; $00D5CA
        move.w       d4, rWallSlopeTextureUStart(a6)                                ; $00D5CE
        lsl.w        #$6, d4                                       ; $00D5D2
        add.w        d6, d4                                        ; $00D5D4
        move.w       d4, rWallTextureUStart(a6)                                ; $00D5D6
        cmpi.w       #$ff, d4                                      ; $00D5DA
        bls.b        loc_00D634                                    ; $00D5DE
        clr.b        rWallTextureUStart(a6)                                    ; $00D5E0
        asr.w        #$3, d4                                       ; $00D5E4
        andi.w       #$ffe0, d4                                    ; $00D5E6
        adda.w       d4, a1                                        ; $00D5EA
        adda.w       d4, a2                                        ; $00D5EC
        asr.w        #$1, d4                                       ; $00D5EE
        add.w        d4, rWallTextureColumnByteOffset(a6)                                ; $00D5F0
        tst.b        rWallTextureColumnByteOffset(a6)                                    ; $00D5F4
        beq.w        loc_00D634                                    ; $00D5F8
        clr.l        d4                                            ; $00D5FC
        move.b       rWallTextureColumnByteOffset(a6), d4                                ; $00D5FE
        clr.b        rWallTextureColumnByteOffset(a6)                                    ; $00D602
        lsl.b        #$2, d4                                       ; $00D606
; Advance to next upper/lower pair (4 bytes) when U crosses a 32-pixel tile column; whole definition is four such pairs.
        add.l        d4, rCurrentWallTilePair(a6)                  ; $00D608
        movea.l      rCurrentWallTilePair(a6), a3                  ; $00D60C
        move.w       (a3)+, d4                                     ; $00D610
        ext.l        d4                                            ; $00D612
        lsl.l        #$8, d4                                       ; $00D614
        lsl.l        #$1, d4                                       ; $00D616
        movea.l      rZoneWallTiles(a6), a1                        ; $00D618
        movea.l      a1, a2                                        ; $00D61C
        adda.l       d4, a1                                        ; $00D61E
        move.w       (a3)+, d4                                     ; $00D620
        ext.l        d4                                            ; $00D622
        lsl.l        #$8, d4                                       ; $00D624
        lsl.l        #$1, d4                                       ; $00D626
        adda.l       d4, a2                                        ; $00D628
        move.w       rWallTextureColumnByteOffset(a6), d4                                ; $00D62A
        lsl.w        #$1, d4                                       ; $00D62E
        adda.w       d4, a1                                        ; $00D630
        adda.w       d4, a2                                        ; $00D632

loc_00D634:
        tst.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00D634
        bne.w        DrawSlopedWallTextureSpan                                    ; $00D638
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $00D63C
        bne.w        loc_00D9AC                                    ; $00D640
        tst.w        rNightVisionInventorySlotIndex(a6)                                    ; $00D644
        bpl.b        loc_00D652                                    ; $00D648
        tst.w        rFlashlightInventorySlotIndex(a6)                                    ; $00D64A
        bpl.w        loc_00D758                                    ; $00D64E

loc_00D652:
; Compare the interpolated scale against the previous value for this column.
; Equal scales draw again; only strictly smaller scales are occluded.
        suba.w       #$a0, a5                                      ; $00D652
        cmpa.l       #ramSceneBackgroundColumns, a5                                  ; $00D656
        beq.b        loc_00D662                                    ; $00D65C
        adda.w       #$a0, a5                                      ; $00D65E

loc_00D662:
        movem.l      d0/d5, -(a7)                                  ; $00D662
        move.l       d2, d0                                        ; $00D666
        asr.l        #$8, d0                                       ; $00D668
        cmp.w        (a4), d0                                      ; $00D66A
        bcs.w        loc_00D694                                    ; $00D66C
        move.w       d0, (a4)                                      ; $00D670
        cmpi.w       #$50, d0                                      ; $00D672
        bhi.b        loc_00D69E                                    ; $00D676
        movea.l      rWallColumnScalerTable(a6), a3                ; $00D678
        bclr.l       #$0, d0                                       ; $00D67C
        lsl.w        #$1, d0                                       ; $00D680
        adda.w       d0, a3                                        ; $00D682
; $148 past either scaler table is its 41-entry copy-tail table. Two pushes
; give the scaler the same top/bottom background suffix at 4/8(SP).
        move.l       $148(a3), -(a7)                               ; $00D684
        move.l       $148(a3), -(a7)                               ; $00D688
        movea.l      (a3), a3                                      ; $00D68C
; Indexed scaler call; two copy-tail continuations are pushed immediately before JSR.
        jsr          (a3)                                          ; $00D68E
        addq.w       #$8, a7                                       ; $00D690
        bra.b        loc_00D6DA                                    ; $00D692

loc_00D694:
        lea.l        $50(a5), a5                                   ; $00D694
        adda.w       #$140, a0                                     ; $00D698
        bra.b        loc_00D6DA                                    ; $00D69C

loc_00D69E:
        movem.l      d6/a4-a5, -(a7)                               ; $00D69E
        lea.l        $a0(a0), a0                                   ; $00D6A2
        movea.l      a0, a3                                        ; $00D6A6
        lea.l        $20(a1), a4                                   ; $00D6A8
        move.w       #$40, d4                                      ; $00D6AC
        move.w       d0, d3                                        ; $00D6B0
        move.w       #$27, d7                                      ; $00D6B2
; Upper half reads backward from column end while drawing upward; lower half reads forward while drawing downward. This does not vertically flip the stored texture.
        move.b       -(a4), d5                                     ; $00D6B6
        movea.l      a2, a5                                        ; $00D6B8
        move.b       (a5)+, d6                                     ; $00D6BA

loc_00D6BC:
        subq.w       #$4, a3                                       ; $00D6BC
        move.b       d5, (a3)                                      ; $00D6BE
        move.b       d6, (a0)                                      ; $00D6C0
        addq.w       #$4, a0                                       ; $00D6C2
        sub.w        d4, d3                                        ; $00D6C4
        bpl.b        loc_00D6CE                                    ; $00D6C6
        move.b       -(a4), d5                                     ; $00D6C8
        move.b       (a5)+, d6                                     ; $00D6CA
        add.w        d0, d3                                        ; $00D6CC

loc_00D6CE:
        dbra         d7, loc_00D6BC                                ; $00D6CE
        movem.l      (a7)+, d6/a4-a5                               ; $00D6D2
        lea.l        $50(a5), a5                                   ; $00D6D6

loc_00D6DA:
        movem.l      (a7)+, d0/d5                                  ; $00D6DA
        add.l        d1, d2                                        ; $00D6DE
        addq.w       #$2, a4                                       ; $00D6E0
        add.w        d6, rWallTextureUStart(a6)                                ; $00D6E2
        tst.b        rWallTextureUStart(a6)                                    ; $00D6E6
        beq.b        loc_00D740                                    ; $00D6EA
        move.w       rWallTextureUStart(a6), d4                                ; $00D6EC
        clr.b        rWallTextureUStart(a6)                                    ; $00D6F0
        clr.b        d4                                            ; $00D6F4
        asr.w        #$3, d4                                       ; $00D6F6
        adda.w       d4, a1                                        ; $00D6F8
        adda.w       d4, a2                                        ; $00D6FA
        asr.w        #$1, d4                                       ; $00D6FC
        add.w        d4, rWallTextureColumnByteOffset(a6)                                ; $00D6FE
        tst.b        rWallTextureColumnByteOffset(a6)                                    ; $00D702
        beq.b        loc_00D740                                    ; $00D706
        clr.l        d4                                            ; $00D708
        move.b       rWallTextureColumnByteOffset(a6), d4                                ; $00D70A
        clr.b        rWallTextureColumnByteOffset(a6)                                    ; $00D70E
        lsl.b        #$2, d4                                       ; $00D712
        add.l        d4, rCurrentWallTilePair(a6)                  ; $00D714
        movea.l      rCurrentWallTilePair(a6), a3                  ; $00D718
        move.w       (a3)+, d4                                     ; $00D71C
        ext.l        d4                                            ; $00D71E
        lsl.l        #$8, d4                                       ; $00D720
        lsl.l        #$1, d4                                       ; $00D722
        movea.l      rZoneWallTiles(a6), a1                        ; $00D724
        movea.l      a1, a2                                        ; $00D728
        adda.l       d4, a1                                        ; $00D72A
        move.w       (a3)+, d4                                     ; $00D72C
        ext.l        d4                                            ; $00D72E
        lsl.l        #$8, d4                                       ; $00D730
        lsl.l        #$1, d4                                       ; $00D732
        adda.l       d4, a2                                        ; $00D734
        move.w       rWallTextureColumnByteOffset(a6), d4                                ; $00D736
        lsl.w        #$1, d4                                       ; $00D73A
        adda.w       d4, a1                                        ; $00D73C
        adda.w       d4, a2                                        ; $00D73E

loc_00D740:
        suba.w       #$13f, a0                                     ; $00D740
        subq.w       #$1, d0                                       ; $00D744
        bpl.b        loc_00D750                                    ; $00D746
        move.w       #$3, d0                                       ; $00D748
        adda.w       #$13c, a0                                     ; $00D74C

loc_00D750:
        subq.w       #$1, d5                                       ; $00D750
        bne.w        loc_00D652                                    ; $00D752

loc_00D756:
        rts                                                        ; $00D756

loc_00D758:
        move.l       rWallColumnScalerTable(a6), rRenderPointerScratch(a6) ; $00D758
        cmpa.l       rFlashlightBandStartPointer(a6), a4                                ; $00D75E
        bls.b        loc_00D772                                    ; $00D762
        cmpa.l       rFlashlightBandEndPointer(a6), a4                                ; $00D764
        bhi.b        loc_00D772                                    ; $00D768
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $00D76A

loc_00D772:
        cmpa.l       rFlashlightBandStartPointer(a6), a4                                ; $00D772
        bne.b        loc_00D782                                    ; $00D776
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $00D778
        bra.b        loc_00D78E                                    ; $00D780

loc_00D782:
        cmpa.l       rFlashlightBandEndPointer(a6), a4                                ; $00D782
        bne.b        loc_00D78E                                    ; $00D786
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00D788

loc_00D78E:
        suba.w       #$a0, a5                                      ; $00D78E
        cmpa.l       #ramSceneBackgroundColumns, a5                                  ; $00D792
        beq.b        loc_00D79E                                    ; $00D798
        adda.w       #$a0, a5                                      ; $00D79A

loc_00D79E:
        movem.l      d0/d5, -(a7)                                  ; $00D79E
        move.l       d2, d0                                        ; $00D7A2
        asr.l        #$8, d0                                       ; $00D7A4
        cmp.w        (a4), d0                                      ; $00D7A6
        bcs.w        loc_00D7D0                                    ; $00D7A8
        move.w       d0, (a4)                                      ; $00D7AC
        cmpi.w       #$50, d0                                      ; $00D7AE
        bhi.b        loc_00D7DA                                    ; $00D7B2
        movea.l      rWallColumnScalerTable(a6), a3                ; $00D7B4
        bclr.l       #$0, d0                                       ; $00D7B8
        lsl.w        #$1, d0                                       ; $00D7BC
        adda.w       d0, a3                                        ; $00D7BE
; Flash Light uses the same suffix layout and call-stack convention.
        move.l       $148(a3), -(a7)                               ; $00D7C0
        move.l       $148(a3), -(a7)                               ; $00D7C4
        movea.l      (a3), a3                                      ; $00D7C8
; Same stack contract as $D68E; current scaler table comes from RAM $FF0ED4.
        jsr          (a3)                                          ; $00D7CA
        addq.w       #$8, a7                                       ; $00D7CC
        bra.b        loc_00D816                                    ; $00D7CE

loc_00D7D0:
        lea.l        $50(a5), a5                                   ; $00D7D0
        adda.w       #$140, a0                                     ; $00D7D4
        bra.b        loc_00D816                                    ; $00D7D8

loc_00D7DA:
        movem.l      d6/a4-a5, -(a7)                               ; $00D7DA
        lea.l        $a0(a0), a0                                   ; $00D7DE
        movea.l      a0, a3                                        ; $00D7E2
        lea.l        $20(a1), a4                                   ; $00D7E4
        move.w       #$40, d4                                      ; $00D7E8
        move.w       d0, d3                                        ; $00D7EC
        move.w       #$27, d7                                      ; $00D7EE
        move.b       -(a4), d5                                     ; $00D7F2
        movea.l      a2, a5                                        ; $00D7F4
        move.b       (a5)+, d6                                     ; $00D7F6

loc_00D7F8:
        subq.w       #$4, a3                                       ; $00D7F8
        move.b       d5, (a3)                                      ; $00D7FA
        move.b       d6, (a0)                                      ; $00D7FC
        addq.w       #$4, a0                                       ; $00D7FE
        sub.w        d4, d3                                        ; $00D800
        bpl.b        loc_00D80A                                    ; $00D802
        move.b       -(a4), d5                                     ; $00D804
        move.b       (a5)+, d6                                     ; $00D806
        add.w        d0, d3                                        ; $00D808

loc_00D80A:
        dbra         d7, loc_00D7F8                                ; $00D80A
        movem.l      (a7)+, d6/a4-a5                               ; $00D80E
        lea.l        $50(a5), a5                                   ; $00D812

loc_00D816:
        movem.l      (a7)+, d0/d5                                  ; $00D816
        add.l        d1, d2                                        ; $00D81A
        addq.w       #$2, a4                                       ; $00D81C
        add.w        d6, rWallTextureUStart(a6)                                ; $00D81E
        tst.b        rWallTextureUStart(a6)                                    ; $00D822
        beq.b        loc_00D87C                                    ; $00D826
        move.w       rWallTextureUStart(a6), d4                                ; $00D828
        clr.b        rWallTextureUStart(a6)                                    ; $00D82C
        clr.b        d4                                            ; $00D830
        asr.w        #$3, d4                                       ; $00D832
        adda.w       d4, a1                                        ; $00D834
        adda.w       d4, a2                                        ; $00D836
        asr.w        #$1, d4                                       ; $00D838
        add.w        d4, rWallTextureColumnByteOffset(a6)                                ; $00D83A
        tst.b        rWallTextureColumnByteOffset(a6)                                    ; $00D83E
        beq.b        loc_00D87C                                    ; $00D842
        clr.l        d4                                            ; $00D844
        move.b       rWallTextureColumnByteOffset(a6), d4                                ; $00D846
        clr.b        rWallTextureColumnByteOffset(a6)                                    ; $00D84A
        lsl.b        #$2, d4                                       ; $00D84E
        add.l        d4, rCurrentWallTilePair(a6)                  ; $00D850
        movea.l      rCurrentWallTilePair(a6), a3                  ; $00D854
        move.w       (a3)+, d4                                     ; $00D858
        ext.l        d4                                            ; $00D85A
        lsl.l        #$8, d4                                       ; $00D85C
        lsl.l        #$1, d4                                       ; $00D85E
        movea.l      rZoneWallTiles(a6), a1                        ; $00D860
        movea.l      a1, a2                                        ; $00D864
        adda.l       d4, a1                                        ; $00D866
        move.w       (a3)+, d4                                     ; $00D868
        ext.l        d4                                            ; $00D86A
        lsl.l        #$8, d4                                       ; $00D86C
        lsl.l        #$1, d4                                       ; $00D86E
        adda.l       d4, a2                                        ; $00D870
        move.w       rWallTextureColumnByteOffset(a6), d4                                ; $00D872
        lsl.w        #$1, d4                                       ; $00D876
        adda.w       d4, a1                                        ; $00D878
        adda.w       d4, a2                                        ; $00D87A

loc_00D87C:
        suba.w       #$13f, a0                                     ; $00D87C
        subq.w       #$1, d0                                       ; $00D880
        bpl.b        loc_00D88C                                    ; $00D882
        move.w       #$3, d0                                       ; $00D884
        adda.w       #$13c, a0                                     ; $00D888

loc_00D88C:
        subq.w       #$1, d5                                       ; $00D88C
        bne.w        loc_00D772                                    ; $00D88E
        move.l       rRenderPointerScratch(a6), rWallColumnScalerTable(a6) ; $00D892
        rts                                                        ; $00D898
        ifne *-$D89A
        fail "ROM end moved"
        endif
