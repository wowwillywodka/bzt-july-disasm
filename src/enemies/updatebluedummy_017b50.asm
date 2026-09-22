; $017B50..$017BD9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Blue Dummy: 1200 HP, full damage, component speed25, projectile at attack counter5. Recoil exits below90. See docs/LARVA_BLUE_DOG.md.
        ifne *-$17B50
        fail "ROM start moved"
        endif

UpdateBlueDummy:
; Blue Dummy: 1200 HP, full damage, component speed25, projectile at attack counter5. Recoil exits below90. See docs/LARVA_BLUE_DOG.md.
        clr.b        ActorUpdateDelay(a0)                          ; $017B50
        cmpi.b       #$cd, ActorState(a0)                          ; $017B54
        beq.w        InitializeBlueDummy                           ; $017B5A
        cmpi.b       #$5, ActorState(a0)                           ; $017B5E
        beq.w        BlueDummyTickWeaponDeath                      ; $017B64
        cmpi.b       #$6, ActorState(a0)                           ; $017B68
        beq.w        BlueDummyTickInvisibleWeaponDeath             ; $017B6E
        cmpi.b       #$7, ActorState(a0)                           ; $017B72
        beq.w        loc_017FA2                                    ; $017B78
        cmpi.b       #$2, ActorState(a0)                           ; $017B7C
        bne.w        MoveBlueDummyAndTickAttack                    ; $017B82
        move.w       ActorMotionX(a0), d0                          ; $017B86
        move.w       ActorMotionY(a0), d1                          ; $017B8A
        jsr          OctagonalDistance.l                           ; $017B8E
        cmpi.w       #$5a, d0                                      ; $017B94
        bcs.w        ChooseBlueDummyGoalOrDie                      ; $017B98
        move.w       ActorMotionX(a0), d0                          ; $017B9C
        move.w       ActorMotionY(a0), d1                          ; $017BA0
        bsr.w        MoveActorWithWallMargin32                     ; $017BA4
        asr.w        ActorMotionX(a0)                              ; $017BA8
        asr.w        ActorMotionY(a0)                              ; $017BAC
        rts                                                        ; $017BB0

InitializeBlueDummy:
; State0, bytes51/52=6/5, random counter0..31 (zero permitted). Shared goal helper inherits A3.
        move.b       #$0, ActorState(a0)                           ; $017BB2
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $017BB8
        move.b       #$5, ActorBehaviorByte52(a0)                  ; $017BBE
        jsr          NextRandom.l                                  ; $017BC4
        swap         d2                                            ; $017BCA
        andi.w       #$1f, d2                                      ; $017BCC
        move.w       d2, d0                                        ; $017BD0
        move.b       d0, ActorStateCounter(a0)                     ; $017BD2
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $017BD6
        ifne *-$17BDA
        fail "ROM end moved"
        endif
