; $01B6E8..$01B7A9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$0A; corpse state4 (NOT pickup-eligible3), mode always CB/counter4, overwrites C8/C9. Corpse transition also ends state4, so normal corpse does not grant pickup.
        ifne *-$1B6E8
        fail "ROM start moved"
        endif

EnterDenpyderDeath:
; Sound$0A; corpse state4 (NOT pickup-eligible3), mode always CB/counter4, overwrites C8/C9. Corpse transition also ends state4, so normal corpse does not grant pickup.
        move.l       a0, -(a7)                                     ; $01B6E8
        move.w       #$a, d0                                       ; $01B6EA
        jsr          SoundRoutine_00DF64.l                         ; $01B6EE
        movea.l      (a7)+, a0                                     ; $01B6F4
        tst.b        ActorAlternateDeathSignal(a0)                 ; $01B6F6
        bne.w        EnterLegacyEnemyDeathEffect                   ; $01B6FA
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01B6FE
        move.l       #UpdateDenpyderCorpse, ActorUpdateCallback(a0) ; $01B704
        addq.w       #$1, -$71c8(a6)                               ; $01B70C
        clr.b        ActorUpdateDelay(a0)                          ; $01B710
        move.l       #HitDenpyderCorpse, ActorHitCallback(a0)      ; $01B714
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $01B71C
        tst.b        ActorMarkerTracked(a0)                        ; $01B724
        beq.b        loc_01B732                                    ; $01B728
        move.l       #EnvironmentRoutine_097964, ActorExitCallback(a0) ; $01B72A

loc_01B732:
        move.l       #DrawDenpyderCorpse, ActorDrawCallback(a0)    ; $01B732
        move.w       #$8, ActorGoalAngle(a0)                       ; $01B73A
        clr.w        ActorMotionX(a0)                              ; $01B740
        clr.w        ActorMotionY(a0)                              ; $01B744
        move.b       #$4, ActorState(a0)                           ; $01B748
        move.b       #$cb, ActorDeathMode(a0)                      ; $01B74E
        move.b       #$4, ActorStateCounter(a0)                    ; $01B754
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01B75A
        tst.w        rLinkRole(a6)                                 ; $01B760
        bne.b        loc_01B768                                    ; $01B764
        rts                                                        ; $01B766

loc_01B768:
        move.l       #$1ef96, ActorLinkCallback(a0)                ; $01B768
        lea.l        -$6fdc(a6), a1                                ; $01B770
        move.b       #$12, (a1)+                                   ; $01B774
        move.b       ActorLinkId(a0), (a1)+                        ; $01B778
        move.w       ActorFlags(a0), d0                            ; $01B77C
        ori.w        #$20, d0                                      ; $01B780
        move.b       d0, (a1)+                                     ; $01B784
        move.b       ActorFloor(a0), (a1)+                         ; $01B786
        lea.l        -$6fdc(a6), a0                                ; $01B78A
        jmp          QueueLinkCommand.l                            ; $01B78E

DenpyderTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B794
        bne.w        loc_01B7A6                                    ; $01B798
        move.b       #$c8, ActorDeathMode(a0)                      ; $01B79C
        bra.w        EnterDenpyderDeath                            ; $01B7A2

loc_01B7A6:
        rts                                                        ; $01B7A6

DenpyderDormantReturn:
        rts                                                        ; $01B7A8
        ifne *-$1B7AA
        fail "ROM end moved"
        endif
