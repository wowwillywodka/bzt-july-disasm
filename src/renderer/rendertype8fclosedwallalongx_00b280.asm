; $00B280..$00B329 | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $8F: draw the closed X-axis face once per trace.
        ifne *-$B280
        fail "ROM start moved"
        endif

RenderType8FClosedWallAlongX:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00B280
        bsr.w        RecordVisibleCellRenderState                        ; $00B284
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00B288
        lea.l        rVisibleWallXCache(a6), a3                                ; $00B28C
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B290
        beq.b        loc_00B2A2                                    ; $00B294

loc_00B296:
        cmpa.l       (a3)+, a0                                     ; $00B296
        beq.w        loc_00B2F6                                    ; $00B298
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B29C
        bne.b        loc_00B296                                    ; $00B2A0

loc_00B2A2:
        move.l       a0, (a3)+                                     ; $00B2A2
        move.l       a3, rVisibleWallXCacheEnd(a6)                                ; $00B2A4
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B2A8
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B2AC
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B2B0
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B2B4
        tst.w        d1                                            ; $00B2B8
        bmi.b        loc_00B2CA                                    ; $00B2BA
        bne.w        loc_00B2FA                                    ; $00B2BC
        cmpi.w       #$80, rPlayerCellFractionY(a6)                              ; $00B2C0
        bcs.w        loc_00B2FA                                    ; $00B2C6

loc_00B2CA:
        add.w        rPlayerCellX(a6), d0                          ; $00B2CA
        lsl.w        #$8, d0                                       ; $00B2CE
        add.w        rPlayerCellY(a6), d1                          ; $00B2D0
        lsl.w        #$8, d1                                       ; $00B2D4
        addi.w       #$80, d1                                      ; $00B2D6
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B2DA
        addi.w       #$100, d0                                     ; $00B2DE
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B2E2
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B2E6
        bsr.w        ProjectAndDrawWallFace                        ; $00B2EE
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B2F2

loc_00B2F6:
        clr.w        d3                                            ; $00B2F6
        rts                                                        ; $00B2F8

loc_00B2FA:
        add.w        rPlayerCellX(a6), d0                          ; $00B2FA
        lsl.w        #$8, d0                                       ; $00B2FE
        add.w        rPlayerCellY(a6), d1                          ; $00B300
        lsl.w        #$8, d1                                       ; $00B304
        addi.w       #$80, d1                                      ; $00B306
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B30A
        addi.w       #$100, d0                                     ; $00B30E
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B312
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B316
        bsr.w        ProjectAndDrawWallFace                        ; $00B31E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B322
        clr.w        d3                                            ; $00B326
        rts                                                        ; $00B328
        ifne *-$B32A
        fail "ROM end moved"
        endif
