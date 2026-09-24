; $00D1D6..$00D231 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Transform segment endpoint B into camera depth and lateral offset.
; Reuse cached endpoint A if both world coordinates match.
; The 16-byte endpoint layout is documented in docs/WALL_PROJECTION.md.
        ifne *-$D1D6
        fail "ROM start moved"
        endif

TransformSegmentEndpointBToCamera:
        cmp.w        rWallEndpointAWorldX(a6), d0                                ; $00D1D6
        bne.b        loc_00D1E2                                    ; $00D1DA
        cmp.w        rWallEndpointAWorldY(a6), d1                                ; $00D1DC
        beq.b        loc_00D214                                    ; $00D1E0

loc_00D1E2:
        clr.w        rWallEndpointBCacheHit(a6)                                    ; $00D1E2
        move.w       d0, d4                                        ; $00D1E6
        sub.w        rPlayerX(a6), d4                              ; $00D1E8
        move.w       d4, d5                                        ; $00D1EC
        muls.w       rPlayerFacingVectorX(a6), d4                                ; $00D1EE
        move.w       d1, d3                                        ; $00D1F2
        sub.w        rPlayerY(a6), d3                              ; $00D1F4
        move.w       d3, d6                                        ; $00D1F8
        muls.w       rPlayerFacingVectorY(a6), d3                                ; $00D1FA
        add.l        d3, d4                                        ; $00D1FE
        move.l       d4, rWallEndpointBDepth(a6)                                ; $00D200
        muls.w       rPlayerFacingVectorX(a6), d6                                ; $00D204
        muls.w       rPlayerFacingVectorY(a6), d5                                ; $00D208
        sub.l        d5, d6                                        ; $00D20C
        move.l       d6, rWallEndpointBLateral(a6)                                ; $00D20E
        rts                                                        ; $00D212

loc_00D214:
        st.b         rWallEndpointBCacheHit(a6)                                    ; $00D214
        move.l       rWallEndpointADepth(a6), rWallEndpointBDepth(a6)                        ; $00D218
        move.l       rWallEndpointALateral(a6), rWallEndpointBLateral(a6)                        ; $00D21E
        move.w       rWallEndpointAInverseDepth(a6), rWallEndpointBInverseDepth(a6)                        ; $00D224
        move.w       rWallEndpointAScreenX(a6), rWallEndpointBScreenX(a6)                        ; $00D22A
        rts                                                        ; $00D230
        ifne *-$D232
        fail "ROM end moved"
        endif
