; $00D0F2..$00D121 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Class-3 diagonal (X,Y+1) to (X+1,Y), reversed endpoint order,
; texture word +0. It uses the current profile.
        ifne *-$D0F2
        fail "ROM start moved"
        endif

RenderDiagonalCellFaceClass3:
        bsr.w        RecordVisibleCellRenderState                        ; $00D0F2
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00D0F6
        move.w       (a2), d4                                      ; $00D0FA
        lsl.w        #$4, d4                                       ; $00D0FC
        ext.l        d4                                            ; $00D0FE
        addi.l       #$ff8cea, d4                                  ; $00D100
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00D106
        addi.w       #$100, d1                                     ; $00D10A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00D10E
        subi.w       #$100, d1                                     ; $00D112
        addi.w       #$100, d0                                     ; $00D116
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00D11A
        bra.w        ProjectAndDrawWallFace                        ; $00D11E
        ifne *-$D122
        fail "ROM end moved"
        endif
