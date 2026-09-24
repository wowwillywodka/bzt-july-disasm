; $00B32A..$00B3FF | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $93: first half of the animated Y-axis opening; continues at $B400.
        ifne *-$B32A
        fail "ROM start moved"
        endif

RenderType93OpeningWallAlongY:
        lea.l        rVisibleWallYCache(a6), a3                                ; $00B32A
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B32E
        beq.b        loc_00B340                                    ; $00B332

loc_00B334:
        cmpa.l       (a3)+, a0                                     ; $00B334
        beq.w        loc_00B3E4                                    ; $00B336
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B33A
        bne.b        loc_00B334                                    ; $00B33E

loc_00B340:
        move.l       a0, (a3)+                                     ; $00B340
        move.l       a3, rVisibleWallYCacheEnd(a6)                                ; $00B342
        bsr.w        FindTransientWallOpeningAmount                ; $00B346
        cmpi.w       #$80, d3                                      ; $00B34A
        bne.b        loc_00B354                                    ; $00B34E
        clr.w        d3                                            ; $00B350
        rts                                                        ; $00B352

loc_00B354:
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B354
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B358
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B35C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B360
        tst.w        d0                                            ; $00B364
        bmi.b        loc_00B376                                    ; $00B366
        bne.w        loc_00B3E8                                    ; $00B368
        cmpi.w       #$80, rPlayerCellFractionX(a6)                              ; $00B36C
        bcs.w        loc_00B3E8                                    ; $00B372

loc_00B376:
        add.w        rPlayerCellX(a6), d0                          ; $00B376
        lsl.w        #$8, d0                                       ; $00B37A
        add.w        rPlayerCellY(a6), d1                          ; $00B37C
        lsl.w        #$8, d1                                       ; $00B380
        sub.w        d3, d1                                        ; $00B382
        addi.w       #$80, d0                                      ; $00B384
        move.w       d3, -(a7)                                     ; $00B388
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B38A
        addi.w       #$80, d1                                      ; $00B38E
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B392
        movem.w      d0-d1, -(a7)                                  ; $00B396
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B39A
        bsr.w        ProjectWallFaceOnly                           ; $00B3A2
        asr.w        rWallTextureUStart(a6)                                    ; $00B3A6
        asr.w        rWallTextureUEnd(a6)                                    ; $00B3AA
        bsr.w        DrawWallTextureSpan                           ; $00B3AE
        movem.w      (a7)+, d0-d1                                  ; $00B3B2
        move.w       (a7)+, d3                                     ; $00B3B6
        add.w        d3, d1                                        ; $00B3B8
        add.w        d3, d1                                        ; $00B3BA
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B3BC
        addi.w       #$80, d1                                      ; $00B3C0
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B3C4
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B3C8
        bsr.w        ProjectWallFaceOnly                           ; $00B3D0
        asr.w        rWallTextureUStart(a6)                                    ; $00B3D4
        asr.w        rWallTextureUEnd(a6)                                    ; $00B3D8
        bsr.w        DrawWallTextureSpan                           ; $00B3DC
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B3E0

loc_00B3E4:
        clr.w        d3                                            ; $00B3E4
        rts                                                        ; $00B3E6

loc_00B3E8:
        add.w        rPlayerCellX(a6), d0                          ; $00B3E8
        lsl.w        #$8, d0                                       ; $00B3EC
        add.w        rPlayerCellY(a6), d1                          ; $00B3EE
        lsl.w        #$8, d1                                       ; $00B3F2
        sub.w        d3, d1                                        ; $00B3F4
        addi.w       #$80, d0                                      ; $00B3F6
        move.w       d3, -(a7)                                     ; $00B3FA
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B3FC
        ifne *-$B400
        fail "ROM end moved"
        endif
