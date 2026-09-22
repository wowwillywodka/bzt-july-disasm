; $018520..$0185A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Default including initial state0 and charge8: decrement counter, refresh target goal every remaining multiple4, ASR1 clamp72. Counter0 or returned vector length<=10 (actual delta only if ActorMarkerTracked=0) finishes. Initial SavedXY not set here.
        ifne *-$18520
        fail "ROM start moved"
        endif

MoveDogCharge:
; Default including initial state0 and charge8: decrement counter, refresh target goal every remaining multiple4, ASR1 clamp72. Counter0 or returned vector length<=10 (actual delta only if ActorMarkerTracked=0) finishes. Initial SavedXY not set here.
        subq.b       #$1, ActorStateCounter(a0)                    ; $018520
        beq.b        FinishDogChargeAndTryHit                      ; $018524
        move.b       ActorStateCounter(a0), d0                     ; $018526
        andi.w       #$3, d0                                       ; $01852A
        bne.b        loc_018540                                    ; $01852E
        movea.l      ActorTarget(a0), a3                           ; $018530
        move.w       ActorX(a3), ActorGoalX(a0)                    ; $018534
        move.w       ActorY(a3), ActorGoalY(a0)                    ; $01853A

loc_018540:
        move.w       ActorGoalX(a0), d0                            ; $018540
        sub.w        ActorX(a0), d0                                ; $018544
        asr.w        #$1, d0                                       ; $018548
        beq.b        loc_018564                                    ; $01854A
        bpl.b        loc_01855A                                    ; $01854C
        cmpi.w       #$ffb8, d0                                    ; $01854E
        bge.b        loc_018564                                    ; $018552
        move.w       #$ffb8, d0                                    ; $018554
        bra.b        loc_018564                                    ; $018558

loc_01855A:
        cmpi.w       #$48, d0                                      ; $01855A
        ble.b        loc_018564                                    ; $01855E
        move.w       #$48, d0                                      ; $018560

loc_018564:
        move.w       ActorGoalY(a0), d1                            ; $018564
        sub.w        ActorY(a0), d1                                ; $018568
        asr.w        #$1, d1                                       ; $01856C
        beq.b        loc_018588                                    ; $01856E
        bpl.b        loc_01857E                                    ; $018570
        cmpi.w       #$ffb8, d1                                    ; $018572
        bge.b        loc_018588                                    ; $018576
        move.w       #$ffb8, d1                                    ; $018578
        bra.b        loc_018588                                    ; $01857C

loc_01857E:
        cmpi.w       #$48, d1                                      ; $01857E
        ble.b        loc_018588                                    ; $018582
        move.w       #$48, d1                                      ; $018584

loc_018588:
        move.w       d0, ActorMotionX(a0)                          ; $018588
        move.w       d1, ActorMotionY(a0)                          ; $01858C
        bsr.w        MoveActorWithWallMargin64                     ; $018590
        jsr          OctagonalDistance.l                           ; $018594
        cmpi.w       #$a, d0                                       ; $01859A
        bls.b        FinishDogChargeAndTryHit                      ; $01859E
        bra.w        RefreshEnemyTargetOrExit                      ; $0185A0
        ifne *-$185A4
        fail "ROM end moved"
        endif
