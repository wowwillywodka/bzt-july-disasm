; $01DF3A..$01DF65 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1DF3A
        fail "ROM start moved"
        endif

UpdateWallChargeHitFire:
        move.w       ActorVelocityZ(a0), d0                        ; $01DF3A
        sub.w        d0, ActorZ(a0)                                ; $01DF3E
        addq.w       #$1, d0                                       ; $01DF42
        move.w       d0, ActorVelocityZ(a0)                        ; $01DF44
        cmpi.w       #$ffe0, ActorZ(a0)                            ; $01DF48
        bge.b        loc_01DF56                                    ; $01DF4E
        move.w       #$ffe0, ActorZ(a0)                            ; $01DF50

loc_01DF56:
        addq.b       #$1, ActorStateCounter(a0)                    ; $01DF56
        cmpi.b       #$a, ActorStateCounter(a0)                    ; $01DF5A
        beq.w        RemoveActorAndSendLink                        ; $01DF60
        rts                                                        ; $01DF64
        ifne *-$1DF66
        fail "ROM end moved"
        endif
