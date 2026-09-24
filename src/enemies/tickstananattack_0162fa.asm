; $0162FA..$0164D7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Move countdown -> attack10, then caller immediately ticks9. Hit attempt at5, sounds at4/3. End sets move0/counter5/reloadflagFF; obstruction sets move0/reloadflagFF but keeps counter5.
        ifne *-$162FA
        fail "ROM start moved"
        endif

TickStananAttack:
; Move countdown -> attack10, then caller immediately ticks9. Hit attempt at5, sounds at4/3. End sets move0/counter5/reloadflagFF; obstruction sets move0/reloadflagFF but keeps counter5.
        cmpi.b       #$1, ActorState(a0)                           ; $0162FA
        beq.b        StananTickAttackCounter                       ; $016300
        subq.b       #$1, ActorStateCounter(a0)                    ; $016302
        beq.b        StananBeginAttack                             ; $016306
        rts                                                        ; $016308

StananBeginAttack:
        move.b       #$1, ActorState(a0)                           ; $01630A
        move.b       #$a, ActorStateCounter(a0)                    ; $016310
        rts                                                        ; $016316

StananTickAttackCounter:
        subq.b       #$1, ActorStateCounter(a0)                    ; $016318
        bne.b        loc_016332                                    ; $01631C
        move.b       #$5, ActorStateCounter(a0)                    ; $01631E

StananResumeMovement:
        move.b       #$0, ActorState(a0)                           ; $016324
        st.b         ActorBehaviorByte50(a0)                       ; $01632A
        bra.w        RefreshEnemyTargetOrExit                      ; $01632E

loc_016332:
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $016332
        beq.b        StananTryHitTarget                            ; $016338
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01633A
        beq.b        loc_01634C                                    ; $016340
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $016342
        beq.b        loc_01634C                                    ; $016348
        rts                                                        ; $01634A

loc_01634C:
        move.w       #$5f, d0                                      ; $01634C
        jsr          RouteSoundEventByActorFloor.l                         ; $016350
        move.w       #$83, d0                                      ; $016356
        jmp          RouteSoundEventByActorFloor.l                         ; $01635A

StananTryHitTarget:
        movea.l      ActorTarget(a0), a3                           ; $016360
        move.w       ActorX(a3), d0                                ; $016364
        move.w       ActorY(a3), d1                                ; $016368
        move.w       ActorX(a0), d3                                ; $01636C
        move.w       ActorY(a0), d4                                ; $016370
        jsr          TraceFiveRayObstructionInActiveWindow.l       ; $016374
        bne.b        StananResumeMovement                          ; $01637A
        move.w       #$400, d3                                     ; $01637C
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $016380
        bpl.b        loc_016396                                    ; $016384
        move.w       #$200, d3                                     ; $016386
        tst.w        rSceneColorMode(a6)                           ; $01638A
        beq.b        loc_0163A0                                    ; $01638E
        move.w       #$17b, d3                                     ; $016390
        bra.b        loc_0163A0                                    ; $016394

loc_016396:
        tst.w        rSceneColorMode(a6)                           ; $016396
        beq.b        loc_0163B0                                    ; $01639A
        move.w       #$300, d3                                     ; $01639C

loc_0163A0:
        jsr          NextRandom.l                                  ; $0163A0
        asr.l        #$8, d2                                       ; $0163A6
        andi.w       #$3ff, d2                                     ; $0163A8
        cmp.w        d3, d2                                        ; $0163AC
        bcc.b        loc_0163EA                                    ; $0163AE

loc_0163B0:
        move.w       ActorX(a0), d0                                ; $0163B0
        move.w       ActorY(a0), d1                                ; $0163B4
        sub.w        ActorX(a3), d0                                ; $0163B8
        sub.w        ActorY(a3), d1                                ; $0163BC
        move.w       d0, d3                                        ; $0163C0
        move.w       d1, d4                                        ; $0163C2
        jsr          OctagonalDistance.l                           ; $0163C4
        cmpi.w       #$400, d0                                     ; $0163CA
        bcc.b        loc_0163FE                                    ; $0163CE
; NextRandom clears D0.w: direct target hit callback gets zero distance after the strict distance<$400 test. No projectile is allocated in this path.
        jsr          NextRandom.w                                  ; $0163D0
        asr.w        #$8, d2                                       ; $0163D4
        andi.w       #$3, d2                                       ; $0163D6
        beq.w        loc_0163FE                                    ; $0163DA
        move.l       a0, -(a7)                                     ; $0163DE
        movea.l      a3, a0                                        ; $0163E0
        movea.l      ActorHitCallback(a0), a1                      ; $0163E2
        jsr          (a1)                                          ; $0163E6
        movea.l      (a7)+, a0                                     ; $0163E8

loc_0163EA:
        move.w       #$5f, d0                                      ; $0163EA
        jsr          RouteSoundEventByActorFloor.l                         ; $0163EE
        move.w       #$83, d0                                      ; $0163F4
        jsr          RouteSoundEventByActorFloor.l                         ; $0163F8

loc_0163FE:
        rts                                                        ; $0163FE

StananEnterDeath:
; Death sound $3A. Normal death callbacks install state3; HP death checks signed <0. AlternateDeathSignal still branches to the shared unresolved $1AA76 path.
        move.l       a0, -(a7)                                     ; $016400
        move.w       #$3a, d0                                      ; $016402
        jsr          RouteSoundEventByActorFloor.l                         ; $016406
        movea.l      (a7)+, a0                                     ; $01640C
        tst.b        ActorAlternateDeathSignal(a0)                 ; $01640E
        bne.w        EnterLegacyEnemyDeathEffect                   ; $016412
        andi.w       #$ff2f, ActorFlags(a0)                        ; $016416
        move.l       #UpdateStananCorpse, ActorUpdateCallback(a0)  ; $01641C
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $016424
        clr.b        ActorUpdateDelay(a0)                          ; $016428
        move.l       #HitStananCorpse, ActorHitCallback(a0)        ; $01642C
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $016434
        tst.b        ActorMarkerTracked(a0)                        ; $01643C
        beq.b        loc_01644A                                    ; $016440
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $016442

loc_01644A:
        move.l       #DrawStananCorpse, ActorDrawCallback(a0)      ; $01644A
        clr.w        ActorMotionX(a0)                              ; $016452
        clr.w        ActorMotionY(a0)                              ; $016456
        move.b       #$3, ActorState(a0)                           ; $01645A
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016460
        beq.w        loc_01647A                                    ; $016466
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01646A
        beq.w        loc_01647A                                    ; $016470
        move.b       #$cb, ActorDeathMode(a0)                      ; $016474

loc_01647A:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01647A
        tst.w        rLinkRole(a6)                                 ; $016480
        bne.b        loc_016488                                    ; $016484
        rts                                                        ; $016486

loc_016488:
        move.l       #$1ef72, ActorLinkCallback(a0)                ; $016488
        lea.l        rSharedScratchBuffer(a6), a1                                ; $016490
        move.b       #$12, (a1)+                                   ; $016494
        move.b       ActorLinkId(a0), (a1)+                        ; $016498
        move.w       ActorFlags(a0), d0                            ; $01649C
        ori.w        #$20, d0                                      ; $0164A0
        move.b       d0, (a1)+                                     ; $0164A4
        move.b       ActorFloor(a0), (a1)+                         ; $0164A6
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0164AA
        jmp          QueueLinkCommand.l                            ; $0164AE

StananTickWeapon0DDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0164B4
        bne.w        loc_0164C6                                    ; $0164B8
        move.b       #$c8, ActorDeathMode(a0)                      ; $0164BC
        bra.w        StananEnterDeath                              ; $0164C2

loc_0164C6:
        rts                                                        ; $0164C6

StananTickWeapon0BDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0164C8
        bne.b        loc_0164C6                                    ; $0164CC
        move.b       #$c9, ActorDeathMode(a0)                      ; $0164CE
        bra.w        StananEnterDeath                              ; $0164D4
        ifne *-$164D8
        fail "ROM end moved"
        endif
