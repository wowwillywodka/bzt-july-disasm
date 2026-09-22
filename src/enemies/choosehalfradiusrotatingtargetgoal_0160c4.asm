; $0160C4..$016123 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Gunner callers $1AB6A/$1ABB8. Same rotating movement goal, with both vector components ASR1. No projectile is created here.
        ifne *-$160C4
        fail "ROM start moved"
        endif

ChooseHalfRadiusRotatingTargetGoal:
; Gunner callers $1AB6A/$1ABB8. Same rotating movement goal, with both vector components ASR1. No projectile is created here.
        move.b       #$0, ActorState(a0)                           ; $0160C4
        jsr          NextRandom.l                                  ; $0160CA
        asr.l        #$4, d2                                       ; $0160D0
        move.w       d2, d0                                        ; $0160D2
        andi.w       #$1ff, d0                                     ; $0160D4
        subi.w       #$100, d0                                     ; $0160D8
        lea.l        AngleVectorPairs.w, a4                        ; $0160DC
        move.w       -$71ee(a6), d0                                ; $0160E0
        add.w        ActorGoalAngle(a0), d0                        ; $0160E4
        addi.w       #$50, ActorGoalAngle(a0)                      ; $0160E8
        andi.w       #$1ff, ActorGoalAngle(a0)                     ; $0160EE
        andi.w       #$1ff, d0                                     ; $0160F4
        lsl.w        #$2, d0                                       ; $0160F8
        move.w       $2(a4, d0.w), d1                              ; $0160FA
        move.w       (a4, d0.w), d0                                ; $0160FE
        asr.w        #$1, d0                                       ; $016102
        asr.w        #$1, d1                                       ; $016104
        add.w        ActorX(a3), d0                                ; $016106
        move.w       d0, ActorGoalX(a0)                            ; $01610A
        andi.w       #$1ff, d0                                     ; $01610E
        subi.w       #$100, d0                                     ; $016112
        clr.w        d0                                            ; $016116
        move.w       d1, d0                                        ; $016118
        add.w        ActorY(a3), d0                                ; $01611A
        move.w       d0, ActorGoalY(a0)                            ; $01611E
        rts                                                        ; $016122
        ifne *-$16124
        fail "ROM end moved"
        endif
