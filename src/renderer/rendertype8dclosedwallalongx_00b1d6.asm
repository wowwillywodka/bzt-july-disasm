; $00B1D6..$00B27F | m68k
; Maintained assembly input; no extraction occurs during build.
; Visible cell type $8D: draw the closed X-axis face once per trace.
        ifne *-$B1D6
        fail "ROM start moved"
        endif

RenderType8DClosedWallAlongX:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00B1D6
        bsr.w        RecordVisibleCellRenderState                        ; $00B1DA
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00B1DE
        lea.l        rVisibleWallXCache(a6), a3                                ; $00B1E2
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B1E6
        beq.b        loc_00B1F8                                    ; $00B1EA

loc_00B1EC:
        cmpa.l       (a3)+, a0                                     ; $00B1EC
        beq.w        loc_00B24C                                    ; $00B1EE
        cmpa.l       rVisibleWallXCacheEnd(a6), a3                                ; $00B1F2
        bne.b        loc_00B1EC                                    ; $00B1F6

loc_00B1F8:
        move.l       a0, (a3)+                                     ; $00B1F8
        move.l       a3, rVisibleWallXCacheEnd(a6)                                ; $00B1FA
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $00B1FE
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $00B202
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $00B206
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B20A
        tst.w        d1                                            ; $00B20E
        bmi.b        loc_00B220                                    ; $00B210
        bne.w        loc_00B250                                    ; $00B212
        cmpi.w       #$80, rPlayerCellFractionY(a6)                              ; $00B216
        bcs.w        loc_00B250                                    ; $00B21C

loc_00B220:
        add.w        rPlayerCellX(a6), d0                          ; $00B220
        lsl.w        #$8, d0                                       ; $00B224
        add.w        rPlayerCellY(a6), d1                          ; $00B226
        lsl.w        #$8, d1                                       ; $00B22A
        addi.w       #$80, d1                                      ; $00B22C
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B230
        addi.w       #$100, d0                                     ; $00B234
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B238
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B23C
        bsr.w        ProjectAndDrawWallFace                        ; $00B244
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B248

loc_00B24C:
        clr.w        d3                                            ; $00B24C
        rts                                                        ; $00B24E

loc_00B250:
        add.w        rPlayerCellX(a6), d0                          ; $00B250
        lsl.w        #$8, d0                                       ; $00B254
        add.w        rPlayerCellY(a6), d1                          ; $00B256
        lsl.w        #$8, d1                                       ; $00B25A
        addi.w       #$80, d1                                      ; $00B25C
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B260
        addi.w       #$100, d0                                     ; $00B264
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B268
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B26C
        bsr.w        ProjectAndDrawWallFace                        ; $00B274
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B278
        clr.w        d3                                            ; $00B27C
        rts                                                        ; $00B27E
        ifne *-$B280
        fail "ROM end moved"
        endif
