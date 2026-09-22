; $01B61C..$01B6AD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wander state9: if counter0 and target distance<$300, begin charge. Otherwise decrement nonzero counter and move at ASR3 clamp +/-20. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses random local goal.
        ifne *-$1B61C
        fail "ROM start moved"
        endif

MoveDenpyderWanderAndCheckTarget:
; Wander state9: if counter0 and target distance<$300, begin charge. Otherwise decrement nonzero counter and move at ASR3 clamp +/-20. Returned vector length<=10 (actual delta only if ActorMarkerTracked=0) chooses random local goal.
        tst.b        ActorStateCounter(a0)                         ; $01B61C
        bne.b        loc_01B646                                    ; $01B620
        movea.l      ActorTarget(a0), a3                           ; $01B622
        move.w       ActorX(a3), d0                                ; $01B626
        sub.w        ActorX(a0), d0                                ; $01B62A
        move.w       ActorY(a3), d1                                ; $01B62E
        sub.w        ActorY(a0), d1                                ; $01B632
        jsr          OctagonalDistance.l                           ; $01B636
        cmpi.w       #$300, d0                                     ; $01B63C
        bcs.w        BeginDenpyderCharge                           ; $01B640
        bra.b        loc_01B64A                                    ; $01B644

loc_01B646:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01B646

loc_01B64A:
        move.w       ActorGoalX(a0), d0                            ; $01B64A
        sub.w        ActorX(a0), d0                                ; $01B64E
        asr.w        #$3, d0                                       ; $01B652
        beq.b        loc_01B66E                                    ; $01B654
        bpl.b        loc_01B664                                    ; $01B656
        cmpi.w       #$ffec, d0                                    ; $01B658
        bge.b        loc_01B66E                                    ; $01B65C
        move.w       #$ffec, d0                                    ; $01B65E
        bra.b        loc_01B66E                                    ; $01B662

loc_01B664:
        cmpi.w       #$14, d0                                      ; $01B664
        ble.b        loc_01B66E                                    ; $01B668
        move.w       #$14, d0                                      ; $01B66A

loc_01B66E:
        move.w       ActorGoalY(a0), d1                            ; $01B66E
        sub.w        ActorY(a0), d1                                ; $01B672
        asr.w        #$3, d1                                       ; $01B676
        beq.b        loc_01B692                                    ; $01B678
        bpl.b        loc_01B688                                    ; $01B67A
        cmpi.w       #$ffec, d1                                    ; $01B67C
        bge.b        loc_01B692                                    ; $01B680
        move.w       #$ffec, d1                                    ; $01B682
        bra.b        loc_01B692                                    ; $01B686

loc_01B688:
        cmpi.w       #$14, d1                                      ; $01B688
        ble.b        loc_01B692                                    ; $01B68C
        move.w       #$14, d1                                      ; $01B68E

loc_01B692:
        move.w       d0, ActorMotionX(a0)                          ; $01B692
        move.w       d1, ActorMotionY(a0)                          ; $01B696
        bsr.w        MoveActorWithWallMargin64                     ; $01B69A
        jsr          OctagonalDistance.l                           ; $01B69E
        cmpi.w       #$a, d0                                       ; $01B6A4
        bls.b        ChooseDenpyderWanderGoalOrDie                 ; $01B6A8
        bra.w        RefreshEnemyTargetOrExit                      ; $01B6AA
        ifne *-$1B6AE
        fail "ROM end moved"
        endif
