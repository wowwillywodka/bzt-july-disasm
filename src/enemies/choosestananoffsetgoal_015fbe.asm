; $015FBE..$01601B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Stanan goal: targetXY + vector[(globalPlayerAngle+savedAngle)&511] + (targetMotionXY ASR1). RNG called every time; only replaces savedAngle when zero. Saved zero is retried next call. Single reviewed direct caller: $16248.
        ifne *-$15FBE
        fail "ROM start moved"
        endif

ChooseStananOffsetGoal:
; Stanan goal: targetXY + vector[(globalPlayerAngle+savedAngle)&511] + (targetMotionXY ASR1). RNG called every time; only replaces savedAngle when zero. Saved zero is retried next call. Single reviewed direct caller: $16248.
        move.b       #$0, ActorState(a0)                           ; $015FBE
        jsr          NextRandom.l                                  ; $015FC4
        asr.l        #$8, d2                                       ; $015FCA
        andi.w       #$1ff, d2                                     ; $015FCC
        clr.l        d0                                            ; $015FD0
        clr.l        d1                                            ; $015FD2
        tst.w        ActorGoalAngle(a0)                            ; $015FD4
        bne.b        loc_015FDE                                    ; $015FD8
        move.w       d2, ActorGoalAngle(a0)                        ; $015FDA

loc_015FDE:
        lea.l        AngleVectorPairs.w, a4                        ; $015FDE
        move.w       rPlayerFacingAngle(a6), d0                                ; $015FE2
        add.w        ActorGoalAngle(a0), d0                        ; $015FE6
        andi.w       #$1ff, d0                                     ; $015FEA
        lsl.w        #$2, d0                                       ; $015FEE
        move.w       $2(a4, d0.w), d1                              ; $015FF0
        move.w       (a4, d0.w), d0                                ; $015FF4
        add.w        ActorX(a3), d0                                ; $015FF8
        move.w       ActorMotionX(a3), d2                          ; $015FFC
        asr.w        #$1, d2                                       ; $016000
        add.w        d2, d0                                        ; $016002
        move.w       d0, ActorGoalX(a0)                            ; $016004
        move.w       d1, d0                                        ; $016008
        add.w        ActorY(a3), d0                                ; $01600A
        move.w       ActorMotionY(a3), d2                          ; $01600E
        asr.w        #$1, d2                                       ; $016012
        add.w        d2, d0                                        ; $016014
        move.w       d0, ActorGoalY(a0)                            ; $016016
        rts                                                        ; $01601A
        ifne *-$1601C
        fail "ROM end moved"
        endif
