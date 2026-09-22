; $016194..$01624B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Stanan state machine; see docs/STANAN.md. CD initializes a reload flag and saved angle, not group roles. State1 attacks without collision movement; state2 recoils; 5/6 are weapon-specific deaths.
        ifne *-$16194
        fail "ROM start moved"
        endif

UpdateStanan:
; Stanan state machine; see docs/STANAN.md. CD initializes a reload flag and saved angle, not group roles. State1 attacks without collision movement; state2 recoils; 5/6 are weapon-specific deaths.
        clr.b        ActorUpdateDelay(a0)                          ; $016194
        cmpi.b       #$cd, ActorState(a0)                          ; $016198
        beq.w        InitializeStananMovement                      ; $01619E
        cmpi.b       #$5, ActorState(a0)                           ; $0161A2
        beq.w        StananTickWeapon0DDeath                       ; $0161A8
        cmpi.b       #$6, ActorState(a0)                           ; $0161AC
        beq.w        StananTickWeapon0BDeath                       ; $0161B2
        cmpi.b       #$2, ActorState(a0)                           ; $0161B6
        bne.w        MoveStananAndCheckGoal                        ; $0161BC
        move.w       ActorMotionX(a0), d0                          ; $0161C0
        move.w       ActorMotionY(a0), d1                          ; $0161C4
        jsr          OctagonalDistance.l                           ; $0161C8
        cmpi.w       #$5a, d0                                      ; $0161CE
        bcs.w        StananChooseNextGoalOrDie                     ; $0161D2
        move.w       ActorMotionX(a0), d0                          ; $0161D6
        move.w       ActorMotionY(a0), d1                          ; $0161DA
        bsr.w        MoveActorWithWallMargin32                     ; $0161DE
        asr.w        ActorMotionX(a0)                              ; $0161E2
        asr.w        ActorMotionY(a0)                              ; $0161E6
        rts                                                        ; $0161EA

InitializeStananMovement:
        move.b       #$0, ActorState(a0)                           ; $0161EC
; Byte51=6 is initialized here but not consumed by the reviewed Stanan goal path. Other types use that byte as a weighting counter.
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $0161F2
        st.b         ActorBehaviorByte50(a0)                       ; $0161F8
        clr.w        ActorGoalAngle(a0)                            ; $0161FC
        rts                                                        ; $016200

StananChooseNextGoalOrDie:
        tst.w        ActorHealth(a0)                               ; $016202
        bmi.w        StananEnterDeath                              ; $016206
        movea.l      ActorTarget(a0), a3                           ; $01620A
        jsr          NextRandom.l                                  ; $01620E
        swap         d2                                            ; $016214
        andi.w       #$1f, d2                                      ; $016216
        move.w       d2, -(a7)                                     ; $01621A
        move.w       ActorX(a0), d0                                ; $01621C
        sub.w        ActorX(a3), d0                                ; $016220
        move.w       ActorY(a0), d1                                ; $016224
        sub.w        ActorY(a3), d1                                ; $016228
        jsr          OctagonalDistance.l                           ; $01622C
        asr.w        #$6, d0                                       ; $016232
        add.w        (a7)+, d0                                     ; $016234
; Random/distance delay is overwritten with 5; counter is reloaded only when Byte50 is nonzero, then Byte50 clears. Otherwise the existing counter survives.
        moveq        #$5, d0                                       ; $016236
        tst.b        ActorBehaviorByte50(a0)                       ; $016238
        beq.w        loc_016248                                    ; $01623C
        move.b       d0, ActorStateCounter(a0)                     ; $016240
        clr.b        ActorBehaviorByte50(a0)                       ; $016244

loc_016248:
        bra.w        ChooseStananOffsetGoal                        ; $016248
        ifne *-$1624C
        fail "ROM end moved"
        endif
