; $01624E..$0162F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Component speed clamp +/-25. Attack state branches before MotionXY stores and collision. Moving state advances attack counter before collision; transition to attack immediately ticks 10 to 9.
        ifne *-$1624E
        fail "ROM start moved"
        endif

MoveStananAndCheckGoal:
; Component speed clamp +/-25. Attack state branches before MotionXY stores and collision. Moving state advances attack counter before collision; transition to attack immediately ticks 10 to 9.
        clr.w        d2                                            ; $01624E
        move.w       ActorGoalX(a0), d0                            ; $016250
        sub.w        ActorX(a0), d0                                ; $016254
        asr.w        #$3, d0                                       ; $016258
        tst.w        d0                                            ; $01625A
        beq.b        loc_016276                                    ; $01625C
        bpl.b        loc_01626C                                    ; $01625E
        cmpi.w       #$ffe7, d0                                    ; $016260
        bge.b        loc_016276                                    ; $016264
        move.w       #$ffe7, d0                                    ; $016266
        bra.b        loc_016276                                    ; $01626A

loc_01626C:
        cmpi.w       #$19, d0                                      ; $01626C
        ble.b        loc_016276                                    ; $016270
        move.w       #$19, d0                                      ; $016272

loc_016276:
        move.w       ActorGoalY(a0), d1                            ; $016276
        sub.w        ActorY(a0), d1                                ; $01627A
        asr.w        #$3, d1                                       ; $01627E
        tst.w        d1                                            ; $016280
        beq.b        loc_01629C                                    ; $016282
        bpl.b        loc_016292                                    ; $016284
        cmpi.w       #$ffe7, d1                                    ; $016286
        bge.b        loc_01629C                                    ; $01628A
        move.w       #$ffe7, d1                                    ; $01628C
        bra.b        loc_01629C                                    ; $016290

loc_016292:
        cmpi.w       #$19, d1                                      ; $016292
        ble.b        loc_01629C                                    ; $016296
        move.w       #$19, d1                                      ; $016298

loc_01629C:
        cmpi.b       #$1, ActorState(a0)                           ; $01629C
        beq.w        TickStananAttack                              ; $0162A2
        move.w       d0, ActorMotionX(a0)                          ; $0162A6
        move.w       d1, ActorMotionY(a0)                          ; $0162AA
        bsr.w        TickStananAttack                              ; $0162AE
        cmpi.b       #$1, ActorState(a0)                           ; $0162B2
        beq.w        StananTickAttackCounter                       ; $0162B8
        bsr.w        MoveActorWithWallMargin32                     ; $0162BC
; Checks returned dx+dy, not components independently. Actual delta only when ActorMarkerTracked=0; tracked tail overwrites it. Opposite actual components can cancel.
        add.w        d0, d1                                        ; $0162C0
        beq.w        StananChooseNextGoalOrDie                     ; $0162C2
        move.w       ActorGoalX(a0), d0                            ; $0162C6
        sub.w        ActorX(a0), d0                                ; $0162CA
        asr.w        #$3, d0                                       ; $0162CE
; Original bug: repeats GoalX-X for D1 instead of GoalY-Y. Arrival test effectively checks only abs((GoalX-X) ASR 3)<=25.
        move.w       ActorGoalX(a0), d1                            ; $0162D0
        sub.w        ActorX(a0), d1                                ; $0162D4
        asr.w        #$3, d1                                       ; $0162D8
        tst.w        d0                                            ; $0162DA
        bpl.b        loc_0162E0                                    ; $0162DC
        neg.w        d0                                            ; $0162DE

loc_0162E0:
        cmpi.w       #$19, d0                                      ; $0162E0
        bgt.w        RefreshEnemyTargetOrExit                      ; $0162E4
        tst.w        d1                                            ; $0162E8
        bpl.b        loc_0162EE                                    ; $0162EA
        neg.w        d1                                            ; $0162EC

loc_0162EE:
        cmpi.w       #$19, d1                                      ; $0162EE
        bgt.w        RefreshEnemyTargetOrExit                      ; $0162F2
        bra.w        StananChooseNextGoalOrDie                     ; $0162F6
        ifne *-$162FA
        fail "ROM end moved"
        endif
