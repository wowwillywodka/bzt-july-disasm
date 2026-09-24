; $01DC7E..$01DCB1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Proximity-charge state dispatcher: state 0 waits for target/proximity, state 1 counts down, other states check retention distance. Not part of the preceding billboard renderer.
        ifne *-$1DC7E
        fail "ROM start moved"
        endif

UpdateProximityWallCharge:
; Proximity-charge state dispatcher: state 0 waits for target/proximity, state 1 counts down, other states check retention distance. Not part of the preceding billboard renderer.
        clr.b        ActorUpdateDelay(a0)                          ; $01DC7E
        move.b       ActorState(a0), d0                            ; $01DC82
        beq.w        TryArmWallChargeWhenTargetNear                         ; $01DC86
        cmpi.b       #$1, d0                                       ; $01DC8A
        bne.w        RetireWallChargeWhenTargetFar                         ; $01DC8E
        subq.b       #$1, ActorStateCounter(a0)                    ; $01DC92
        beq.b        DetonateProximityWallCharge                   ; $01DC96
        move.b       ActorStateCounter(a0), d0                     ; $01DC98
        andi.w       #$7, d0                                       ; $01DC9C
        bne.b        loc_01DCB0                                    ; $01DCA0
        move.l       a0, -(a7)                                     ; $01DCA2
        move.w       #$68, d0                                      ; $01DCA4
        jsr          RouteSoundEventByActorFloor.l                         ; $01DCA8
        movea.l      (a7)+, a0                                     ; $01DCAE

loc_01DCB0:
        rts                                                        ; $01DCB0
        ifne *-$1DCB2
        fail "ROM end moved"
        endif
