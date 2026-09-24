; $00F216..$00F28B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Called during initial scene and each render; clamps coordinates, waits for DMA, enters renderer.
        ifne *-$F216
        fail "ROM start moved"
        endif

ClampPlayerToFloorBoundsAndRenderWorld:
        move.w       #$1b00, d2                                    ; $00F216
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $00F21A
        bge.b        loc_00F22A                                    ; $00F220
        move.w       rCurrentFloorWidth(a6), d2                    ; $00F222
        subq.w       #$5, d2                                       ; $00F226
        lsl.w        #$8, d2                                       ; $00F228

loc_00F22A:
        move.w       rPlayerX(a6), d0                              ; $00F22A
        cmpi.w       #$500, d0                                     ; $00F22E
        bcc.b        loc_00F23E                                    ; $00F232
        move.b       d0, d3                                        ; $00F234
        move.w       #$500, d0                                     ; $00F236
        move.b       d3, d0                                        ; $00F23A
        bra.b        loc_00F248                                    ; $00F23C

loc_00F23E:
        cmp.w        d2, d0                                        ; $00F23E
        bcs.b        loc_00F248                                    ; $00F240
        move.b       d0, d3                                        ; $00F242
        move.w       d2, d0                                        ; $00F244
        move.b       d3, d0                                        ; $00F246

loc_00F248:
        move.w       d0, rMapSpriteViewCenterX(a6)                                ; $00F248
        move.w       #$1b00, d2                                    ; $00F24C
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $00F250
        bge.b        loc_00F260                                    ; $00F256
        move.w       rCurrentFloorHeight(a6), d2                   ; $00F258
        subq.w       #$5, d2                                       ; $00F25C
        lsl.w        #$8, d2                                       ; $00F25E

loc_00F260:
        move.w       rPlayerY(a6), d0                              ; $00F260
        cmpi.w       #$500, d0                                     ; $00F264
        bcc.b        loc_00F274                                    ; $00F268
        move.b       d0, d3                                        ; $00F26A
        move.w       #$500, d0                                     ; $00F26C
        move.b       d3, d0                                        ; $00F270
        bra.b        loc_00F27E                                    ; $00F272

loc_00F274:
        cmp.w        d2, d0                                        ; $00F274
        bcs.b        loc_00F27E                                    ; $00F276
        move.b       d0, d3                                        ; $00F278
        move.w       d2, d0                                        ; $00F27A
        move.b       d3, d0                                        ; $00F27C

loc_00F27E:
        move.w       d0, rMapSpriteViewCenterY(a6)                                ; $00F27E

loc_00F282:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00F282
        bne.b        loc_00F282                                    ; $00F286
        bra.w        RenderRetainedMapGrid                        ; $00F288
        ifne *-$F28C
        fail "ROM end moved"
        endif
