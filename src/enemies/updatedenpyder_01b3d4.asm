; $01B3D4..$01B47F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Denpyder: starts dormant7; hit wakes to8 without HP loss; charge/return/wander use alternate collision $1D468.1200 HP, half incoming damage. See docs/BEATRESS_DENPYDER.md.
        ifne *-$1B3D4
        fail "ROM start moved"
        endif

UpdateDenpyder:
; Denpyder: starts dormant7; hit wakes to8 without HP loss; charge/return/wander use alternate collision $1D468.1200 HP, half incoming damage. See docs/BEATRESS_DENPYDER.md.
        clr.b        ActorUpdateDelay(a0)                          ; $01B3D4
        cmpi.b       #$cd, ActorState(a0)                          ; $01B3D8
        beq.w        InitializeDormantDenpyder                     ; $01B3DE
        cmpi.b       #$5, ActorState(a0)                           ; $01B3E2
        beq.w        DenpyderTickWeaponDeath                       ; $01B3E8
        cmpi.b       #$6, ActorState(a0)                           ; $01B3EC
        beq.w        DenpyderTickUnassignedStateSix                ; $01B3F2
        cmpi.b       #$7, ActorState(a0)                           ; $01B3F6
        beq.w        DenpyderDormantReturn                         ; $01B3FC
        cmpi.b       #$8, ActorState(a0)                           ; $01B400
        beq.w        TickDenpyderWake                              ; $01B406
        cmpi.b       #$2, ActorState(a0)                           ; $01B40A
        bne.w        loc_01B444                                    ; $01B410
        clr.b        ActorStateCounter(a0)                         ; $01B414
        move.w       ActorMotionX(a0), d0                          ; $01B418
        move.w       ActorMotionY(a0), d1                          ; $01B41C
        jsr          OctagonalDistance.l                           ; $01B420
        cmpi.w       #$a, d0                                       ; $01B426
        bcs.w        ChooseDenpyderWanderGoalOrDie                 ; $01B42A
        move.w       ActorMotionX(a0), d0                          ; $01B42E
        move.w       ActorMotionY(a0), d1                          ; $01B432
        bsr.w        MoveActorWithWallMargin64                     ; $01B436
        asr.w        ActorMotionX(a0)                              ; $01B43A
        asr.w        ActorMotionY(a0)                              ; $01B43E
        rts                                                        ; $01B442

loc_01B444:
        cmpi.b       #$9, ActorState(a0)                           ; $01B444
        beq.w        MoveDenpyderWanderAndCheckTarget              ; $01B44A
        cmpi.b       #$b, ActorState(a0)                           ; $01B44E
        beq.w        ReturnDenpyderToChargeStart                   ; $01B454
        bra.w        MoveDenpyderCharge                            ; $01B458

InitializeDormantDenpyder:
; State7 (update RTS), Byte51=6, Byte52=5, random GoalAngle. Does not initialize SavedXY or attack-start position.
        move.b       #$7, ActorState(a0)                           ; $01B45C
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $01B462
        move.b       #$5, ActorBehaviorByte52(a0)                  ; $01B468
        jsr          NextRandom.l                                  ; $01B46E
        asr.l        #$4, d2                                       ; $01B474
        andi.w       #$1ff, d2                                     ; $01B476
        move.w       d2, ActorGoalAngle(a0)                        ; $01B47A
        rts                                                        ; $01B47E
        ifne *-$1B480
        fail "ROM end moved"
        endif
