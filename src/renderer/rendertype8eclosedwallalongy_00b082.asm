; $00B082..$00B12B | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $8E: draw the closed Y-axis face once per trace.
        ifne *-$B082
        fail "ROM start moved"
        endif

RenderType8EClosedWallAlongY:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00B082
        bsr.w        RecordVisibleCellRenderState                        ; $00B086
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00B08A
        lea.l        rVisibleWallYCache(a6), a3                                ; $00B08E
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B092
        beq.b        loc_00B0A4                                    ; $00B096

loc_00B098:
        cmpa.l       (a3)+, a0                                     ; $00B098
        beq.w        loc_00B0F8                                    ; $00B09A
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B09E
        bne.b        loc_00B098                                    ; $00B0A2

loc_00B0A4:
        move.l       a0, (a3)+                                     ; $00B0A4
        move.l       a3, rVisibleWallYCacheEnd(a6)                                ; $00B0A6
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B0AA
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B0AE
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B0B2
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B0B6
        tst.w        d0                                            ; $00B0BA
        bmi.b        loc_00B0CC                                    ; $00B0BC
        bne.w        loc_00B0FC                                    ; $00B0BE
        cmpi.w       #$80, rPlayerCellFractionX(a6)                              ; $00B0C2
        bcs.w        loc_00B0FC                                    ; $00B0C8

loc_00B0CC:
        add.w        rPlayerCellX(a6), d0                          ; $00B0CC
        lsl.w        #$8, d0                                       ; $00B0D0
        add.w        rPlayerCellY(a6), d1                          ; $00B0D2
        lsl.w        #$8, d1                                       ; $00B0D6
        addi.w       #$80, d0                                      ; $00B0D8
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B0DC
        addi.w       #$100, d1                                     ; $00B0E0
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B0E4
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B0E8
        bsr.w        ProjectAndDrawWallFace                        ; $00B0F0
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B0F4

loc_00B0F8:
        clr.w        d3                                            ; $00B0F8
        rts                                                        ; $00B0FA

loc_00B0FC:
        add.w        rPlayerCellX(a6), d0                          ; $00B0FC
        lsl.w        #$8, d0                                       ; $00B100
        add.w        rPlayerCellY(a6), d1                          ; $00B102
        lsl.w        #$8, d1                                       ; $00B106
        addi.w       #$80, d0                                      ; $00B108
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B10C
        addi.w       #$100, d1                                     ; $00B110
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B114
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B118
        bsr.w        ProjectAndDrawWallFace                        ; $00B120
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B124
        clr.w        d3                                            ; $00B128
        rts                                                        ; $00B12A
        ifne *-$B12C
        fail "ROM end moved"
        endif
