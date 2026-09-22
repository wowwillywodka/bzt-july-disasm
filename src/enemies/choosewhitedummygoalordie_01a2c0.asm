; $01A2C0..$01A309 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Signed HP<0 dies. Computed distance/random delay discarded; reload counter=(next RNG>>16)&31, INCLUDING zero. Next movement decrement wraps zero to255. Then rotate goal, state0.
        ifne *-$1A2C0
        fail "ROM start moved"
        endif

ChooseWhiteDummyGoalOrDie:
; Signed HP<0 dies. Computed distance/random delay discarded; reload counter=(next RNG>>16)&31, INCLUDING zero. Next movement decrement wraps zero to255. Then rotate goal, state0.
        tst.w        ActorHealth(a0)                               ; $01A2C0
        bmi.w        EnterWhiteDummyDeath                          ; $01A2C4
        movea.l      ActorTarget(a0), a3                           ; $01A2C8
        jsr          NextRandom.l                                  ; $01A2CC
        swap         d2                                            ; $01A2D2
        andi.w       #$1f, d2                                      ; $01A2D4
        move.w       d2, -(a7)                                     ; $01A2D8
        move.w       ActorX(a0), d0                                ; $01A2DA
        sub.w        ActorX(a3), d0                                ; $01A2DE
        move.w       ActorY(a0), d1                                ; $01A2E2
        sub.w        ActorY(a3), d1                                ; $01A2E6
        jsr          OctagonalDistance.l                           ; $01A2EA
        asr.w        #$6, d0                                       ; $01A2F0
        add.w        (a7)+, d0                                     ; $01A2F2
        jsr          NextRandom.l                                  ; $01A2F4
        swap         d2                                            ; $01A2FA
        andi.w       #$1f, d2                                      ; $01A2FC
        move.w       d2, d0                                        ; $01A300
        move.b       d0, ActorStateCounter(a0)                     ; $01A302
        bra.w        ChooseRotatingTargetGoal                      ; $01A306
        ifne *-$1A30A
        fail "ROM end moved"
        endif
