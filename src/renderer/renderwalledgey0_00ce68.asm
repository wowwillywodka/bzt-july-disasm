; $00CE68..$00CEA5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ordinary edge (X,Y) to (X+1,Y): profile 0, texture word +0.
; Classes 3 and 4 divert to their diagonal faces.
        ifne *-$CE68
        fail "ROM start moved"
        endif

RenderWallEdgeY0:
        cmpi.b       #$3, d3                                       ; $00CE68
        beq.w        RenderDiagonalCellFaceClass3                        ; $00CE6C
        cmpi.b       #$4, d3                                       ; $00CE70
        beq.w        RenderDiagonalCellFaceClass4                        ; $00CE74
        bsr.w        RecordVisibleCellRenderState                        ; $00CE78
        move.w       rWallFaceHeightProfile0(a6), rCurrentWallFaceHeightProfile(a6)                        ; $00CE7C
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CE82
; Face slot +0: texture ID * 16 selects four pairs of upper/lower tile indices in RAM TextureDefinitions.
        move.w       (a2), d4                                      ; $00CE86
        lsl.w        #$4, d4                                       ; $00CE88
        ext.l        d4                                            ; $00CE8A
        addi.l       #$ff8cea, d4                                  ; $00CE8C
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CE92
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00CE96
        addi.w       #$100, d0                                     ; $00CE9A
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00CE9E
        bra.w        ProjectAndDrawWallFace                        ; $00CEA2
        ifne *-$CEA6
        fail "ROM end moved"
        endif
