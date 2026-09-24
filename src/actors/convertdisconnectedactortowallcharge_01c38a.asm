; $01C38A..$01C3BF | m68k
; Maintained assembly input; no extraction occurs during build.
; Remote kind $07: arm a local proximity wall charge.
        ifne *-$1C38A
        fail "ROM start moved"
        endif

ConvertDisconnectedActorToWallCharge:
        clr.b        ActorUpdateDelay(a0)                          ; $01C38A
        clr.b        ActorState(a0)                                ; $01C38E
        move.l       #UpdateProximityWallCharge, ActorUpdateCallback(a0) ; $01C392
        move.l       #DrawProximityWallChargeTile, ActorDrawCallback(a0)            ; $01C39A
        move.l       #ConvertWallChargeToFireOnHit, ActorHitCallback(a0)                 ; $01C3A2
        move.l       #RestoreWallChargeCellAndRemove, ActorExitCallback(a0) ; $01C3AA
        ori.w        #$84, ActorFlags(a0)                          ; $01C3B2
        move.w       #$64, ActorHealth(a0)                         ; $01C3B8
        rts                                                        ; $01C3BE
        ifne *-$1C3C0
        fail "ROM end moved"
        endif
