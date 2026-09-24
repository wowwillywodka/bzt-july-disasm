; $015DA4..$015EC3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit modifies recoil and increments StateCounter, but not Health. The following goal helpers are separate branch destinations used by multiple enemy types.
        ifne *-$15DA4
        fail "ROM start moved"
        endif

HitBloodBodyCorpse:
; Corpse hit modifies recoil and increments StateCounter, but not Health. The following goal helpers are separate branch destinations used by multiple enemy types.
        clr.w        ActorMotionX(a0)                              ; $015DA4
        clr.w        ActorMotionY(a0)                              ; $015DA8
        neg.w        d3                                            ; $015DAC
        neg.w        d4                                            ; $015DAE
        move.w       d0, -(a7)                                     ; $015DB0
        move.w       d3, d0                                        ; $015DB2
        move.w       d4, d1                                        ; $015DB4
        jsr          OctagonalDistance(pc)                         ; $015DB6
        ext.l        d3                                            ; $015DBA
        ext.l        d4                                            ; $015DBC
        lsl.l        #$8, d3                                       ; $015DBE
        lsl.l        #$8, d4                                       ; $015DC0
        addq.w       #$1, d0                                       ; $015DC2
        beq.b        loc_015DCA                                    ; $015DC4
        divs.w       d0, d3                                        ; $015DC6
        divs.w       d0, d4                                        ; $015DC8

loc_015DCA:
        move.w       #$400, d0                                     ; $015DCA
        sub.w        (a7)+, d0                                     ; $015DCE
        bmi.b        loc_015DE8                                    ; $015DD0
        asr.w        #$4, d0                                       ; $015DD2
        muls.w       d0, d3                                        ; $015DD4
        muls.w       d0, d4                                        ; $015DD6
        asr.l        #$8, d3                                       ; $015DD8
        asr.l        #$8, d4                                       ; $015DDA
        move.w       d3, ActorMotionX(a0)                          ; $015DDC
        move.w       d4, ActorMotionY(a0)                          ; $015DE0
        addq.b       #$1, ActorStateCounter(a0)                    ; $015DE4

loc_015DE8:
        rts                                                        ; $015DE8

ChooseTargetGoalAtPlayerAnglePlusA8:
; Shared movement goal: target XY + AngleVectorPairs[(player_angle+$A8)&$1FF]. RNG output is overwritten; the RNG call still advances global state.
        move.b       #$0, ActorState(a0)                           ; $015DEA
        jsr          NextRandom.l                                  ; $015DF0
        asr.l        #$4, d2                                       ; $015DF6
        move.w       d2, d0                                        ; $015DF8
        andi.w       #$1ff, d0                                     ; $015DFA
        subi.w       #$100, d0                                     ; $015DFE
        lea.l        AngleVectorPairs.w, a4                        ; $015E02
        move.w       rPlayerFacingAngle(a6), d0                                ; $015E06
        addi.w       #$a8, d0                                      ; $015E0A
        andi.w       #$1ff, d0                                     ; $015E0E
        lsl.w        #$2, d0                                       ; $015E12
        move.w       $2(a4, d0.w), d1                              ; $015E14
        move.w       (a4, d0.w), d0                                ; $015E18
        add.w        ActorX(a3), d0                                ; $015E1C
        move.w       d0, ActorGoalX(a0)                            ; $015E20
        andi.w       #$1ff, d0                                     ; $015E24
        subi.w       #$100, d0                                     ; $015E28
        clr.w        d0                                            ; $015E2C
        move.w       d1, d0                                        ; $015E2E
        add.w        ActorY(a3), d0                                ; $015E30
        move.w       d0, ActorGoalY(a0)                            ; $015E34
        rts                                                        ; $015E38

ChooseTargetGoalAtPlayerAnglePlus158:
; Shared movement goal: target XY + AngleVectorPairs[(player_angle+$158)&$1FF]. Uses global player angle even if A3 is a remote target.
        move.b       #$0, ActorState(a0)                           ; $015E3A
        jsr          NextRandom.l                                  ; $015E40
        asr.l        #$4, d2                                       ; $015E46
        move.w       d2, d0                                        ; $015E48
        andi.w       #$1ff, d0                                     ; $015E4A
        subi.w       #$100, d0                                     ; $015E4E
        lea.l        AngleVectorPairs.w, a4                        ; $015E52
        move.w       rPlayerFacingAngle(a6), d0                                ; $015E56
        addi.w       #$158, d0                                     ; $015E5A
        andi.w       #$1ff, d0                                     ; $015E5E
        lsl.w        #$2, d0                                       ; $015E62
        move.w       $2(a4, d0.w), d1                              ; $015E64
        move.w       (a4, d0.w), d0                                ; $015E68
        add.w        ActorX(a3), d0                                ; $015E6C
        move.w       d0, ActorGoalX(a0)                            ; $015E70
        andi.w       #$1ff, d0                                     ; $015E74
        subi.w       #$100, d0                                     ; $015E78
        move.w       d1, d0                                        ; $015E7C
        add.w        ActorY(a3), d0                                ; $015E7E
        move.w       d0, ActorGoalY(a0)                            ; $015E82
        rts                                                        ; $015E86

ChoosePredictedTargetGoal:
; Shared movement goal = target XY + target MotionXY. NextRandom leaves D1.w=0; intervening random-offset calculations are overwritten.
        move.b       #$0, ActorState(a0)                           ; $015E88
        jsr          NextRandom.l                                  ; $015E8E
        asr.l        #$4, d2                                       ; $015E94
        move.w       d2, d0                                        ; $015E96
        andi.w       #$1ff, d0                                     ; $015E98
        subi.w       #$100, d0                                     ; $015E9C
        clr.w        d0                                            ; $015EA0
        add.w        ActorX(a3), d0                                ; $015EA2
        add.w        ActorMotionX(a3), d0                          ; $015EA6
        move.w       d0, ActorGoalX(a0)                            ; $015EAA
        swap         d2                                            ; $015EAE
        move.w       d2, d0                                        ; $015EB0
        clr.w        d0                                            ; $015EB2
        move.w       d1, d0                                        ; $015EB4
        add.w        ActorY(a3), d0                                ; $015EB6
        add.w        ActorMotionY(a3), d0                          ; $015EBA
        move.w       d0, ActorGoalY(a0)                            ; $015EBE
        rts                                                        ; $015EC2
        ifne *-$15EC4
        fail "ROM end moved"
        endif
