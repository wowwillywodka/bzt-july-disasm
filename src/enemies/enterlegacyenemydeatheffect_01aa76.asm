; $01AA76..$01AAEF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Alternative death setup requires nonzero ActorAlternateDeathSignal. Global decoded literal/overlapping-write search finds only allocator clears at $1C0E8/$1C128; no enabling writer. Synthetic flag tests are not ordinary gameplay evidence. See docs/ENEMY_REACHABILITY.md.
        ifne *-$1AA76
        fail "ROM start moved"
        endif

EnterLegacyEnemyDeathEffect:
; Alternative death setup requires nonzero ActorAlternateDeathSignal. Global decoded literal/overlapping-write search finds only allocator clears at $1C0E8/$1C128; no enabling writer. Synthetic flag tests are not ordinary gameplay evidence. See docs/ENEMY_REACHABILITY.md.
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01AA76
        move.l       #$1f8f8, ActorUpdateCallback(a0)              ; $01AA7C
        clr.b        ActorUpdateDelay(a0)                          ; $01AA84
        move.l       #$1f93a, ActorHitCallback(a0)                 ; $01AA88
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $01AA90
        move.l       #DrawLegacyDeathEffect, ActorDrawCallback(a0) ; $01AA98
        clr.w        ActorMotionX(a0)                              ; $01AAA0
        clr.w        ActorMotionY(a0)                              ; $01AAA4
        move.l       #LegacyDeathEffectSpriteBank, ActorSpriteBank(a0) ; $01AAA8
        move.b       #$35, ActorCorpseCellProfile(a0)              ; $01AAB0
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01AAB6
        tst.w        rLinkRole(a6)                                 ; $01AABC
        bne.b        loc_01AAC4                                    ; $01AAC0
        rts                                                        ; $01AAC2

loc_01AAC4:
        move.l       #RendererRoutine_01F822, ActorLinkCallback(a0) ; $01AAC4
        lea.l        -$6fdc(a6), a1                                ; $01AACC
        move.b       #$12, (a1)+                                   ; $01AAD0
        move.b       ActorLinkId(a0), (a1)+                        ; $01AAD4
        move.w       ActorFlags(a0), d0                            ; $01AAD8
        ori.w        #$20, d0                                      ; $01AADC
        move.b       d0, (a1)+                                     ; $01AAE0
        move.b       ActorFloor(a0), (a1)+                         ; $01AAE2
        lea.l        -$6fdc(a6), a0                                ; $01AAE6
        jmp          QueueLinkCommand.l                            ; $01AAEA
        ifne *-$1AAF0
        fail "ROM end moved"
        endif
