; $01C2F2..$01C333 | m68k
; Maintained assembly input; no extraction occurs during build.
; Convert remote kind $31 to the retained legacy death-effect callbacks.
        ifne *-$1C2F2
        fail "ROM start moved"
        endif

ConvertDisconnectedActorToLegacyDeathEffect:
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01C2F2
        move.l       #UpdateLegacyDeathEffect, ActorUpdateCallback(a0) ; $01C2F8
        clr.b        ActorUpdateDelay(a0)                          ; $01C300
        move.l       #$1f93a, ActorHitCallback(a0)                 ; $01C304
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $01C30C
        move.l       #DrawLegacyDeathEffect, ActorDrawCallback(a0) ; $01C314
        clr.w        ActorMotionX(a0)                              ; $01C31C
        clr.w        ActorMotionY(a0)                              ; $01C320
        move.l       #LegacyDeathEffectSpriteBank, ActorSpriteBank(a0) ; $01C324
        move.b       #$35, ActorCorpseCellProfile(a0)              ; $01C32C
        rts                                                        ; $01C332
        ifne *-$1C334
        fail "ROM end moved"
        endif
