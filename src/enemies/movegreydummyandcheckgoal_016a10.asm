; $016A10..$016AE1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Component clamp +/-25; attack state skips collision. Moving state ticks attack first; entering attack10 immediately ticks9.
        ifne *-$16A10
        fail "ROM start moved"
        endif

MoveGreyDummyAndCheckGoal:
; Component clamp +/-25; attack state skips collision. Moving state ticks attack first; entering attack10 immediately ticks9.
        clr.w        d2                                            ; $016A10
        move.w       ActorGoalX(a0), d0                            ; $016A12
        sub.w        ActorX(a0), d0                                ; $016A16
        asr.w        #$3, d0                                       ; $016A1A
        tst.w        d0                                            ; $016A1C
        beq.b        loc_016A38                                    ; $016A1E
        bpl.b        loc_016A2E                                    ; $016A20
        cmpi.w       #$ffe7, d0                                    ; $016A22
        bge.b        loc_016A38                                    ; $016A26
        move.w       #$ffe7, d0                                    ; $016A28
        bra.b        loc_016A38                                    ; $016A2C

loc_016A2E:
        cmpi.w       #$19, d0                                      ; $016A2E
        ble.b        loc_016A38                                    ; $016A32
        move.w       #$19, d0                                      ; $016A34

loc_016A38:
        move.w       ActorGoalY(a0), d1                            ; $016A38
        sub.w        ActorY(a0), d1                                ; $016A3C
        asr.w        #$3, d1                                       ; $016A40
        tst.w        d1                                            ; $016A42
        beq.b        loc_016A5E                                    ; $016A44
        bpl.b        loc_016A54                                    ; $016A46
        cmpi.w       #$ffe7, d1                                    ; $016A48
        bge.b        loc_016A5E                                    ; $016A4C
        move.w       #$ffe7, d1                                    ; $016A4E
        bra.b        loc_016A5E                                    ; $016A52

loc_016A54:
        cmpi.w       #$19, d1                                      ; $016A54
        ble.b        loc_016A5E                                    ; $016A58
        move.w       #$19, d1                                      ; $016A5A

loc_016A5E:
        cmpi.b       #$1, ActorState(a0)                           ; $016A5E
        beq.w        TickGreyDummyAttack                           ; $016A64
        move.w       d0, ActorMotionX(a0)                          ; $016A68
        move.w       d1, ActorMotionY(a0)                          ; $016A6C
        bsr.w        TickGreyDummyAttack                           ; $016A70
        cmpi.b       #$1, ActorState(a0)                           ; $016A74
        beq.w        GreyDummyTickAttackCounter                    ; $016A7A
        move.w       ActorMotionX(a0), d0                          ; $016A7E
        move.w       ActorMotionY(a0), d1                          ; $016A82
        bsr.w        MoveActorWithWallMargin32                     ; $016A86
        tst.w        d0                                            ; $016A8A
        bpl.b        loc_016A90                                    ; $016A8C
        neg.w        d0                                            ; $016A8E

loc_016A90:
        tst.w        d1                                            ; $016A90
        bpl.b        loc_016A96                                    ; $016A92
        neg.w        d1                                            ; $016A94

loc_016A96:
; Reselect goal if BOTH absolute collision-return components are <25. Otherwise arrival checks both GoalX-X and GoalY-Y. No diagonal-sum cancellation here.
        cmpi.w       #$19, d0                                      ; $016A96
        bge.b        loc_016AAE                                    ; $016A9A
        cmpi.w       #$19, d1                                      ; $016A9C
        bge.b        loc_016AAE                                    ; $016AA0
        clr.w        ActorMotionX(a0)                              ; $016AA2
        clr.w        ActorMotionY(a0)                              ; $016AA6
        bra.w        GreyDummyChooseNextGoalOrDie                  ; $016AAA

loc_016AAE:
        move.w       ActorGoalX(a0), d0                            ; $016AAE
        sub.w        ActorX(a0), d0                                ; $016AB2
        asr.w        #$3, d0                                       ; $016AB6
        move.w       ActorGoalY(a0), d1                            ; $016AB8
        sub.w        ActorY(a0), d1                                ; $016ABC
        asr.w        #$3, d1                                       ; $016AC0
        tst.w        d0                                            ; $016AC2
        bpl.b        loc_016AC8                                    ; $016AC4
        neg.w        d0                                            ; $016AC6

loc_016AC8:
        cmpi.w       #$19, d0                                      ; $016AC8
        bgt.w        RefreshEnemyTargetOrExit                      ; $016ACC
        tst.w        d1                                            ; $016AD0
        bpl.b        loc_016AD6                                    ; $016AD2
        neg.w        d1                                            ; $016AD4

loc_016AD6:
        cmpi.w       #$19, d1                                      ; $016AD6
        bgt.w        RefreshEnemyTargetOrExit                      ; $016ADA
        bra.w        GreyDummyChooseNextGoalOrDie                  ; $016ADE
        ifne *-$16AE2
        fail "ROM end moved"
        endif
