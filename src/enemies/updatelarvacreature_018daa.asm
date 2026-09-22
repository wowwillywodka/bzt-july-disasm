; $018DAA..$018E0B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Larva Creature:1200 HP, full damage, movement25, separate projectile at attack counter5. No recoil death test in draw. See docs/LARVA_BLUE_DOG.md.
        ifne *-$18DAA
        fail "ROM start moved"
        endif

UpdateLarvaCreature:
; Larva Creature:1200 HP, full damage, movement25, separate projectile at attack counter5. No recoil death test in draw. See docs/LARVA_BLUE_DOG.md.
        clr.b        ActorUpdateDelay(a0)                          ; $018DAA
        cmpi.b       #$cd, ActorState(a0)                          ; $018DAE
        beq.w        InitializeLarvaCreatureOrDog                  ; $018DB4
        cmpi.b       #$5, ActorState(a0)                           ; $018DB8
        beq.w        LarvaCreatureTickWeaponDeath                  ; $018DBE
        cmpi.b       #$6, ActorState(a0)                           ; $018DC2
        beq.w        LarvaCreatureTickUnassignedStateSix           ; $018DC8
        cmpi.b       #$7, ActorState(a0)                           ; $018DCC
        beq.w        loc_0191B2                                    ; $018DD2
        cmpi.b       #$2, ActorState(a0)                           ; $018DD6
        bne.w        MoveLarvaCreatureAndTickAttack                ; $018DDC
        move.w       ActorMotionX(a0), d0                          ; $018DE0
        move.w       ActorMotionY(a0), d1                          ; $018DE4
        jsr          OctagonalDistance.l                           ; $018DE8
        cmpi.w       #$a, d0                                       ; $018DEE
        bcs.w        ChooseLarvaCreatureGoalOrDie                  ; $018DF2
        move.w       ActorMotionX(a0), d0                          ; $018DF6
        move.w       ActorMotionY(a0), d1                          ; $018DFA
        bsr.w        MoveActorWithWallMargin32                     ; $018DFE
        asr.w        ActorMotionX(a0)                              ; $018E02
        asr.w        ActorMotionY(a0)                              ; $018E06
        rts                                                        ; $018E0A
        ifne *-$18E0C
        fail "ROM end moved"
        endif
