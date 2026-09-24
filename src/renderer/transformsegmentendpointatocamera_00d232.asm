; $00D232..$00D267 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Transform segment endpoint A into camera depth and lateral offset.
; Cache its world coordinates for the next B lookup.
; The 16-byte endpoint layout is documented in docs/WALL_PROJECTION.md.
        ifne *-$D232
        fail "ROM start moved"
        endif

TransformSegmentEndpointAToCamera:
        move.w       d0, rWallEndpointAWorldX(a6)                                ; $00D232
        move.w       d1, rWallEndpointAWorldY(a6)                                ; $00D236
        move.w       d0, d4                                        ; $00D23A
        sub.w        rPlayerX(a6), d4                              ; $00D23C
        move.w       d4, d5                                        ; $00D240
        muls.w       rPlayerFacingVectorX(a6), d4                                ; $00D242
        move.w       d1, d3                                        ; $00D246
        sub.w        rPlayerY(a6), d3                              ; $00D248
        move.w       d3, d6                                        ; $00D24C
        muls.w       rPlayerFacingVectorY(a6), d3                                ; $00D24E
        add.l        d3, d4                                        ; $00D252
        move.l       d4, rWallEndpointADepth(a6)                                ; $00D254
        muls.w       rPlayerFacingVectorX(a6), d6                                ; $00D258
        muls.w       rPlayerFacingVectorY(a6), d5                                ; $00D25C
        sub.l        d5, d6                                        ; $00D260
        move.l       d6, rWallEndpointALateral(a6)                                ; $00D262
        rts                                                        ; $00D266
        ifne *-$D268
        fail "ROM end moved"
        endif
