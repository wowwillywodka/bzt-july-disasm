; $0198CC..$019981 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Clamp +/-30 after ASR3. State1 skips collision. Returned dx+dy (actual delta only if ActorMarkerTracked=0)==0 reselects (opposite diagonal cancels); later both-axis ASR4 arrival outcomes all refresh target, never reselect.
        ifne *-$198CC
        fail "ROM start moved"
        endif

MoveBeatressTowardGoal:
; Clamp +/-30 after ASR3. State1 skips collision. Returned dx+dy (actual delta only if ActorMarkerTracked=0)==0 reselects (opposite diagonal cancels); later both-axis ASR4 arrival outcomes all refresh target, never reselect.
        clr.w        d2                                            ; $0198CC
        move.w       ActorGoalX(a0), d0                            ; $0198CE
        sub.w        ActorX(a0), d0                                ; $0198D2
        asr.w        #$3, d0                                       ; $0198D6
        tst.w        d0                                            ; $0198D8
        beq.b        loc_0198F4                                    ; $0198DA
        bpl.b        loc_0198EA                                    ; $0198DC
        cmpi.w       #$ffe2, d0                                    ; $0198DE
        bge.b        loc_0198F4                                    ; $0198E2
        move.w       #$ffe2, d0                                    ; $0198E4
        bra.b        loc_0198F4                                    ; $0198E8

loc_0198EA:
        cmpi.w       #$1e, d0                                      ; $0198EA
        ble.b        loc_0198F4                                    ; $0198EE
        move.w       #$1e, d0                                      ; $0198F0

loc_0198F4:
        move.w       ActorGoalY(a0), d1                            ; $0198F4
        sub.w        ActorY(a0), d1                                ; $0198F8
        asr.w        #$3, d1                                       ; $0198FC
        tst.w        d1                                            ; $0198FE
        beq.b        loc_01991A                                    ; $019900
        bpl.b        loc_019910                                    ; $019902
        cmpi.w       #$ffe2, d1                                    ; $019904
        bge.b        loc_01991A                                    ; $019908
        move.w       #$ffe2, d1                                    ; $01990A
        bra.b        loc_01991A                                    ; $01990E

loc_019910:
        cmpi.w       #$1e, d1                                      ; $019910
        ble.b        loc_01991A                                    ; $019914
        move.w       #$1e, d1                                      ; $019916

loc_01991A:
        cmpi.b       #$1, ActorState(a0)                           ; $01991A
        beq.w        TickBeatressMeleeAttack                       ; $019920
        move.w       d0, ActorMotionX(a0)                          ; $019924
        move.w       d1, ActorMotionY(a0)                          ; $019928
        bsr.w        TrackBeatressPlayerAndCheckMelee              ; $01992C
        cmpi.b       #$1, ActorState(a0)                           ; $019930
        beq.w        loc_0199D4                                    ; $019936
        move.w       ActorMotionX(a0), d0                          ; $01993A
        move.w       ActorMotionY(a0), d1                          ; $01993E
        bsr.w        MoveActorWithWallMargin32                     ; $019942
        add.w        d0, d1                                        ; $019946
        beq.w        ChooseBeatressGoalOrDie                       ; $019948
        move.w       ActorGoalX(a0), d0                            ; $01994C
        sub.w        ActorX(a0), d0                                ; $019950
        asr.w        #$4, d0                                       ; $019954
        move.w       ActorGoalY(a0), d1                            ; $019956
        sub.w        ActorY(a0), d1                                ; $01995A
        asr.w        #$4, d1                                       ; $01995E
        tst.w        d0                                            ; $019960
        bpl.b        loc_019966                                    ; $019962
        neg.w        d0                                            ; $019964

loc_019966:
        cmpi.w       #$1e, d0                                      ; $019966
        bgt.w        RefreshEnemyTargetOrExit                      ; $01996A
        tst.w        d1                                            ; $01996E
        bpl.b        loc_019974                                    ; $019970
        neg.w        d1                                            ; $019972

loc_019974:
        cmpi.w       #$1e, d1                                      ; $019974
        bgt.w        RefreshEnemyTargetOrExit                      ; $019978
        jmp          RefreshEnemyTargetOrExit.l                    ; $01997C
        ifne *-$19982
        fail "ROM end moved"
        endif
