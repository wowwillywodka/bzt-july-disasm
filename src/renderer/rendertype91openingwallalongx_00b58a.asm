; $00B58A..$00B6B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $91: render two X-axis wall panels around the animated opening.
        ifne *-$B58A
        fail "ROM start moved"
        endif

RenderType91OpeningWallAlongX:
        lea.l        rVisibleWallXCache(a6), a3                                ; $00B58A
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B58E
        beq.b        loc_00B5A0                                    ; $00B592

loc_00B594:
        cmpa.l       (a3)+, a0                                     ; $00B594
        beq.w        loc_00B644                                    ; $00B596
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B59A
        bne.b        loc_00B594                                    ; $00B59E

loc_00B5A0:
        move.l       a0, (a3)+                                     ; $00B5A0
        move.l       a3, rVisibleWallXCacheEnd(a6)                                ; $00B5A2
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B5A6
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B5AA
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B5AE
        bsr.w        FindTransientWallOpeningAmount                ; $00B5B2
        cmpi.w       #$80, d3                                      ; $00B5B6
        bne.b        DrawType91OpeningWallFaces                        ; $00B5BA
        clr.w        d3                                            ; $00B5BC
        rts                                                        ; $00B5BE
DrawType91OpeningWallFaces:
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B5C0
        tst.w        d1                                            ; $00B5C4
        bmi.b        loc_00B5D6                                    ; $00B5C6
        bne.w        loc_00B648                                    ; $00B5C8
        cmpi.w       #$80, rPlayerCellFractionY(a6)                              ; $00B5CC
        bcs.w        loc_00B648                                    ; $00B5D2

loc_00B5D6:
        add.w        rPlayerCellX(a6), d0                          ; $00B5D6
        lsl.w        #$8, d0                                       ; $00B5DA
        add.w        rPlayerCellY(a6), d1                          ; $00B5DC
        lsl.w        #$8, d1                                       ; $00B5E0
        sub.w        d3, d0                                        ; $00B5E2
        addi.w       #$80, d1                                      ; $00B5E4
        move.w       d3, -(a7)                                     ; $00B5E8
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B5EA
        addi.w       #$80, d0                                      ; $00B5EE
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B5F2
        movem.w      d0-d1, -(a7)                                  ; $00B5F6
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B5FA
        bsr.w        ProjectWallFaceOnly                           ; $00B602
        asr.w        rWallTextureUStart(a6)                                    ; $00B606
        asr.w        rWallTextureUEnd(a6)                                    ; $00B60A
        bsr.w        DrawWallTextureSpan                           ; $00B60E
        movem.w      (a7)+, d0-d1                                  ; $00B612
        move.w       (a7)+, d3                                     ; $00B616
        add.w        d3, d0                                        ; $00B618
        add.w        d3, d0                                        ; $00B61A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B61C
        addi.w       #$80, d0                                      ; $00B620
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B624
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B628
        bsr.w        ProjectWallFaceOnly                           ; $00B630
        asr.w        rWallTextureUStart(a6)                                    ; $00B634
        asr.w        rWallTextureUEnd(a6)                                    ; $00B638
        bsr.w        DrawWallTextureSpan                           ; $00B63C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B640

loc_00B644:
        clr.w        d3                                            ; $00B644
        rts                                                        ; $00B646

loc_00B648:
        add.w        rPlayerCellX(a6), d0                          ; $00B648
        lsl.w        #$8, d0                                       ; $00B64C
        add.w        rPlayerCellY(a6), d1                          ; $00B64E
        lsl.w        #$8, d1                                       ; $00B652
        sub.w        d3, d0                                        ; $00B654
        addi.w       #$80, d1                                      ; $00B656
        move.w       d3, -(a7)                                     ; $00B65A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B65C
        addi.w       #$80, d0                                      ; $00B660
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B664
        movem.w      d0-d1, -(a7)                                  ; $00B668
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B66C
        bsr.w        ProjectWallFaceOnly                           ; $00B674
        asr.w        rWallTextureUStart(a6)                                    ; $00B678
        asr.w        rWallTextureUEnd(a6)                                    ; $00B67C
        bsr.w        DrawWallTextureSpan                           ; $00B680
        movem.w      (a7)+, d0-d1                                  ; $00B684
        move.w       (a7)+, d3                                     ; $00B688
        add.w        d3, d0                                        ; $00B68A
        add.w        d3, d0                                        ; $00B68C
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B68E
        addi.w       #$80, d0                                      ; $00B692
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B696
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B69A
        bsr.w        ProjectWallFaceOnly                           ; $00B6A2
        asr.w        rWallTextureUStart(a6)                                    ; $00B6A6
        asr.w        rWallTextureUEnd(a6)                                    ; $00B6AA
        bsr.w        DrawWallTextureSpan                           ; $00B6AE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B6B2
        clr.w        d3                                            ; $00B6B6
        rts                                                        ; $00B6B8
        ifne *-$B6BA
        fail "ROM end moved"
        endif
