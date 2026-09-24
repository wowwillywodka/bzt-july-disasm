; $0194D6..$0195E9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Normal corpse pickup: distance<$60/state3, local item0C quantity2/3 and BULIGUN; remote command13/item08. C8/C9/CE bypass.
        ifne *-$194D6
        fail "ROM start moved"
        endif

MoveLarvaCreatureCorpseAndTryPickup:
; Normal corpse pickup: distance<$60/state3, local item0C quantity2/3 and BULIGUN; remote command13/item08. C8/C9/CE bypass.
        move.w       ActorMotionX(a0), d0                          ; $0194D6
        bmi.b        loc_0194E0                                    ; $0194DA
        asr.w        #$1, d0                                       ; $0194DC
        bra.b        loc_0194E6                                    ; $0194DE

loc_0194E0:
        neg.w        d0                                            ; $0194E0
        asr.w        #$1, d0                                       ; $0194E2
        neg.w        d0                                            ; $0194E4

loc_0194E6:
        move.w       d0, ActorMotionX(a0)                          ; $0194E6
        move.w       ActorMotionY(a0), d1                          ; $0194EA
        bmi.b        loc_0194F4                                    ; $0194EE
        asr.w        #$1, d1                                       ; $0194F0
        bra.b        loc_0194FA                                    ; $0194F2

loc_0194F4:
        neg.w        d1                                            ; $0194F4
        asr.w        #$1, d1                                       ; $0194F6
        neg.w        d1                                            ; $0194F8

loc_0194FA:
        move.w       d1, ActorMotionY(a0)                          ; $0194FA
        move.w       d0, d2                                        ; $0194FE
        or.w         d1, d2                                        ; $019500
        beq.b        loc_019510                                    ; $019502
        move.w       d0, ActorMotionX(a0)                          ; $019504
        move.w       d1, ActorMotionY(a0)                          ; $019508
        bsr.w        MoveActorWithWallMargin32                     ; $01950C

loc_019510:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019510
        beq.b        loc_01952A                                    ; $019516
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $019518
        beq.b        loc_01952A                                    ; $01951E
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019520
        beq.b        loc_01952A                                    ; $019526
        bra.b        loc_01952E                                    ; $019528

loc_01952A:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01952A

loc_01952E:
        movea.l      ActorTarget(a0), a3                           ; $01952E
        move.w       ActorX(a0), d0                                ; $019532
        sub.w        ActorX(a3), d0                                ; $019536
        move.w       ActorY(a0), d1                                ; $01953A
        sub.w        ActorY(a3), d1                                ; $01953E
        move.w       d0, d3                                        ; $019542
        move.w       d1, d4                                        ; $019544
        jsr          OctagonalDistance.l                           ; $019546
        cmpi.w       #$60, d0                                      ; $01954C
        bcs.b        loc_019556                                    ; $019550
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $019552

loc_019556:
        tst.b        ActorMarkerTracked(a0)                        ; $019556
        beq.b        loc_019566                                    ; $01955A
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01955C
        clr.b        ActorMarkerTracked(a0)                        ; $019562

loc_019566:
        cmpi.b       #$3, ActorState(a0)                           ; $019566
        bne.b        loc_0195E8                                    ; $01956C
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01956E
        bne.b        loc_0195BC                                    ; $019574
        jsr          NextRandom.l                                  ; $019576
        asr.w        #$8, d2                                       ; $01957C
        andi.w       #$1, d2                                       ; $01957E
        addq.w       #$2, d2                                       ; $019582
        lsl.w        #$8, d2                                       ; $019584
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $019586
        move.w       #$c, d0                                       ; $01958A
        move.l       a0, -(a7)                                     ; $01958E
        jsr          GrantInventoryItem(pc)                          ; $019590
        movea.l      (a7)+, a0                                     ; $019594
        clr.w        rItemGrantAmountOverride(a6)                                    ; $019596
        cmpi.w       #$ffff, d7                                    ; $01959A
        beq.b        loc_0195E8                                    ; $01959E
        move.b       #$4, ActorState(a0)                           ; $0195A0
        move.w       #$60, d0                                      ; $0195A6
        jsr          RouteSoundEventByActorFloor.l                         ; $0195AA
        movea.l      #StatusMessageBuligunCollected, a0            ; $0195B0
        jmp          QueueStatusMessage.l                          ; $0195B6

loc_0195BC:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $0195BC
        move.b       #$4, ActorState(a0)                           ; $0195C0
        move.b       #$13, (a1)+                                   ; $0195C6
        move.b       #$8, (a1)+                                    ; $0195CA
        jsr          NextRandom.l                                  ; $0195CE
        asr.w        #$8, d2                                       ; $0195D4
        andi.w       #$1, d2                                       ; $0195D6
        addq.w       #$2, d2                                       ; $0195DA
        move.b       d2, (a1)+                                     ; $0195DC
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0195DE
        jmp          QueueLinkCommand.l                            ; $0195E2

loc_0195E8:
        rts                                                        ; $0195E8
        ifne *-$195EA
        fail "ROM end moved"
        endif
