; $00D082..$00D0F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Class-5 diagonal (X,Y+1) to (X+1,Y), texture word +6.
; The class-3 current-cell entry follows at $D0B4.
        ifne *-$D082
        fail "ROM start moved"
        endif

RenderDiagonalCellFaceClass5:
        bsr.w        RecordVisibleCellRenderState                        ; $00D082
        movea.l      rCurrentCellTextureOrder(a6), a2              ; $00D086
        move.w       $6(a2), d4                                    ; $00D08A
        lsl.w        #$4, d4                                       ; $00D08E
        ext.l        d4                                            ; $00D090
        addi.l       #$ff8cea, d4                                  ; $00D092
        move.l       d4, rCurrentWallTilePair(a6)                  ; $00D098
        addi.w       #$100, d1                                     ; $00D09C
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00D0A0
        subi.w       #$100, d1                                     ; $00D0A4
        addi.w       #$100, d0                                     ; $00D0A8
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00D0AC
        bra.w        ProjectAndDrawWallFace                        ; $00D0B0

loc_00D0B4:
        cmpa.l       rCurrentWallMapCellPointer(a6), a0                                ; $00D0B4
        beq.b        loc_00D0F0                                    ; $00D0B8
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00D0BA
        clr.w        d4                                            ; $00D0BE
        move.b       (a0), d4                                      ; $00D0C0
        lsl.w        #$3, d4                                       ; $00D0C2
        lea.l        rTextureOrder(a6), a2                         ; $00D0C4
        adda.w       d4, a2                                        ; $00D0C8
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00D0CA
        add.w        rPlayerCellX(a6), d0                          ; $00D0CE
        lsl.w        #$8, d0                                       ; $00D0D2
        add.w        rPlayerCellY(a6), d1                          ; $00D0D4
        lsl.w        #$8, d1                                       ; $00D0D8
        move.w       #$ffff, rWallSpanEndColumnForRaySkip(a6)                            ; $00D0DA
        bsr.b        RenderDiagonalCellFaceClass3                        ; $00D0E0
        move.w       rWallSpanEndColumnForRaySkip(a6), d0                                ; $00D0E2
        cmp.w        rCurrentVisibleRaySampleIndex(a6), d0                                ; $00D0E6
        ble.b        loc_00D0F0                                    ; $00D0EA
        move.w       d0, rCurrentVisibleRaySampleIndex(a6)                                ; $00D0EC

loc_00D0F0:
        rts                                                        ; $00D0F0
        ifne *-$D0F2
        fail "ROM end moved"
        endif
