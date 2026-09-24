; $00B45A..$00B589 | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $94: render two Y-axis wall panels around the animated opening.
        ifne *-$B45A
        fail "ROM start moved"
        endif

RenderType94OpeningWallAlongY:
        lea.l        rVisibleWallYCache(a6), a3                                ; $00B45A
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B45E
        beq.b        loc_00B470                                    ; $00B462

loc_00B464:
        cmpa.l       (a3)+, a0                                     ; $00B464
        beq.w        loc_00B514                                    ; $00B466
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B46A
        bne.b        loc_00B464                                    ; $00B46E

loc_00B470:
        move.l       a0, (a3)+                                     ; $00B470
        move.l       a3, rVisibleWallYCacheEnd(a6)                                ; $00B472
        bsr.w        FindTransientWallOpeningAmount                ; $00B476
        cmpi.w       #$80, d3                                      ; $00B47A
        bne.b        loc_00B484                                    ; $00B47E
        clr.w        d3                                            ; $00B480
        rts                                                        ; $00B482

loc_00B484:
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B484
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B488
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B48C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B490
        tst.w        d0                                            ; $00B494
        bmi.b        loc_00B4A6                                    ; $00B496
        bne.w        loc_00B518                                    ; $00B498
        cmpi.w       #$80, rPlayerCellFractionX(a6)                              ; $00B49C
        bcs.w        loc_00B518                                    ; $00B4A2

loc_00B4A6:
        add.w        rPlayerCellX(a6), d0                          ; $00B4A6
        lsl.w        #$8, d0                                       ; $00B4AA
        add.w        rPlayerCellY(a6), d1                          ; $00B4AC
        lsl.w        #$8, d1                                       ; $00B4B0
        sub.w        d3, d1                                        ; $00B4B2
        addi.w       #$80, d0                                      ; $00B4B4
        move.w       d3, -(a7)                                     ; $00B4B8
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B4BA
        addi.w       #$80, d1                                      ; $00B4BE
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B4C2
        movem.w      d0-d1, -(a7)                                  ; $00B4C6
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B4CA
        bsr.w        ProjectWallFaceOnly                           ; $00B4D2
        asr.w        rWallTextureUStart(a6)                                    ; $00B4D6
        asr.w        rWallTextureUEnd(a6)                                    ; $00B4DA
        bsr.w        DrawWallTextureSpan                           ; $00B4DE
        movem.w      (a7)+, d0-d1                                  ; $00B4E2
        move.w       (a7)+, d3                                     ; $00B4E6
        add.w        d3, d1                                        ; $00B4E8
        add.w        d3, d1                                        ; $00B4EA
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B4EC
        addi.w       #$80, d1                                      ; $00B4F0
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B4F4
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B4F8
        bsr.w        ProjectWallFaceOnly                           ; $00B500
        asr.w        rWallTextureUStart(a6)                                    ; $00B504
        asr.w        rWallTextureUEnd(a6)                                    ; $00B508
        bsr.w        DrawWallTextureSpan                           ; $00B50C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B510

loc_00B514:
        clr.w        d3                                            ; $00B514
        rts                                                        ; $00B516

loc_00B518:
        add.w        rPlayerCellX(a6), d0                          ; $00B518
        lsl.w        #$8, d0                                       ; $00B51C
        add.w        rPlayerCellY(a6), d1                          ; $00B51E
        lsl.w        #$8, d1                                       ; $00B522
        sub.w        d3, d1                                        ; $00B524
        addi.w       #$80, d0                                      ; $00B526
        move.w       d3, -(a7)                                     ; $00B52A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B52C
        addi.w       #$80, d1                                      ; $00B530
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B534
        movem.w      d0-d1, -(a7)                                  ; $00B538
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B53C
        bsr.w        ProjectWallFaceOnly                           ; $00B544
        asr.w        rWallTextureUStart(a6)                                    ; $00B548
        asr.w        rWallTextureUEnd(a6)                                    ; $00B54C
        bsr.w        DrawWallTextureSpan                           ; $00B550
        movem.w      (a7)+, d0-d1                                  ; $00B554
        move.w       (a7)+, d3                                     ; $00B558
        add.w        d3, d1                                        ; $00B55A
        add.w        d3, d1                                        ; $00B55C
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B55E
        addi.w       #$80, d1                                      ; $00B562
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B566
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B56A
        bsr.w        ProjectWallFaceOnly                           ; $00B572
        asr.w        rWallTextureUStart(a6)                                    ; $00B576
        asr.w        rWallTextureUEnd(a6)                                    ; $00B57A
        bsr.w        DrawWallTextureSpan                           ; $00B57E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B582
        clr.w        d3                                            ; $00B586
        rts                                                        ; $00B588
        ifne *-$B58A
        fail "ROM end moved"
        endif
