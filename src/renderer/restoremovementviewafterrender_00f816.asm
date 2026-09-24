; $00F816..$00F837 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$F816
        fail "ROM start moved"
        endif

; Paired with ApplyMovementViewSway before rendering this frame.
RestoreMovementViewAfterRender:
        tst.l        rViewSwayAngleOffset(a6)                                    ; $00F816
        bne.b        loc_00F81E                                    ; $00F81A
        rts                                                        ; $00F81C

loc_00F81E:
        move.w       rViewSwaySavedFacingAngle(a6), rPlayerFacingAngle(a6)                        ; $00F81E
        move.w       rViewSwaySavedFacingVectorX(a6), rPlayerFacingVectorX(a6)                        ; $00F824
        move.w       rViewSwaySavedFacingVectorY(a6), rPlayerFacingVectorY(a6)                        ; $00F82A
        move.w       rViewSwaySavedOffsetZ(a6), rPlayerViewOffsetZ(a6)                        ; $00F830
        rts                                                        ; $00F836
        ifne *-$F838
        fail "ROM end moved"
        endif
