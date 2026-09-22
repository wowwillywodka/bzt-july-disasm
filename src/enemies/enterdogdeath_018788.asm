; $018788..$01887F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$36; ordinary CB/counter4/state3; CE->state4, preserve C8/C9. Does not force all modes to CB as Denpyder does.
        ifne *-$18788
        fail "ROM start moved"
        endif

EnterDogDeath:
; Sound$36; ordinary CB/counter4/state3; CE->state4, preserve C8/C9. Does not force all modes to CB as Denpyder does.
        move.l       a0, -(a7)                                     ; $018788
        move.w       #$36, d0                                      ; $01878A
        jsr          SoundRoutine_00DF64.l                         ; $01878E
        movea.l      (a7)+, a0                                     ; $018794
        tst.b        ActorAlternateDeathSignal(a0)                 ; $018796
        bne.w        EnterLegacyEnemyDeathEffect                   ; $01879A
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01879E
        move.l       #UpdateDogCorpse, ActorUpdateCallback(a0)     ; $0187A4
        addq.w       #$1, -$71c8(a6)                               ; $0187AC
        clr.b        ActorUpdateDelay(a0)                          ; $0187B0
        move.l       #HitDogCorpse, ActorHitCallback(a0)           ; $0187B4
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $0187BC
        tst.b        ActorMarkerTracked(a0)                        ; $0187C4
        beq.b        loc_0187D2                                    ; $0187C8
        move.l       #EnvironmentRoutine_097964, ActorExitCallback(a0) ; $0187CA

loc_0187D2:
        move.l       #DrawDogCorpse, ActorDrawCallback(a0)         ; $0187D2
        clr.w        ActorMotionX(a0)                              ; $0187DA
        clr.w        ActorMotionY(a0)                              ; $0187DE
        move.b       #$3, ActorState(a0)                           ; $0187E2
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $0187E8
        bne.b        loc_0187F8                                    ; $0187EE
        move.b       #$4, ActorState(a0)                           ; $0187F0
        bra.b        loc_018818                                    ; $0187F6

loc_0187F8:
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0187F8
        beq.w        loc_018818                                    ; $0187FE
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $018802
        beq.w        loc_018818                                    ; $018808
        move.b       #$cb, ActorDeathMode(a0)                      ; $01880C
        move.b       #$4, ActorStateCounter(a0)                    ; $018812

loc_018818:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $018818
        tst.w        rLinkRole(a6)                                 ; $01881E
        bne.b        loc_018826                                    ; $018822
        rts                                                        ; $018824

loc_018826:
        move.l       #$1efa8, ActorLinkCallback(a0)                ; $018826
        lea.l        -$6fdc(a6), a1                                ; $01882E
        move.b       #$12, (a1)+                                   ; $018832
        move.b       ActorLinkId(a0), (a1)+                        ; $018836
        move.w       ActorFlags(a0), d0                            ; $01883A
        ori.w        #$20, d0                                      ; $01883E
        move.b       d0, (a1)+                                     ; $018842
        move.b       ActorFloor(a0), (a1)+                         ; $018844
        lea.l        -$6fdc(a6), a0                                ; $018848
        jmp          QueueLinkCommand.l                            ; $01884C

DogEnterWeaponFiveDeath:
        move.b       #$ce, ActorDeathMode(a0)                      ; $018852
        bra.w        EnterDogDeath                                 ; $018858

DogTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01885C
        bne.w        loc_01886E                                    ; $018860
        move.b       #$c8, ActorDeathMode(a0)                      ; $018864
        bra.w        EnterDogDeath                                 ; $01886A

loc_01886E:
        rts                                                        ; $01886E

DogTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $018870
        bne.b        loc_01886E                                    ; $018874
        move.b       #$c9, ActorDeathMode(a0)                      ; $018876
        bra.w        EnterDogDeath                                 ; $01887C
        ifne *-$18880
        fail "ROM end moved"
        endif
