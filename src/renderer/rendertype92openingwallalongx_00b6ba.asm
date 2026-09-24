; $00B6BA..$00B7E9 | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $92: mirrored X-axis opening, sharing the X render cache.
        ifne *-$B6BA
        fail "ROM start moved"
        endif

RenderType92OpeningWallAlongX:
        lea.l        rVisibleWallXCache(a6), a3                                ; $00B6BA
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B6BE
        beq.b        loc_00B6D0                                    ; $00B6C2

loc_00B6C4:
        cmpa.l       (a3)+, a0                                     ; $00B6C4
        beq.w        loc_00B774                                    ; $00B6C6
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B6CA
        bne.b        loc_00B6C4                                    ; $00B6CE

loc_00B6D0:
        move.l       a0, (a3)+                                     ; $00B6D0
        move.l       a3, rVisibleWallXCacheEnd(a6)                                ; $00B6D2
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B6D6
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B6DA
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B6DE
        bsr.w        FindTransientWallOpeningAmount                ; $00B6E2
        cmpi.w       #$80, d3                                      ; $00B6E6
        bne.b        DrawType92OpeningWallFaces                        ; $00B6EA
        clr.w        d3                                            ; $00B6EC
        rts                                                        ; $00B6EE
DrawType92OpeningWallFaces:
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B6F0
        tst.w        d1                                            ; $00B6F4
        bmi.b        loc_00B706                                    ; $00B6F6
        bne.w        loc_00B778                                    ; $00B6F8
        cmpi.w       #$80, rPlayerCellFractionY(a6)                              ; $00B6FC
        bcs.w        loc_00B778                                    ; $00B702

loc_00B706:
        add.w        rPlayerCellX(a6), d0                          ; $00B706
        lsl.w        #$8, d0                                       ; $00B70A
        add.w        rPlayerCellY(a6), d1                          ; $00B70C
        lsl.w        #$8, d1                                       ; $00B710
        sub.w        d3, d0                                        ; $00B712
        addi.w       #$80, d1                                      ; $00B714
        move.w       d3, -(a7)                                     ; $00B718
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B71A
        addi.w       #$80, d0                                      ; $00B71E
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B722
        movem.w      d0-d1, -(a7)                                  ; $00B726
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B72A
        bsr.w        ProjectWallFaceOnly                           ; $00B732
        asr.w        rWallTextureUStart(a6)                                    ; $00B736
        asr.w        rWallTextureUEnd(a6)                                    ; $00B73A
        bsr.w        DrawWallTextureSpan                           ; $00B73E
        movem.w      (a7)+, d0-d1                                  ; $00B742
        move.w       (a7)+, d3                                     ; $00B746
        add.w        d3, d0                                        ; $00B748
        add.w        d3, d0                                        ; $00B74A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B74C
        addi.w       #$80, d0                                      ; $00B750
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B754
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B758
        bsr.w        ProjectWallFaceOnly                           ; $00B760
        asr.w        rWallTextureUStart(a6)                                    ; $00B764
        asr.w        rWallTextureUEnd(a6)                                    ; $00B768
        bsr.w        DrawWallTextureSpan                           ; $00B76C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B770

loc_00B774:
        clr.w        d3                                            ; $00B774
        rts                                                        ; $00B776

loc_00B778:
        add.w        rPlayerCellX(a6), d0                          ; $00B778
        lsl.w        #$8, d0                                       ; $00B77C
        add.w        rPlayerCellY(a6), d1                          ; $00B77E
        lsl.w        #$8, d1                                       ; $00B782
        sub.w        d3, d0                                        ; $00B784
        addi.w       #$80, d1                                      ; $00B786
        move.w       d3, -(a7)                                     ; $00B78A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B78C
        addi.w       #$80, d0                                      ; $00B790
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B794
        movem.w      d0-d1, -(a7)                                  ; $00B798
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B79C
        bsr.w        ProjectWallFaceOnly                           ; $00B7A4
        asr.w        rWallTextureUStart(a6)                                    ; $00B7A8
        asr.w        rWallTextureUEnd(a6)                                    ; $00B7AC
        bsr.w        DrawWallTextureSpan                           ; $00B7B0
        movem.w      (a7)+, d0-d1                                  ; $00B7B4
        move.w       (a7)+, d3                                     ; $00B7B8
        add.w        d3, d0                                        ; $00B7BA
        add.w        d3, d0                                        ; $00B7BC
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B7BE
        addi.w       #$80, d0                                      ; $00B7C2
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B7C6
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B7CA
        bsr.w        ProjectWallFaceOnly                           ; $00B7D2
        asr.w        rWallTextureUStart(a6)                                    ; $00B7D6
        asr.w        rWallTextureUEnd(a6)                                    ; $00B7DA
        bsr.w        DrawWallTextureSpan                           ; $00B7DE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B7E2
        clr.w        d3                                            ; $00B7E6
        rts                                                        ; $00B7E8
        ifne *-$B7EA
        fail "ROM end moved"
        endif
