; $016BE2..$016CB9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active death entry: sound$23, state3, corpse callbacks, floor count and optional link command12. AlternateDeathSignal path at $1AA76 remains separately unresolved.
        ifne *-$16BE2
        fail "ROM start moved"
        endif

EnterGreyDummyDeath:
; Active death entry: sound$23, state3, corpse callbacks, floor count and optional link command12. AlternateDeathSignal path at $1AA76 remains separately unresolved.
        move.l       a0, -(a7)                                     ; $016BE2
        move.w       #$23, d0                                      ; $016BE4
        jsr          SoundRoutine_00DF64.l                         ; $016BE8
        movea.l      (a7)+, a0                                     ; $016BEE
        tst.b        ActorAlternateDeathSignal(a0)                 ; $016BF0
        bne.w        EnterLegacyEnemyDeathEffect                   ; $016BF4
        andi.w       #$ff2f, ActorFlags(a0)                        ; $016BF8
        move.l       #UpdateGreyDummyCorpse, ActorUpdateCallback(a0) ; $016BFE
        addq.w       #$1, -$71c8(a6)                               ; $016C06
        clr.b        ActorUpdateDelay(a0)                          ; $016C0A
        move.l       #HitGreyDummyCorpse, ActorHitCallback(a0)     ; $016C0E
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $016C16
        tst.b        ActorMarkerTracked(a0)                        ; $016C1E
        beq.b        loc_016C2C                                    ; $016C22
        move.l       #EnvironmentRoutine_097964, ActorExitCallback(a0) ; $016C24

loc_016C2C:
        move.l       #DrawGreyDummyCorpse, ActorDrawCallback(a0)   ; $016C2C
        clr.w        ActorMotionX(a0)                              ; $016C34
        clr.w        ActorMotionY(a0)                              ; $016C38
        move.b       #$3, ActorState(a0)                           ; $016C3C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016C42
        beq.w        loc_016C5C                                    ; $016C48
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $016C4C
        beq.w        loc_016C5C                                    ; $016C52
        move.b       #$cb, ActorDeathMode(a0)                      ; $016C56

loc_016C5C:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $016C5C
        tst.w        rLinkRole(a6)                                 ; $016C62
        bne.b        loc_016C6A                                    ; $016C66
        rts                                                        ; $016C68

loc_016C6A:
        move.l       #$1ef7e, ActorLinkCallback(a0)                ; $016C6A
        lea.l        -$6fdc(a6), a1                                ; $016C72
        move.b       #$12, (a1)+                                   ; $016C76
        move.b       ActorLinkId(a0), (a1)+                        ; $016C7A
        move.w       ActorFlags(a0), d0                            ; $016C7E
        ori.w        #$20, d0                                      ; $016C82
        move.b       d0, (a1)+                                     ; $016C86
        move.b       ActorFloor(a0), (a1)+                         ; $016C88
        lea.l        -$6fdc(a6), a0                                ; $016C8C
        jmp          QueueLinkCommand.l                            ; $016C90

GreyDummyTickWeapon0DDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $016C96
        bne.w        loc_016CA8                                    ; $016C9A
        move.b       #$c8, ActorDeathMode(a0)                      ; $016C9E
        bra.w        EnterGreyDummyDeath                           ; $016CA4

loc_016CA8:
        rts                                                        ; $016CA8

GreyDummyTickWeapon0BDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $016CAA
        bne.b        loc_016CA8                                    ; $016CAE
        move.b       #$c9, ActorDeathMode(a0)                      ; $016CB0
        bra.w        EnterGreyDummyDeath                           ; $016CB6
        ifne *-$16CBA
        fail "ROM end moved"
        endif
