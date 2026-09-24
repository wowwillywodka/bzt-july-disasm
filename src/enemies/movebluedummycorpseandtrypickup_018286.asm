; $018286..$018399 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Damped corpse motion; normal distance<$60/state3 grants local item0C amount2/3, BULIGUN message. Remote sends command13/item08. Special C8/C9/CE bypass pickup.
        ifne *-$18286
        fail "ROM start moved"
        endif

MoveBlueDummyCorpseAndTryPickup:
; Damped corpse motion; normal distance<$60/state3 grants local item0C amount2/3, BULIGUN message. Remote sends command13/item08. Special C8/C9/CE bypass pickup.
        move.w       ActorMotionX(a0), d0                          ; $018286
        bmi.b        loc_018290                                    ; $01828A
        asr.w        #$1, d0                                       ; $01828C
        bra.b        loc_018296                                    ; $01828E

loc_018290:
        neg.w        d0                                            ; $018290
        asr.w        #$1, d0                                       ; $018292
        neg.w        d0                                            ; $018294

loc_018296:
        move.w       d0, ActorMotionX(a0)                          ; $018296
        move.w       ActorMotionY(a0), d1                          ; $01829A
        bmi.b        loc_0182A4                                    ; $01829E
        asr.w        #$1, d1                                       ; $0182A0
        bra.b        loc_0182AA                                    ; $0182A2

loc_0182A4:
        neg.w        d1                                            ; $0182A4
        asr.w        #$1, d1                                       ; $0182A6
        neg.w        d1                                            ; $0182A8

loc_0182AA:
        move.w       d1, ActorMotionY(a0)                          ; $0182AA
        move.w       d0, d2                                        ; $0182AE
        or.w         d1, d2                                        ; $0182B0
        beq.b        loc_0182C0                                    ; $0182B2
        move.w       d0, ActorMotionX(a0)                          ; $0182B4
        move.w       d1, ActorMotionY(a0)                          ; $0182B8
        bsr.w        MoveActorWithWallMargin32                     ; $0182BC

loc_0182C0:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $0182C0
        beq.b        loc_0182DA                                    ; $0182C6
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $0182C8
        beq.b        loc_0182DA                                    ; $0182CE
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0182D0
        beq.b        loc_0182DA                                    ; $0182D6
        bra.b        loc_0182DE                                    ; $0182D8

loc_0182DA:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $0182DA

loc_0182DE:
        movea.l      ActorTarget(a0), a3                           ; $0182DE
        move.w       ActorX(a0), d0                                ; $0182E2
        sub.w        ActorX(a3), d0                                ; $0182E6
        move.w       ActorY(a0), d1                                ; $0182EA
        sub.w        ActorY(a3), d1                                ; $0182EE
        move.w       d0, d3                                        ; $0182F2
        move.w       d1, d4                                        ; $0182F4
        jsr          OctagonalDistance.l                           ; $0182F6
        cmpi.w       #$60, d0                                      ; $0182FC
        bcs.b        loc_018306                                    ; $018300
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $018302

loc_018306:
        tst.b        ActorMarkerTracked(a0)                        ; $018306
        beq.b        loc_018316                                    ; $01830A
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01830C
        clr.b        ActorMarkerTracked(a0)                        ; $018312

loc_018316:
        cmpi.b       #$3, ActorState(a0)                           ; $018316
        bne.b        loc_018398                                    ; $01831C
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01831E
        bne.b        loc_01836C                                    ; $018324
        jsr          NextRandom.l                                  ; $018326
        asr.w        #$8, d2                                       ; $01832C
        andi.w       #$1, d2                                       ; $01832E
        addq.w       #$2, d2                                       ; $018332
        lsl.w        #$8, d2                                       ; $018334
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $018336
        move.w       #$c, d0                                       ; $01833A
        move.l       a0, -(a7)                                     ; $01833E
        jsr          GrantInventoryItem(pc)                          ; $018340
        movea.l      (a7)+, a0                                     ; $018344
        clr.w        rItemGrantAmountOverride(a6)                                    ; $018346
        cmpi.w       #$ffff, d7                                    ; $01834A
        beq.b        loc_018398                                    ; $01834E
        move.b       #$4, ActorState(a0)                           ; $018350
        move.w       #$60, d0                                      ; $018356
        jsr          RouteSoundEventByActorFloor.l                         ; $01835A
        movea.l      #StatusMessageBuligunCollected, a0            ; $018360
        jmp          QueueStatusMessage.l                          ; $018366

loc_01836C:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01836C
        move.b       #$4, ActorState(a0)                           ; $018370
        move.b       #$13, (a1)+                                   ; $018376
        move.b       #$8, (a1)+                                    ; $01837A
        jsr          NextRandom.l                                  ; $01837E
        asr.w        #$8, d2                                       ; $018384
        andi.w       #$1, d2                                       ; $018386
        addq.w       #$2, d2                                       ; $01838A
        move.b       d2, (a1)+                                     ; $01838C
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01838E
        jmp          QueueLinkCommand.l                            ; $018392

loc_018398:
        rts                                                        ; $018398
        ifne *-$1839A
        fail "ROM end moved"
        endif
