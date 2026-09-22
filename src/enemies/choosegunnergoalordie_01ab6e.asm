; $01AB6E..$01ABBB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Signed HP<0 dies. Discarded distance calculation followed by RNG retry until (RNG>>16)&15 !=0; reload1..15, rotate half-radius goal, state0. Not an octant/facing selector.
        ifne *-$1AB6E
        fail "ROM start moved"
        endif

ChooseGunnerGoalOrDie:
; Signed HP<0 dies. Discarded distance calculation followed by RNG retry until (RNG>>16)&15 !=0; reload1..15, rotate half-radius goal, state0. Not an octant/facing selector.
        tst.w        ActorHealth(a0)                               ; $01AB6E
        bmi.w        EnterGunnerDeath                              ; $01AB72
        movea.l      ActorTarget(a0), a3                           ; $01AB76
        jsr          NextRandom.l                                  ; $01AB7A
        swap         d2                                            ; $01AB80
        andi.w       #$1f, d2                                      ; $01AB82
        move.w       d2, -(a7)                                     ; $01AB86
        move.w       ActorX(a0), d0                                ; $01AB88
        sub.w        ActorX(a3), d0                                ; $01AB8C
        move.w       ActorY(a0), d1                                ; $01AB90
        sub.w        ActorY(a3), d1                                ; $01AB94
        jsr          OctagonalDistance.l                           ; $01AB98
        asr.w        #$6, d0                                       ; $01AB9E
        add.w        (a7)+, d0                                     ; $01ABA0

GunnerChooseNonzeroMoveCounter:
        jsr          NextRandom.l                                  ; $01ABA2
        swap         d2                                            ; $01ABA8
        andi.w       #$f, d2                                       ; $01ABAA
        tst.w        d2                                            ; $01ABAE
        beq.b        GunnerChooseNonzeroMoveCounter                ; $01ABB0
        move.w       d2, d0                                        ; $01ABB2
        move.b       d0, ActorStateCounter(a0)                     ; $01ABB4
        bra.w        ChooseHalfRadiusRotatingTargetGoal            ; $01ABB8
        ifne *-$1ABBC
        fail "ROM end moved"
        endif
