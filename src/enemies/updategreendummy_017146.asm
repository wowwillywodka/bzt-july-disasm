; $017146..$01737D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Green Dummy chases/contact-reduces local inventory; ordinary update never calls the adjacent retained ranged-attack body. See docs/GREY_GREEN_DUMMY.md.
        ifne *-$17146
        fail "ROM start moved"
        endif

UpdateGreenDummy:
; Green Dummy chases/contact-reduces local inventory; ordinary update never calls the adjacent retained ranged-attack body. See docs/GREY_GREEN_DUMMY.md.
        clr.b        ActorUpdateDelay(a0)                          ; $017146
        cmpi.b       #$cd, ActorState(a0)                          ; $01714A
        beq.w        InitializeGreenDummyMovement                  ; $017150
        cmpi.b       #$5, ActorState(a0)                           ; $017154
        beq.w        GreenDummyTickWeapon0DDeath                   ; $01715A
        cmpi.b       #$6, ActorState(a0)                           ; $01715E
        beq.w        GreenDummyTickWeapon0BDeath                   ; $017164
        cmpi.b       #$2, ActorState(a0)                           ; $017168
        bne.w        GreenDummyMoveAndCheckContact                 ; $01716E
        move.w       ActorMotionX(a0), d0                          ; $017172
        move.w       ActorMotionY(a0), d1                          ; $017176
        jsr          OctagonalDistance.l                           ; $01717A
        cmpi.w       #$5a, d0                                      ; $017180
        bcs.w        GreenDummyChooseNextGoalOrDie                 ; $017184
        move.w       ActorMotionX(a0), d0                          ; $017188
        move.w       ActorMotionY(a0), d1                          ; $01718C
        bsr.w        MoveActorWithWallMargin32                     ; $017190
        asr.w        ActorMotionX(a0)                              ; $017194
        asr.w        ActorMotionY(a0)                              ; $017198
        rts                                                        ; $01719C

InitializeGreenDummyMovement:
        move.b       #$0, ActorState(a0)                           ; $01719E
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $0171A4
        clr.b        ActorBehaviorByte50(a0)                       ; $0171AA
        rts                                                        ; $0171AE

GreenDummyChooseNextGoalOrDie:
        tst.w        ActorHealth(a0)                               ; $0171B0
        bmi.w        EnterGreenDummyDeath                          ; $0171B4
        movea.l      ActorTarget(a0), a3                           ; $0171B8
        jsr          NextRandom.l                                  ; $0171BC
        swap         d2                                            ; $0171C2
        andi.w       #$1f, d2                                      ; $0171C4
        move.w       d2, -(a7)                                     ; $0171C8
        move.w       ActorX(a0), d0                                ; $0171CA
        sub.w        ActorX(a3), d0                                ; $0171CE
        move.w       ActorY(a0), d1                                ; $0171D2
        sub.w        ActorY(a3), d1                                ; $0171D6
        jsr          OctagonalDistance.l                           ; $0171DA
        asr.w        #$6, d0                                       ; $0171E0
        add.w        (a7)+, d0                                     ; $0171E2
; Overwrites the random/distance delay with5. Flag0 selects target position; nonzero selects a new random offset then clears flag.
        moveq        #$5, d0                                       ; $0171E4
        move.b       d0, ActorStateCounter(a0)                     ; $0171E6
        tst.b        ActorBehaviorByte50(a0)                       ; $0171EA
        beq.b        GreenDummyChooseTargetPosition                ; $0171EE

GreenDummyChooseRandomOffsetGoal:
        move.b       #$0, ActorState(a0)                           ; $0171F0
        jsr          NextRandom.l                                  ; $0171F6
        asr.l        #$8, d2                                       ; $0171FC
        andi.w       #$1ff, d2                                     ; $0171FE
        clr.l        d0                                            ; $017202
        clr.l        d1                                            ; $017204
        lea.l        AngleVectorPairs.w, a4                        ; $017206
        move.w       rPlayerFacingAngle(a6), d0                                ; $01720A
        add.w        d2, d0                                        ; $01720E
        andi.w       #$1ff, d0                                     ; $017210
        lsl.w        #$2, d0                                       ; $017214
        move.w       $2(a4, d0.w), d1                              ; $017216
        move.w       (a4, d0.w), d0                                ; $01721A
        asl.w        #$2, d0                                       ; $01721E
        asl.w        #$2, d1                                       ; $017220
        add.w        ActorX(a3), d0                                ; $017222
        move.w       d0, ActorGoalX(a0)                            ; $017226
        move.w       d1, d0                                        ; $01722A
        add.w        ActorY(a3), d0                                ; $01722C
        move.w       d0, ActorGoalY(a0)                            ; $017230
        clr.b        ActorBehaviorByte50(a0)                       ; $017234
        rts                                                        ; $017238

GreenDummyChooseTargetPosition:
        move.b       #$0, ActorState(a0)                           ; $01723A
        move.w       ActorX(a3), d0                                ; $017240
        move.w       d0, ActorGoalX(a0)                            ; $017244
        move.w       ActorY(a3), d0                                ; $017248
        move.w       d0, ActorGoalY(a0)                            ; $01724C
        rts                                                        ; $017250

GreenDummyMoveAndCheckContact:
; The flag-dependent +/-25 calculation falls through to $172A8, which overwrites BOTH components with a +/-75 calculation. State1 also follows movement/contact, not ranged attack.
        tst.b        ActorBehaviorByte50(a0)                       ; $017252
        beq.w        GreenDummyComputeEffectiveMotion              ; $017256
        clr.w        d2                                            ; $01725A
        move.w       ActorGoalX(a0), d0                            ; $01725C
        sub.w        ActorX(a0), d0                                ; $017260
        asr.w        #$3, d0                                       ; $017264
        tst.w        d0                                            ; $017266
        beq.b        loc_017282                                    ; $017268
        bpl.b        loc_017278                                    ; $01726A
        cmpi.w       #$ffe7, d0                                    ; $01726C
        bge.b        loc_017282                                    ; $017270
        move.w       #$ffe7, d0                                    ; $017272
        bra.b        loc_017282                                    ; $017276

loc_017278:
        cmpi.w       #$19, d0                                      ; $017278
        ble.b        loc_017282                                    ; $01727C
        move.w       #$19, d0                                      ; $01727E

loc_017282:
        move.w       ActorGoalY(a0), d1                            ; $017282
        sub.w        ActorY(a0), d1                                ; $017286
        asr.w        #$3, d1                                       ; $01728A
        tst.w        d1                                            ; $01728C
        beq.b        GreenDummyComputeEffectiveMotion              ; $01728E
        bpl.b        loc_01729E                                    ; $017290
        cmpi.w       #$ffe7, d1                                    ; $017292
        bge.b        GreenDummyComputeEffectiveMotion              ; $017296
        move.w       #$ffe7, d1                                    ; $017298
        bra.b        GreenDummyComputeEffectiveMotion              ; $01729C

loc_01729E:
        cmpi.w       #$19, d1                                      ; $01729E
        ble.b        GreenDummyComputeEffectiveMotion              ; $0172A2
        move.w       #$19, d1                                      ; $0172A4

GreenDummyComputeEffectiveMotion:
        clr.w        d2                                            ; $0172A8
        move.w       ActorGoalX(a0), d0                            ; $0172AA
        sub.w        ActorX(a0), d0                                ; $0172AE
        asr.w        #$3, d0                                       ; $0172B2
        tst.w        d0                                            ; $0172B4
        beq.b        loc_0172D0                                    ; $0172B6
        bpl.b        loc_0172C6                                    ; $0172B8
        cmpi.w       #$ffb5, d0                                    ; $0172BA
        bge.b        loc_0172D0                                    ; $0172BE
        move.w       #$ffb5, d0                                    ; $0172C0
        bra.b        loc_0172D0                                    ; $0172C4

loc_0172C6:
        cmpi.w       #$4b, d0                                      ; $0172C6
        ble.b        loc_0172D0                                    ; $0172CA
        move.w       #$4b, d0                                      ; $0172CC

loc_0172D0:
        move.w       ActorGoalY(a0), d1                            ; $0172D0
        sub.w        ActorY(a0), d1                                ; $0172D4
        asr.w        #$3, d1                                       ; $0172D8
        tst.w        d1                                            ; $0172DA
        beq.b        loc_0172F6                                    ; $0172DC
        bpl.b        loc_0172EC                                    ; $0172DE
        cmpi.w       #$ffb5, d1                                    ; $0172E0
        bge.b        loc_0172F6                                    ; $0172E4
        move.w       #$ffb5, d1                                    ; $0172E6
        bra.b        loc_0172F6                                    ; $0172EA

loc_0172EC:
        cmpi.w       #$4b, d1                                      ; $0172EC
        ble.b        loc_0172F6                                    ; $0172F0
        move.w       #$4b, d1                                      ; $0172F2

loc_0172F6:
        move.w       d0, ActorMotionX(a0)                          ; $0172F6
        move.w       d1, ActorMotionY(a0)                          ; $0172FA
        bsr.w        MoveActorWithWallMargin32                     ; $0172FE
        movem.w      d0-d1, -(a7)                                  ; $017302
        movea.l      ActorTarget(a0), a3                           ; $017306
        move.w       ActorX(a0), d0                                ; $01730A
        sub.w        ActorX(a3), d0                                ; $01730E
        move.w       ActorY(a0), d1                                ; $017312
        sub.w        ActorY(a3), d1                                ; $017316
        jsr          OctagonalDistance.l                           ; $01731A
; Octagonal target distance <=$20 permits contact if Byte50==0. Helper always addresses local inventory even when ActorTarget differs.
        cmpi.w       #$20, d0                                      ; $017320
        bls.b        GreenDummyTryInventoryContact                 ; $017324
        bra.w        GreenDummyCheckMovementAndArrival             ; $017326

GreenDummyTryInventoryContact:
; Latch Byte50=FF before inventory reduction; clear only if D7.b!=0. Stable-inventory helper exits all return D7.w=0, including no item and quantity1.
        tst.b        ActorBehaviorByte50(a0)                       ; $01732A
        bne.b        GreenDummyCheckMovementAndArrival             ; $01732E
        st.b         ActorBehaviorByte50(a0)                       ; $017330
        bsr.w        ReduceRandomInventoryQuantity                 ; $017334
        tst.b        d7                                            ; $017338
        beq.b        GreenDummyCheckMovementAndArrival             ; $01733A
        clr.b        ActorBehaviorByte50(a0)                       ; $01733C

GreenDummyCheckMovementAndArrival:
; Returned dx+dy==0 reselects goal (actual delta only with ActorMarkerTracked=0; opposite diagonal cancels). Then arrival tests X twice; Y is not used. Both original behaviors preserved.
        movem.w      (a7)+, d0-d1                                  ; $017340
        add.w        d0, d1                                        ; $017344
        beq.w        GreenDummyChooseNextGoalOrDie                 ; $017346
        move.w       ActorGoalX(a0), d0                            ; $01734A
        sub.w        ActorX(a0), d0                                ; $01734E
        asr.w        #$3, d0                                       ; $017352
        move.w       ActorGoalX(a0), d1                            ; $017354
        sub.w        ActorX(a0), d1                                ; $017358
        asr.w        #$3, d1                                       ; $01735C
        tst.w        d0                                            ; $01735E
        bpl.b        loc_017364                                    ; $017360
        neg.w        d0                                            ; $017362

loc_017364:
        cmpi.w       #$19, d0                                      ; $017364
        bgt.w        RefreshEnemyTargetOrExit                      ; $017368
        tst.w        d1                                            ; $01736C
        bpl.b        loc_017372                                    ; $01736E
        neg.w        d1                                            ; $017370

loc_017372:
        cmpi.w       #$19, d1                                      ; $017372
        bgt.w        RefreshEnemyTargetOrExit                      ; $017376
        bra.w        GreenDummyChooseNextGoalOrDie                 ; $01737A
        ifne *-$1737E
        fail "ROM end moved"
        endif
