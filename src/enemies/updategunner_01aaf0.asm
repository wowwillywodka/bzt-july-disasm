; $01AAF0..$01AB6D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Gunner: 6000 initial HP, half incoming damage, +/-40 movement, stationary direct shooting. Ordinary corpse drawing arms a20-update scene-exit delay. See docs/GUNNER_WHITE_DUMMY.md.
        ifne *-$1AAF0
        fail "ROM start moved"
        endif

UpdateGunner:
; Gunner: 6000 initial HP, half incoming damage, +/-40 movement, stationary direct shooting. Ordinary corpse drawing arms a20-update scene-exit delay. See docs/GUNNER_WHITE_DUMMY.md.
        clr.b        ActorUpdateDelay(a0)                          ; $01AAF0
        cmpi.b       #$cd, ActorState(a0)                          ; $01AAF4
        beq.w        InitializeGunnerMovement                      ; $01AAFA
        cmpi.b       #$5, ActorState(a0)                           ; $01AAFE
        beq.w        GunnerTickWeaponDeath                         ; $01AB04
        cmpi.b       #$6, ActorState(a0)                           ; $01AB08
        beq.w        GunnerTickUnassignedStateSix                  ; $01AB0E
        cmpi.b       #$2, ActorState(a0)                           ; $01AB12
        bne.w        MoveGunnerTowardGoal                          ; $01AB18
        move.w       ActorMotionX(a0), d0                          ; $01AB1C
        move.w       ActorMotionY(a0), d1                          ; $01AB20
        jsr          OctagonalDistance.l                           ; $01AB24
        cmpi.w       #$a, d0                                       ; $01AB2A
        bcs.w        ChooseGunnerGoalOrDie                         ; $01AB2E
        move.w       ActorMotionX(a0), d0                          ; $01AB32
        move.w       ActorMotionY(a0), d1                          ; $01AB36
        bsr.w        MoveActorWithWallMargin32                     ; $01AB3A
        asr.w        ActorMotionX(a0)                              ; $01AB3E
        asr.w        ActorMotionY(a0)                              ; $01AB42
        rts                                                        ; $01AB46

InitializeGunnerMovement:
; State0, Byte51=6, Byte52=0, GoalAngle=0. Computed initial random angle discarded; helper adds$50 AFTER using angle0. Tail reads inherited A3, not ActorTarget loaded here.
        move.b       #$0, ActorState(a0)                           ; $01AB48
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $01AB4E
        move.b       #$0, ActorBehaviorByte52(a0)                  ; $01AB54
        clr.w        ActorGoalAngle(a0)                            ; $01AB5A
        jsr          NextRandom.l                                  ; $01AB5E
        asr.l        #$4, d2                                       ; $01AB64
        andi.w       #$1ff, d2                                     ; $01AB66
        bra.w        ChooseHalfRadiusRotatingTargetGoal            ; $01AB6A
        ifne *-$1AB6E
        fail "ROM end moved"
        endif
