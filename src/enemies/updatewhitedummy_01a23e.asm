; $01A23E..$01A2BB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; White Dummy: 1200 initial HP, +/-50 movement, rotating goals and stationary shooting. Recoil exits below10. See docs/GUNNER_WHITE_DUMMY.md.
        ifne *-$1A23E
        fail "ROM start moved"
        endif

UpdateWhiteDummy:
; White Dummy: 1200 initial HP, +/-50 movement, rotating goals and stationary shooting. Recoil exits below10. See docs/GUNNER_WHITE_DUMMY.md.
        clr.b        ActorUpdateDelay(a0)                          ; $01A23E
        cmpi.b       #$cd, ActorState(a0)                          ; $01A242
        beq.w        InitializeWhiteDummyMovement                  ; $01A248
        cmpi.b       #$5, ActorState(a0)                           ; $01A24C
        beq.w        WhiteDummyTickWeaponDeath                     ; $01A252
        cmpi.b       #$6, ActorState(a0)                           ; $01A256
        beq.w        WhiteDummyTickUnassignedStateSix              ; $01A25C
        cmpi.b       #$2, ActorState(a0)                           ; $01A260
        bne.w        MoveWhiteDummyTowardGoal                      ; $01A266
        move.w       ActorMotionX(a0), d0                          ; $01A26A
        move.w       ActorMotionY(a0), d1                          ; $01A26E
        jsr          OctagonalDistance.l                           ; $01A272
        cmpi.w       #$a, d0                                       ; $01A278
        bcs.w        ChooseWhiteDummyGoalOrDie                     ; $01A27C
        move.w       ActorMotionX(a0), d0                          ; $01A280
        move.w       ActorMotionY(a0), d1                          ; $01A284
        bsr.w        MoveActorWithWallMargin32                     ; $01A288
        asr.w        ActorMotionX(a0)                              ; $01A28C
        asr.w        ActorMotionY(a0)                              ; $01A290
        rts                                                        ; $01A294

InitializeWhiteDummyMovement:
; State0, Byte51=6, Byte52=5; initial GoalAngle=(RNG>>4)&511. Counter unchanged. Tail helper reads INHERITED A3; neither this path nor UpdateActors loads ActorTarget into A3 here.
        move.b       #$0, ActorState(a0)                           ; $01A296
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $01A29C
        move.b       #$5, ActorBehaviorByte52(a0)                  ; $01A2A2
        jsr          NextRandom.l                                  ; $01A2A8
        asr.l        #$4, d2                                       ; $01A2AE
        andi.w       #$1ff, d2                                     ; $01A2B0
        move.w       d2, ActorGoalAngle(a0)                        ; $01A2B4
        bra.w        ChooseRotatingTargetGoal                      ; $01A2B8
        ifne *-$1A2BC
        fail "ROM end moved"
        endif
