; $01C35C..$01C389 | m68k
; Maintained assembly input; no extraction occurs during build.
; Remote kind $02: arm a local player proximity mine.
        ifne *-$1C35C
        fail "ROM start moved"
        endif

ConvertDisconnectedActorToProximityMine:
; The scheduler decrements $14 to $FF before calling this new update:
; absent another write, the first mine tick is the 21st list visit.
        move.b       #$14, ActorUpdateDelay(a0)                    ; $01C35C
        clr.b        ActorEffectCounter(a0)                        ; $01C362
        move.l       #UpdatePlayerProximityMine, ActorUpdateCallback(a0) ; $01C366
        move.l       #DrawProximityMineTile, ActorDrawCallback(a0)            ; $01C36E
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $01C376
        move.w       #$9, ActorFlags(a0)                           ; $01C37E
        clr.b        ActorState(a0)                                ; $01C384
        rts                                                        ; $01C388
        ifne *-$1C38A
        fail "ROM end moved"
        endif
