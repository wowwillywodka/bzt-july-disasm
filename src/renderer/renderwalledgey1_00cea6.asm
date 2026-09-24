; $00CEA6..$00CEE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ordinary edge (X,Y+1) to (X+1,Y+1): profile 1, texture word +6.
; Classes 2 and 5 divert to their diagonal faces.
        ifne *-$CEA6
        fail "ROM start moved"
        endif

RenderWallEdgeY1:
        cmpi.b       #$2, d3                                       ; $00CEA6
        beq.w        RenderDiagonalCellFaceClass2                        ; $00CEAA
        cmpi.b       #$5, d3                                       ; $00CEAE
        beq.w        RenderDiagonalCellFaceClass5                        ; $00CEB2
        bsr.w        RecordVisibleCellRenderState                        ; $00CEB6
        move.w       rWallFaceHeightProfile1(a6), rCurrentWallFaceHeightProfile(a6)                        ; $00CEBA
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CEC0
        move.w       $6(a2), d4                                    ; $00CEC4
        lsl.w        #$4, d4                                       ; $00CEC8
        ext.l        d4                                            ; $00CECA
        addi.l       #$ff8cea, d4                                  ; $00CECC
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CED2
        addi.w       #$100, d1                                     ; $00CED6
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00CEDA
        addi.w       #$100, d0                                     ; $00CEDE
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00CEE2
        bra.w        ProjectAndDrawWallFace                        ; $00CEE6
        ifne *-$CEEA
        fail "ROM end moved"
        endif
