; $016962..$016A0F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Grey Dummy local state machine; docs/GREY_GREEN_DUMMY.md. Alternating weighted movement goals and stationary ranged attacks. HP death requires signed negative health.
        ifne *-$16962
        fail "ROM start moved"
        endif

UpdateGreyDummy:
; Grey Dummy local state machine; docs/GREY_GREEN_DUMMY.md. Alternating weighted movement goals and stationary ranged attacks. HP death requires signed negative health.
        clr.b        ActorUpdateDelay(a0)                          ; $016962
        cmpi.b       #$cd, ActorState(a0)                          ; $016966
        beq.w        InitializeGreyDummyMovement                   ; $01696C
        cmpi.b       #$5, ActorState(a0)                           ; $016970
        beq.w        GreyDummyTickWeapon0DDeath                    ; $016976
        cmpi.b       #$6, ActorState(a0)                           ; $01697A
        beq.w        GreyDummyTickWeapon0BDeath                    ; $016980
        cmpi.b       #$2, ActorState(a0)                           ; $016984
        bne.w        MoveGreyDummyAndCheckGoal                     ; $01698A
        move.w       ActorMotionX(a0), d0                          ; $01698E
        move.w       ActorMotionY(a0), d1                          ; $016992
        jsr          OctagonalDistance.l                           ; $016996
        cmpi.w       #$5a, d0                                      ; $01699C
        bcs.w        GreyDummyChooseNextGoalOrDie                  ; $0169A0
        move.w       ActorMotionX(a0), d0                          ; $0169A4
        move.w       ActorMotionY(a0), d1                          ; $0169A8
        bsr.w        MoveActorWithWallMargin32                     ; $0169AC
        asr.w        ActorMotionX(a0)                              ; $0169B0
        asr.w        ActorMotionY(a0)                              ; $0169B4
        rts                                                        ; $0169B8

InitializeGreyDummyMovement:
; Sets state0 and Byte51=6; leaves Byte50 and StateCounter unchanged. Do not assume the pool supplied a zero flag.
        move.b       #$0, ActorState(a0)                           ; $0169BA
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $0169C0
        rts                                                        ; $0169C6

GreyDummyChooseNextGoalOrDie:
        tst.w        ActorHealth(a0)                               ; $0169C8
        bmi.w        EnterGreyDummyDeath                           ; $0169CC
        movea.l      ActorTarget(a0), a3                           ; $0169D0
        jsr          NextRandom.l                                  ; $0169D4
        swap         d2                                            ; $0169DA
        andi.w       #$1f, d2                                      ; $0169DC
        move.w       d2, -(a7)                                     ; $0169E0
        move.w       ActorX(a0), d0                                ; $0169E2
        sub.w        ActorX(a3), d0                                ; $0169E6
        move.w       ActorY(a0), d1                                ; $0169EA
        sub.w        ActorY(a3), d1                                ; $0169EE
        jsr          OctagonalDistance.l                           ; $0169F2
        asr.w        #$6, d0                                       ; $0169F8
        add.w        (a7)+, d0                                     ; $0169FA
; Computed random/distance delay overwritten with 5. Byte50 selects the +$80 or +$180 weighted goal helper, which toggles the flag.
        moveq        #$5, d0                                       ; $0169FC
        move.b       d0, ActorStateCounter(a0)                     ; $0169FE
        cmpi.b       #$0, ActorBehaviorByte50(a0)                  ; $016A02
        beq.w        ChooseWeightedTargetGoalAtPlus80              ; $016A08
        bra.w        ChooseWeightedTargetGoalAtPlus180             ; $016A0C
        ifne *-$16A10
        fail "ROM end moved"
        endif
