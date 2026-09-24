; $01F856..$01F8A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1F856
        fail "ROM start moved"
        endif

RetainedInstallActorCallbacks:
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01F856
        move.l       #UpdateLegacyDeathEffect, ActorUpdateCallback(a0) ; $01F85C
        clr.b        ActorUpdateDelay(a0)                          ; $01F864
        move.l       #$1f93a, ActorHitCallback(a0)                 ; $01F868
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $01F870
        move.l       #DrawLegacyDeathEffect, ActorDrawCallback(a0) ; $01F878
        clr.w        ActorMotionX(a0)                              ; $01F880
        clr.w        ActorMotionY(a0)                              ; $01F884
        move.l       #LegacyDeathEffectSpriteBank, ActorSpriteBank(a0) ; $01F888
        move.b       #$35, ActorCorpseCellProfile(a0)              ; $01F890
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01F896
        tst.w        rLinkRole(a6)                                 ; $01F89C
        bne.b        SetActorLinkCallbackAndQueueCommand12                        ; $01F8A0
        rts                                                        ; $01F8A2
        ifne *-$1F8A4
        fail "ROM end moved"
        endif
