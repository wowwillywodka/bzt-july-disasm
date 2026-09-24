; $00F772..$00F7F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Player motion advances the sway phase. ViewDirectionSteps supplies a signed
; vertical offset (FF0E52) and facing-angle offset (FF0E50). The latter also
; shifts the Flash Light band by two screen columns per angle step.
        ifne *-$F772
        fail "ROM start moved"
        endif

ApplyMovementViewSway:
        move.w       rPlayerForwardSpeed(a6), d0                                ; $00F772
        bpl.b        loc_00F77A                                    ; $00F776
        neg.w        d0                                            ; $00F778

loc_00F77A:
        move.w       rPlayerStrafeSpeed(a6), d1                                ; $00F77A
        bpl.b        loc_00F782                                    ; $00F77E
        neg.w        d1                                            ; $00F780

loc_00F782:
        add.w        d1, d0                                        ; $00F782
        add.w        d0, rPlayerStridePhase(a6)                                ; $00F784
        bsr.b        PlayStrideSoundOnPhaseChange                           ; $00F788
        cmpi.w       #$28, d0                                      ; $00F78A
        bcs.b        loc_00F7F0                                    ; $00F78E
        move.w       rPlayerStridePhase(a6), d0                                ; $00F790
        lea.l        ViewDirectionSteps(pc), a0                    ; $00F794
        asr.w        #$4, d0                                       ; $00F798
        andi.w       #$1c, d0                                      ; $00F79A
        move.w       (a0, d0.w), d1                                ; $00F79E
        move.w       $2(a0, d0.w), d2                              ; $00F7A2
        bne.b        loc_00F7AC                                    ; $00F7A6
        tst.w        d1                                            ; $00F7A8
        beq.b        loc_00F7F0                                    ; $00F7AA

loc_00F7AC:
        move.w       d1, rViewSwayWeaponPhaseScratch(a6)                                ; $00F7AC
        move.w       d2, rViewSwayAngleOffset(a6)                                ; $00F7B0
        move.w       rPlayerFacingAngle(a6), rViewSwaySavedFacingAngle(a6)                        ; $00F7B4
        move.w       rPlayerFacingVectorX(a6), rViewSwaySavedFacingVectorX(a6)                        ; $00F7BA
        move.w       rPlayerFacingVectorY(a6), rViewSwaySavedFacingVectorY(a6)                        ; $00F7C0
        move.w       rPlayerViewOffsetZ(a6), rViewSwaySavedOffsetZ(a6)                        ; $00F7C6
        add.w        d1, rPlayerViewOffsetZ(a6)                                ; $00F7CC
        add.w        rPlayerFacingAngle(a6), d2                                ; $00F7D0
        andi.w       #$1ff, d2                                     ; $00F7D4
        move.w       d2, rPlayerFacingAngle(a6)                                ; $00F7D8
        lea.l        AngleVectorPairs(pc), a0                      ; $00F7DC
        lsl.w        #$2, d2                                       ; $00F7E0
        adda.w       d2, a0                                        ; $00F7E2
        move.w       (a0), rPlayerFacingVectorX(a6)                              ; $00F7E4
        move.w       $2(a0), rPlayerFacingVectorY(a6)                            ; $00F7E8
        rts                                                        ; $00F7EE

loc_00F7F0:
        clr.l        rViewSwayAngleOffset(a6)                                    ; $00F7F0
        rts                                                        ; $00F7F4
        ifne *-$F7F6
        fail "ROM end moved"
        endif
