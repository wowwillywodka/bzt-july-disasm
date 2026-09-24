; $00CEEA..$00CF29 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ordinary edge (X,Y) to (X,Y+1): profile 3, texture word +2.
; Classes 2 and 3 divert to their diagonal faces.
        ifne *-$CEEA
        fail "ROM start moved"
        endif

RenderWallEdgeX0:
        cmpi.b       #$2, d3                                       ; $00CEEA
        beq.w        RenderDiagonalCellFaceClass2                        ; $00CEEE
        cmpi.b       #$3, d3                                       ; $00CEF2
        beq.w        RenderDiagonalCellFaceClass3                        ; $00CEF6
        bsr.w        RecordVisibleCellRenderState                        ; $00CEFA
        move.w       rWallFaceHeightProfile3(a6), rCurrentWallFaceHeightProfile(a6)                        ; $00CEFE
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CF04
; Face slot +2 selects a 16-byte texture definition; other face paths use +4 and +6.
        move.w       $2(a2), d4                                    ; $00CF08
        lsl.w        #$4, d4                                       ; $00CF0C
        ext.l        d4                                            ; $00CF0E
        addi.l       #$ff8cea, d4                                  ; $00CF10
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CF16
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00CF1A
        addi.w       #$100, d1                                     ; $00CF1E
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00CF22
        bra.w        ProjectAndDrawWallFace                        ; $00CF26
        ifne *-$CF2A
        fail "ROM end moved"
        endif
