; $019AE6..$019BC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$06; ordinary CB/counter4/state3; preserve C8/C9. GoalAngle word set8, corpse callbacks. Alternate signal uses shared legacy effect.
        ifne *-$19AE6
        fail "ROM start moved"
        endif

EnterBeatressDeath:
; Sound$06; ordinary CB/counter4/state3; preserve C8/C9. GoalAngle word set8, corpse callbacks. Alternate signal uses shared legacy effect.
        move.l       a0, -(a7)                                     ; $019AE6
        move.w       #$6, d0                                       ; $019AE8
        jsr          RouteSoundEventByActorFloor.l                         ; $019AEC
        movea.l      (a7)+, a0                                     ; $019AF2
        tst.b        ActorAlternateDeathSignal(a0)                 ; $019AF4
        bne.w        EnterLegacyEnemyDeathEffect                   ; $019AF8
        andi.w       #$ff2f, ActorFlags(a0)                        ; $019AFC
        move.l       #UpdateBeatressCorpse, ActorUpdateCallback(a0) ; $019B02
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $019B0A
        clr.b        ActorUpdateDelay(a0)                          ; $019B0E
        move.l       #HitBeatressCorpse, ActorHitCallback(a0)      ; $019B12
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $019B1A
        tst.b        ActorMarkerTracked(a0)                        ; $019B22
        beq.b        loc_019B30                                    ; $019B26
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $019B28

loc_019B30:
        move.l       #DrawBeatressCorpse, ActorDrawCallback(a0)    ; $019B30
        move.w       #$8, ActorGoalAngle(a0)                       ; $019B38
        clr.w        ActorMotionX(a0)                              ; $019B3E
        clr.w        ActorMotionY(a0)                              ; $019B42
        move.b       #$3, ActorState(a0)                           ; $019B46
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019B4C
        beq.w        loc_019B6C                                    ; $019B52
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019B56
        beq.w        loc_019B6C                                    ; $019B5C
        move.b       #$cb, ActorDeathMode(a0)                      ; $019B60
        move.b       #$4, ActorStateCounter(a0)                    ; $019B66

loc_019B6C:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $019B6C
        tst.w        rLinkRole(a6)                                 ; $019B72
        bne.b        loc_019B7A                                    ; $019B76
        rts                                                        ; $019B78

loc_019B7A:
        move.l       #$1ef8a, ActorLinkCallback(a0)                ; $019B7A
        lea.l        rSharedScratchBuffer(a6), a1                                ; $019B82
        move.b       #$12, (a1)+                                   ; $019B86
        move.b       ActorLinkId(a0), (a1)+                        ; $019B8A
        move.w       ActorFlags(a0), d0                            ; $019B8E
        ori.w        #$20, d0                                      ; $019B92
        move.b       d0, (a1)+                                     ; $019B96
        move.b       ActorFloor(a0), (a1)+                         ; $019B98
        lea.l        rSharedScratchBuffer(a6), a0                                ; $019B9C
        jmp          QueueLinkCommand.l                            ; $019BA0

BeatressTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $019BA6
        bne.w        loc_019BB8                                    ; $019BAA
        move.b       #$c8, ActorDeathMode(a0)                      ; $019BAE
        bra.w        EnterBeatressDeath                            ; $019BB4

loc_019BB8:
        rts                                                        ; $019BB8

BeatressTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $019BBA
        bne.b        loc_019BB8                                    ; $019BBE
        move.b       #$c9, ActorDeathMode(a0)                      ; $019BC0
        bra.w        EnterBeatressDeath                            ; $019BC6
        ifne *-$19BCA
        fail "ROM end moved"
        endif
