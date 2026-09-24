; $017EDE..$017FCF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$10; ordinary state3/modeCB, but no counter initialization. CE ->state4; C8/C9 preserved. Corpse update decrements STATE during CC, not counter.
        ifne *-$17EDE
        fail "ROM start moved"
        endif

EnterBlueDummyDeath:
; Sound$10; ordinary state3/modeCB, but no counter initialization. CE ->state4; C8/C9 preserved. Corpse update decrements STATE during CC, not counter.
        move.l       a0, -(a7)                                     ; $017EDE
        move.w       #$10, d0                                      ; $017EE0
        jsr          RouteSoundEventByActorFloor.l                         ; $017EE4
        movea.l      (a7)+, a0                                     ; $017EEA
        tst.b        ActorAlternateDeathSignal(a0)                 ; $017EEC
        bne.w        EnterLegacyEnemyDeathEffect                   ; $017EF0
        andi.w       #$ff2f, ActorFlags(a0)                        ; $017EF4
        move.l       #UpdateBlueDummyCorpse, ActorUpdateCallback(a0) ; $017EFA
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $017F02
        clr.b        ActorUpdateDelay(a0)                          ; $017F06
        move.l       #HitBlueDummyCorpse, ActorHitCallback(a0)     ; $017F0A
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $017F12
        tst.b        ActorMarkerTracked(a0)                        ; $017F1A
        beq.b        loc_017F28                                    ; $017F1E
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $017F20

loc_017F28:
        move.l       #DrawBlueDummyCorpse, ActorDrawCallback(a0)   ; $017F28
        clr.w        ActorMotionX(a0)                              ; $017F30
        clr.w        ActorMotionY(a0)                              ; $017F34
        move.b       #$3, ActorState(a0)                           ; $017F38
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $017F3E
        bne.b        loc_017F4E                                    ; $017F44
        move.b       #$4, ActorState(a0)                           ; $017F46
        bra.b        loc_017F68                                    ; $017F4C

loc_017F4E:
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $017F4E
        beq.w        loc_017F68                                    ; $017F54
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $017F58
        beq.w        loc_017F68                                    ; $017F5E
        move.b       #$cb, ActorDeathMode(a0)                      ; $017F62

loc_017F68:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $017F68
        tst.w        rLinkRole(a6)                                 ; $017F6E
        bne.b        loc_017F76                                    ; $017F72
        rts                                                        ; $017F74

loc_017F76:
        move.l       #$1efa2, ActorLinkCallback(a0)                ; $017F76
        lea.l        rSharedScratchBuffer(a6), a1                                ; $017F7E
        move.b       #$12, (a1)+                                   ; $017F82
        move.b       ActorLinkId(a0), (a1)+                        ; $017F86
        move.w       ActorFlags(a0), d0                            ; $017F8A
        ori.w        #$20, d0                                      ; $017F8E
        move.b       d0, (a1)+                                     ; $017F92
        move.b       ActorFloor(a0), (a1)+                         ; $017F94
        lea.l        rSharedScratchBuffer(a6), a0                                ; $017F98
        jmp          QueueLinkCommand.l                            ; $017F9C

loc_017FA2:
        move.b       #$ce, ActorDeathMode(a0)                      ; $017FA2
        bra.w        EnterBlueDummyDeath                           ; $017FA8

BlueDummyTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $017FAC
        bne.w        loc_017FBE                                    ; $017FB0
        move.b       #$c8, ActorDeathMode(a0)                      ; $017FB4
        bra.w        EnterBlueDummyDeath                           ; $017FBA

loc_017FBE:
        rts                                                        ; $017FBE

BlueDummyTickInvisibleWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $017FC0
        bne.b        loc_017FBE                                    ; $017FC4
        move.b       #$c9, ActorDeathMode(a0)                      ; $017FC6
        bra.w        EnterBlueDummyDeath                           ; $017FCC
        ifne *-$17FD0
        fail "ROM end moved"
        endif
