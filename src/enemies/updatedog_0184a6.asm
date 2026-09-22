; $0184A6..$01851F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Dog: 800 HP, full damage, charge/return/wander with alternate collision $1D468. Initial CD branches into shared Larva initializer $18E0C; no dormant wake state.
        ifne *-$184A6
        fail "ROM start moved"
        endif

UpdateDog:
; Dog: 800 HP, full damage, charge/return/wander with alternate collision $1D468. Initial CD branches into shared Larva initializer $18E0C; no dormant wake state.
        clr.b        ActorUpdateDelay(a0)                          ; $0184A6
        cmpi.b       #$cd, ActorState(a0)                          ; $0184AA
        beq.w        InitializeLarvaCreatureOrDog                  ; $0184B0
        cmpi.b       #$5, ActorState(a0)                           ; $0184B4
        beq.w        DogTickWeaponDeath                            ; $0184BA
        cmpi.b       #$6, ActorState(a0)                           ; $0184BE
        beq.w        DogTickUnassignedStateSix                     ; $0184C4
        cmpi.b       #$c, ActorState(a0)                           ; $0184C8
        beq.w        DogEnterWeaponFiveDeath                       ; $0184CE
        cmpi.b       #$2, ActorState(a0)                           ; $0184D2
        bne.w        loc_01850C                                    ; $0184D8
        clr.b        ActorStateCounter(a0)                         ; $0184DC
        move.w       ActorMotionX(a0), d0                          ; $0184E0
        move.w       ActorMotionY(a0), d1                          ; $0184E4
        jsr          OctagonalDistance.l                           ; $0184E8
        cmpi.w       #$a, d0                                       ; $0184EE
        bcs.w        ChooseDogWanderGoalOrDie                      ; $0184F2
        move.w       ActorMotionX(a0), d0                          ; $0184F6
        move.w       ActorMotionY(a0), d1                          ; $0184FA
        bsr.w        MoveActorWithWallMargin64                     ; $0184FE
        asr.w        ActorMotionX(a0)                              ; $018502
        asr.w        ActorMotionY(a0)                              ; $018506
        rts                                                        ; $01850A

loc_01850C:
        cmpi.b       #$7, ActorState(a0)                           ; $01850C
        beq.w        MoveDogWanderAndCheckTarget                   ; $018512
        cmpi.b       #$9, ActorState(a0)                           ; $018516
        beq.w        ReturnDogToChargeStart                        ; $01851C
        ifne *-$18520
        fail "ROM end moved"
        endif
