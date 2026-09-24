; $00B12C..$00B1D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $90: draw the closed Y-axis face once per trace.
        ifne *-$B12C
        fail "ROM start moved"
        endif

RenderType90ClosedWallAlongY:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00B12C
        bsr.w        RecordVisibleCellRenderState                        ; $00B130
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00B134
        lea.l        rVisibleWallYCache(a6), a3                                ; $00B138
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B13C
        beq.b        loc_00B14E                                    ; $00B140

loc_00B142:
        cmpa.l       (a3)+, a0                                     ; $00B142
        beq.w        loc_00B1A2                                    ; $00B144
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00B148
        bne.b        loc_00B142                                    ; $00B14C

loc_00B14E:
        move.l       a0, (a3)+                                     ; $00B14E
        move.l       a3, rVisibleWallYCacheEnd(a6)                                ; $00B150
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B154
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B158
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B15C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B160
        tst.w        d0                                            ; $00B164
        bmi.b        loc_00B176                                    ; $00B166
        bne.w        loc_00B1A6                                    ; $00B168
        cmpi.w       #$80, rPlayerCellFractionX(a6)                              ; $00B16C
        bcs.w        loc_00B1A6                                    ; $00B172

loc_00B176:
        add.w        rPlayerCellX(a6), d0                          ; $00B176
        lsl.w        #$8, d0                                       ; $00B17A
        add.w        rPlayerCellY(a6), d1                          ; $00B17C
        lsl.w        #$8, d1                                       ; $00B180
        addi.w       #$80, d0                                      ; $00B182
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B186
        addi.w       #$100, d1                                     ; $00B18A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B18E
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B192
        bsr.w        ProjectAndDrawWallFace                        ; $00B19A
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B19E

loc_00B1A2:
        clr.w        d3                                            ; $00B1A2
        rts                                                        ; $00B1A4

loc_00B1A6:
        add.w        rPlayerCellX(a6), d0                          ; $00B1A6
        lsl.w        #$8, d0                                       ; $00B1AA
        add.w        rPlayerCellY(a6), d1                          ; $00B1AC
        lsl.w        #$8, d1                                       ; $00B1B0
        addi.w       #$80, d0                                      ; $00B1B2
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B1B6
        addi.w       #$100, d1                                     ; $00B1BA
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B1BE
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B1C2
        bsr.w        ProjectAndDrawWallFace                        ; $00B1CA
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B1CE
        clr.w        d3                                            ; $00B1D2
        rts                                                        ; $00B1D4
        ifne *-$B1D6
        fail "ROM end moved"
        endif
