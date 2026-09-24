; $01747E..$017555 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ACTIVE death code reached from $171B4 and special-state tails, despite neighboring retained attack body. Sound$13 and Green Dummy corpse callbacks.
        ifne *-$1747E
        fail "ROM start moved"
        endif

EnterGreenDummyDeath:
; ACTIVE death code reached from $171B4 and special-state tails, despite neighboring retained attack body. Sound$13 and Green Dummy corpse callbacks.
        move.l       a0, -(a7)                                     ; $01747E
        move.w       #$13, d0                                      ; $017480
        jsr          RouteSoundEventByActorFloor.l                         ; $017484
        movea.l      (a7)+, a0                                     ; $01748A
        tst.b        ActorAlternateDeathSignal(a0)                 ; $01748C
        bne.w        EnterLegacyEnemyDeathEffect                   ; $017490
        andi.w       #$ff2f, ActorFlags(a0)                        ; $017494
        move.l       #UpdateGreenDummyCorpse, ActorUpdateCallback(a0) ; $01749A
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $0174A2
        clr.b        ActorUpdateDelay(a0)                          ; $0174A6
        move.l       #HitGreenDummyCorpse, ActorHitCallback(a0)    ; $0174AA
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $0174B2
        tst.b        ActorMarkerTracked(a0)                        ; $0174BA
        beq.b        loc_0174C8                                    ; $0174BE
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $0174C0

loc_0174C8:
        move.l       #DrawGreenDummyCorpse, ActorDrawCallback(a0)  ; $0174C8
        clr.w        ActorMotionX(a0)                              ; $0174D0
        clr.w        ActorMotionY(a0)                              ; $0174D4
        move.b       #$3, ActorState(a0)                           ; $0174D8
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0174DE
        beq.w        loc_0174F8                                    ; $0174E4
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $0174E8
        beq.w        loc_0174F8                                    ; $0174EE
        move.b       #$cb, ActorDeathMode(a0)                      ; $0174F2

loc_0174F8:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $0174F8
        tst.w        rLinkRole(a6)                                 ; $0174FE
        bne.b        loc_017506                                    ; $017502
        rts                                                        ; $017504

loc_017506:
        move.l       #$1ef84, ActorLinkCallback(a0)                ; $017506
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01750E
        move.b       #$12, (a1)+                                   ; $017512
        move.b       ActorLinkId(a0), (a1)+                        ; $017516
        move.w       ActorFlags(a0), d0                            ; $01751A
        ori.w        #$20, d0                                      ; $01751E
        move.b       d0, (a1)+                                     ; $017522
        move.b       ActorFloor(a0), (a1)+                         ; $017524
        lea.l        rSharedScratchBuffer(a6), a0                                ; $017528
        jmp          QueueLinkCommand.l                            ; $01752C

GreenDummyTickWeapon0DDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $017532
        bne.w        loc_017544                                    ; $017536
        move.b       #$c8, ActorDeathMode(a0)                      ; $01753A
        bra.w        EnterGreenDummyDeath                          ; $017540

loc_017544:
        rts                                                        ; $017544

GreenDummyTickWeapon0BDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $017546
        bne.b        loc_017544                                    ; $01754A
        move.b       #$c9, ActorDeathMode(a0)                      ; $01754C
        bra.w        EnterGreenDummyDeath                          ; $017552
        ifne *-$17556
        fail "ROM end moved"
        endif
