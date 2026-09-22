; $0186BC..$01874D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wander7: only entry counter0 and target distance<$300 starts charge8; else decrement nonzero counter, ASR3 clamp20, returned vector length<=10 (actual delta only if ActorMarkerTracked=0) selects new random goal.
        ifne *-$186BC
        fail "ROM start moved"
        endif

MoveDogWanderAndCheckTarget:
; Wander7: only entry counter0 and target distance<$300 starts charge8; else decrement nonzero counter, ASR3 clamp20, returned vector length<=10 (actual delta only if ActorMarkerTracked=0) selects new random goal.
        tst.b        ActorStateCounter(a0)                         ; $0186BC
        bne.b        loc_0186E6                                    ; $0186C0
        movea.l      ActorTarget(a0), a3                           ; $0186C2
        move.w       ActorX(a3), d0                                ; $0186C6
        sub.w        ActorX(a0), d0                                ; $0186CA
        move.w       ActorY(a3), d1                                ; $0186CE
        sub.w        ActorY(a0), d1                                ; $0186D2
        jsr          OctagonalDistance.l                           ; $0186D6
        cmpi.w       #$300, d0                                     ; $0186DC
        bcs.w        BeginDogCharge                                ; $0186E0
        bra.b        loc_0186EA                                    ; $0186E4

loc_0186E6:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0186E6

loc_0186EA:
        move.w       ActorGoalX(a0), d0                            ; $0186EA
        sub.w        ActorX(a0), d0                                ; $0186EE
        asr.w        #$3, d0                                       ; $0186F2
        beq.b        loc_01870E                                    ; $0186F4
        bpl.b        loc_018704                                    ; $0186F6
        cmpi.w       #$ffec, d0                                    ; $0186F8
        bge.b        loc_01870E                                    ; $0186FC
        move.w       #$ffec, d0                                    ; $0186FE
        bra.b        loc_01870E                                    ; $018702

loc_018704:
        cmpi.w       #$14, d0                                      ; $018704
        ble.b        loc_01870E                                    ; $018708
        move.w       #$14, d0                                      ; $01870A

loc_01870E:
        move.w       ActorGoalY(a0), d1                            ; $01870E
        sub.w        ActorY(a0), d1                                ; $018712
        asr.w        #$3, d1                                       ; $018716
        beq.b        loc_018732                                    ; $018718
        bpl.b        loc_018728                                    ; $01871A
        cmpi.w       #$ffec, d1                                    ; $01871C
        bge.b        loc_018732                                    ; $018720
        move.w       #$ffec, d1                                    ; $018722
        bra.b        loc_018732                                    ; $018726

loc_018728:
        cmpi.w       #$14, d1                                      ; $018728
        ble.b        loc_018732                                    ; $01872C
        move.w       #$14, d1                                      ; $01872E

loc_018732:
        move.w       d0, ActorMotionX(a0)                          ; $018732
        move.w       d1, ActorMotionY(a0)                          ; $018736
        bsr.w        MoveActorWithWallMargin64                     ; $01873A
        jsr          OctagonalDistance.l                           ; $01873E
        cmpi.w       #$a, d0                                       ; $018744
        bls.b        ChooseDogWanderGoalOrDie                      ; $018748
        bra.w        RefreshEnemyTargetOrExit                      ; $01874A
        ifne *-$1874E
        fail "ROM end moved"
        endif
