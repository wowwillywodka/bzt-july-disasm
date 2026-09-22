; $01A4C4..$01A5A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active normal death: sound$21, GoalAngle word repurposed to8, corpse callbacks; normal CB/counter4, but C8/C9 preserved. Alternate signal uses shared legacy effect setup.
        ifne *-$1A4C4
        fail "ROM start moved"
        endif

EnterWhiteDummyDeath:
; Active normal death: sound$21, GoalAngle word repurposed to8, corpse callbacks; normal CB/counter4, but C8/C9 preserved. Alternate signal uses shared legacy effect setup.
        move.l       a0, -(a7)                                     ; $01A4C4
        move.w       #$21, d0                                      ; $01A4C6
        jsr          SoundRoutine_00DF64.l                         ; $01A4CA
        movea.l      (a7)+, a0                                     ; $01A4D0
        tst.b        ActorAlternateDeathSignal(a0)                 ; $01A4D2
        bne.w        EnterLegacyEnemyDeathEffect                   ; $01A4D6
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01A4DA
        move.l       #UpdateWhiteDummyCorpse, ActorUpdateCallback(a0) ; $01A4E0
        addq.w       #$1, -$71c8(a6)                               ; $01A4E8
        clr.b        ActorUpdateDelay(a0)                          ; $01A4EC
        move.l       #HitWhiteDummyCorpse, ActorHitCallback(a0)    ; $01A4F0
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $01A4F8
        tst.b        ActorMarkerTracked(a0)                        ; $01A500
        beq.b        loc_01A50E                                    ; $01A504
        move.l       #EnvironmentRoutine_097964, ActorExitCallback(a0) ; $01A506

loc_01A50E:
        move.l       #DrawWhiteDummyCorpse, ActorDrawCallback(a0)  ; $01A50E
        move.w       #$8, ActorGoalAngle(a0)                       ; $01A516
        clr.w        ActorMotionX(a0)                              ; $01A51C
        clr.w        ActorMotionY(a0)                              ; $01A520
        move.b       #$3, ActorState(a0)                           ; $01A524
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01A52A
        beq.w        loc_01A54A                                    ; $01A530
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01A534
        beq.w        loc_01A54A                                    ; $01A53A
        move.b       #$cb, ActorDeathMode(a0)                      ; $01A53E
        move.b       #$4, ActorStateCounter(a0)                    ; $01A544

loc_01A54A:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01A54A
        tst.w        rLinkRole(a6)                                 ; $01A550
        bne.b        loc_01A558                                    ; $01A554
        rts                                                        ; $01A556

loc_01A558:
        move.l       #$1ef90, ActorLinkCallback(a0)                ; $01A558
        lea.l        -$6fdc(a6), a1                                ; $01A560
        move.b       #$12, (a1)+                                   ; $01A564
        move.b       ActorLinkId(a0), (a1)+                        ; $01A568
        move.w       ActorFlags(a0), d0                            ; $01A56C
        ori.w        #$20, d0                                      ; $01A570
        move.b       d0, (a1)+                                     ; $01A574
        move.b       ActorFloor(a0), (a1)+                         ; $01A576
        lea.l        -$6fdc(a6), a0                                ; $01A57A
        jmp          QueueLinkCommand.l                            ; $01A57E

WhiteDummyTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A584
        bne.w        loc_01A596                                    ; $01A588
        move.b       #$c8, ActorDeathMode(a0)                      ; $01A58C
        bra.w        EnterWhiteDummyDeath                          ; $01A592

loc_01A596:
        rts                                                        ; $01A596

WhiteDummyTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A598
        bne.b        loc_01A596                                    ; $01A59C
        move.b       #$c9, ActorDeathMode(a0)                      ; $01A59E
        bra.w        EnterWhiteDummyDeath                          ; $01A5A4
        ifne *-$1A5A8
        fail "ROM end moved"
        endif
