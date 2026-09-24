; $00CF2A..$00CFAB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ordinary edge (X+1,Y) to (X+1,Y+1): profile 2, texture word +4.
; Classes 5 and 4 divert to diagonals. The class-4 entry follows at $CF6E.
        ifne *-$CF2A
        fail "ROM start moved"
        endif

RenderWallEdgeX1:
        cmpi.b       #$5, d3                                       ; $00CF2A
        beq.w        RenderDiagonalCellFaceClass5                        ; $00CF2E
        cmpi.b       #$4, d3                                       ; $00CF32
        beq.w        RenderDiagonalCellFaceClass4                        ; $00CF36
        bsr.w        RecordVisibleCellRenderState                        ; $00CF3A
        move.w       rWallFaceHeightProfile2(a6), rCurrentWallFaceHeightProfile(a6)                        ; $00CF3E
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00CF44
        move.w       $4(a2), d4                                    ; $00CF48
        lsl.w        #$4, d4                                       ; $00CF4C
        ext.l        d4                                            ; $00CF4E
        addi.l       #$ff8cea, d4                                  ; $00CF50
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00CF56
        addi.w       #$100, d0                                     ; $00CF5A
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00CF5E
        addi.w       #$100, d1                                     ; $00CF62
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00CF66
        bra.w        ProjectAndDrawWallFace                        ; $00CF6A

loc_00CF6E:
        cmpa.l       rCurrentWallMapCellPointer(a6), a0                                ; $00CF6E
        beq.b        loc_00CFAA                                    ; $00CF72
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00CF74
        clr.w        d4                                            ; $00CF78
        move.b       (a0), d4                                      ; $00CF7A
        lsl.w        #$3, d4                                       ; $00CF7C
        lea.l        rTextureOrder(a6), a2                         ; $00CF7E
        adda.w       d4, a2                                        ; $00CF82
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CF84
        add.w        rPlayerCellX(a6), d0                          ; $00CF88
        lsl.w        #$8, d0                                       ; $00CF8C
        add.w        rPlayerCellY(a6), d1                          ; $00CF8E
        lsl.w        #$8, d1                                       ; $00CF92
        move.w       #$ffff, rWallSpanEndColumnForRaySkip(a6)                            ; $00CF94
        bsr.b        RenderDiagonalCellFaceClass4                        ; $00CF9A
        move.w       rWallSpanEndColumnForRaySkip(a6), d0                                ; $00CF9C
        cmp.w        rCurrentVisibleRaySampleIndex(a6), d0                                ; $00CFA0
        ble.b        loc_00CFAA                                    ; $00CFA4
        move.w       d0, rCurrentVisibleRaySampleIndex(a6)                                ; $00CFA6

loc_00CFAA:
        rts                                                        ; $00CFAA
        ifne *-$CFAC
        fail "ROM end moved"
        endif
