; $016068..$0160C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; White Dummy callers $1A2B8/$1A306. Goal=targetXY+vector[(playerAngle+old GoalAngle)&511]; then angle advances $50 modulo512. RNG result overwritten. Not a rotating muzzle.
        ifne *-$16068
        fail "ROM start moved"
        endif

ChooseRotatingTargetGoal:
; White Dummy callers $1A2B8/$1A306. Goal=targetXY+vector[(playerAngle+old GoalAngle)&511]; then angle advances $50 modulo512. RNG result overwritten. Not a rotating muzzle.
        move.b       #$0, ActorState(a0)                           ; $016068
        jsr          NextRandom.l                                  ; $01606E
        asr.l        #$4, d2                                       ; $016074
        move.w       d2, d0                                        ; $016076
        andi.w       #$1ff, d0                                     ; $016078
        subi.w       #$100, d0                                     ; $01607C
        lea.l        AngleVectorPairs.w, a4                        ; $016080
        move.w       -$71ee(a6), d0                                ; $016084
        add.w        ActorGoalAngle(a0), d0                        ; $016088
        addi.w       #$50, ActorGoalAngle(a0)                      ; $01608C
        andi.w       #$1ff, ActorGoalAngle(a0)                     ; $016092
        andi.w       #$1ff, d0                                     ; $016098
        lsl.w        #$2, d0                                       ; $01609C
        move.w       $2(a4, d0.w), d1                              ; $01609E
        move.w       (a4, d0.w), d0                                ; $0160A2
        add.w        ActorX(a3), d0                                ; $0160A6
        move.w       d0, ActorGoalX(a0)                            ; $0160AA
        andi.w       #$1ff, d0                                     ; $0160AE
        subi.w       #$100, d0                                     ; $0160B2
        clr.w        d0                                            ; $0160B6
        move.w       d1, d0                                        ; $0160B8
        add.w        ActorY(a3), d0                                ; $0160BA
        move.w       d0, ActorGoalY(a0)                            ; $0160BE
        rts                                                        ; $0160C2
        ifne *-$160C4
        fail "ROM end moved"
        endif
