; $0190E2..$0191DF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$26; normal CB/counter4/state3, GoalAngle8. PreserveC8/C9; CE->state4. Special corpses switch to Dog bank while drawing.
        ifne *-$190E2
        fail "ROM start moved"
        endif

EnterLarvaCreatureDeath:
; Sound$26; normal CB/counter4/state3, GoalAngle8. PreserveC8/C9; CE->state4. Special corpses switch to Dog bank while drawing.
        move.l       a0, -(a7)                                     ; $0190E2
        move.w       #$26, d0                                      ; $0190E4
        jsr          RouteSoundEventByActorFloor.l                         ; $0190E8
        movea.l      (a7)+, a0                                     ; $0190EE
        tst.b        ActorAlternateDeathSignal(a0)                 ; $0190F0
        bne.w        EnterLegacyEnemyDeathEffect                   ; $0190F4
        andi.w       #$ff2f, ActorFlags(a0)                        ; $0190F8
        move.l       #UpdateLarvaCreatureCorpse, ActorUpdateCallback(a0) ; $0190FE
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $019106
        clr.b        ActorUpdateDelay(a0)                          ; $01910A
        move.l       #HitLarvaCreatureCorpse, ActorHitCallback(a0) ; $01910E
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $019116
        tst.b        ActorMarkerTracked(a0)                        ; $01911E
        beq.b        loc_01912C                                    ; $019122
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $019124

loc_01912C:
        move.l       #DrawLarvaCreatureCorpse, ActorDrawCallback(a0) ; $01912C
        move.w       #$8, ActorGoalAngle(a0)                       ; $019134
        clr.w        ActorMotionX(a0)                              ; $01913A
        clr.w        ActorMotionY(a0)                              ; $01913E
        move.b       #$3, ActorState(a0)                           ; $019142
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $019148
        bne.b        loc_019158                                    ; $01914E
        move.b       #$4, ActorState(a0)                           ; $019150
        bra.b        loc_019178                                    ; $019156

loc_019158:
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019158
        beq.w        loc_019178                                    ; $01915E
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019162
        beq.w        loc_019178                                    ; $019168
        move.b       #$cb, ActorDeathMode(a0)                      ; $01916C
        move.b       #$4, ActorStateCounter(a0)                    ; $019172

loc_019178:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $019178
        tst.w        rLinkRole(a6)                                 ; $01917E
        bne.b        loc_019186                                    ; $019182
        rts                                                        ; $019184

loc_019186:
        move.l       #$1ef9c, ActorLinkCallback(a0)                ; $019186
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01918E
        move.b       #$12, (a1)+                                   ; $019192
        move.b       ActorLinkId(a0), (a1)+                        ; $019196
        move.w       ActorFlags(a0), d0                            ; $01919A
        ori.w        #$20, d0                                      ; $01919E
        move.b       d0, (a1)+                                     ; $0191A2
        move.b       ActorFloor(a0), (a1)+                         ; $0191A4
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0191A8
        jmp          QueueLinkCommand.l                            ; $0191AC

loc_0191B2:
        move.b       #$ce, ActorDeathMode(a0)                      ; $0191B2
        bra.w        EnterLarvaCreatureDeath                       ; $0191B8

LarvaCreatureTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0191BC
        bne.w        loc_0191CE                                    ; $0191C0
        move.b       #$c8, ActorDeathMode(a0)                      ; $0191C4
        bra.w        EnterLarvaCreatureDeath                       ; $0191CA

loc_0191CE:
        rts                                                        ; $0191CE

LarvaCreatureTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0191D0
        bne.b        loc_0191CE                                    ; $0191D4
        move.b       #$c9, ActorDeathMode(a0)                      ; $0191D6
        bra.w        EnterLarvaCreatureDeath                       ; $0191DC
        ifne *-$191E0
        fail "ROM end moved"
        endif
