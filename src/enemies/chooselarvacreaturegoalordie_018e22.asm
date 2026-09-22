; $018E22..$018E5F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; HP<0 dies. Load ActorTarget, consume RNG/distance calculation but overwrite delay with40; goal helper consumes another RNG.
        ifne *-$18E22
        fail "ROM start moved"
        endif

ChooseLarvaCreatureGoalOrDie:
; HP<0 dies. Load ActorTarget, consume RNG/distance calculation but overwrite delay with40; goal helper consumes another RNG.
        tst.w        ActorHealth(a0)                               ; $018E22
        bmi.w        EnterLarvaCreatureDeath                       ; $018E26
        movea.l      ActorTarget(a0), a3                           ; $018E2A
        jsr          NextRandom.l                                  ; $018E2E
        swap         d2                                            ; $018E34
        andi.w       #$1f, d2                                      ; $018E36
        move.w       d2, -(a7)                                     ; $018E3A
        move.w       ActorX(a0), d0                                ; $018E3C
        sub.w        ActorX(a3), d0                                ; $018E40
        move.w       ActorY(a0), d1                                ; $018E44
        sub.w        ActorY(a3), d1                                ; $018E48
        jsr          OctagonalDistance.l                           ; $018E4C
        asr.w        #$6, d0                                       ; $018E52
        add.w        (a7)+, d0                                     ; $018E54
        moveq        #$28, d0                                      ; $018E56
        move.b       d0, ActorStateCounter(a0)                     ; $018E58
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $018E5C
        ifne *-$18E60
        fail "ROM end moved"
        endif
