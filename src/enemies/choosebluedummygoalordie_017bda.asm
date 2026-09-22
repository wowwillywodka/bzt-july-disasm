; $017BDA..$017C23 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; HP<0 dies; otherwise load ActorTarget into A3, discard distance-based delay, take second RNG high-word&31 as counter, then shared goal helper consumes another RNG.
        ifne *-$17BDA
        fail "ROM start moved"
        endif

ChooseBlueDummyGoalOrDie:
; HP<0 dies; otherwise load ActorTarget into A3, discard distance-based delay, take second RNG high-word&31 as counter, then shared goal helper consumes another RNG.
        tst.w        ActorHealth(a0)                               ; $017BDA
        bmi.w        EnterBlueDummyDeath                           ; $017BDE
        movea.l      ActorTarget(a0), a3                           ; $017BE2
        jsr          NextRandom.l                                  ; $017BE6
        swap         d2                                            ; $017BEC
        andi.w       #$1f, d2                                      ; $017BEE
        move.w       d2, -(a7)                                     ; $017BF2
        move.w       ActorX(a0), d0                                ; $017BF4
        sub.w        ActorX(a3), d0                                ; $017BF8
        move.w       ActorY(a0), d1                                ; $017BFC
        sub.w        ActorY(a3), d1                                ; $017C00
        jsr          OctagonalDistance.l                           ; $017C04
        asr.w        #$6, d0                                       ; $017C0A
        add.w        (a7)+, d0                                     ; $017C0C
        jsr          NextRandom.l                                  ; $017C0E
        swap         d2                                            ; $017C14
        andi.w       #$1f, d2                                      ; $017C16
        move.w       d2, d0                                        ; $017C1A
        move.b       d0, ActorStateCounter(a0)                     ; $017C1C
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $017C20
        ifne *-$17C24
        fail "ROM end moved"
        endif
