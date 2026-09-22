; $019762..$019807 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Beatress: marker-search/move, local-player pursuit, close attack. 1200 HP; max component30. See docs/BEATRESS_DENPYDER.md. Collision/LOS internals remain separate.
        ifne *-$19762
        fail "ROM start moved"
        endif

UpdateBeatress:
; Beatress: marker-search/move, local-player pursuit, close attack. 1200 HP; max component30. See docs/BEATRESS_DENPYDER.md. Collision/LOS internals remain separate.
        clr.b        ActorUpdateDelay(a0)                          ; $019762
        cmpi.b       #$cd, ActorState(a0)                          ; $019766
        beq.w        InitializeBeatressMarkerSearch                ; $01976C
        cmpi.b       #$5, ActorState(a0)                           ; $019770
        beq.w        BeatressTickWeaponDeath                       ; $019776
        cmpi.b       #$6, ActorState(a0)                           ; $01977A
        beq.w        BeatressTickUnassignedStateSix                ; $019780
        cmpi.b       #$2, ActorState(a0)                           ; $019784
        bne.w        MoveBeatressTowardGoal                        ; $01978A
        move.w       ActorMotionX(a0), d0                          ; $01978E
        move.w       ActorMotionY(a0), d1                          ; $019792
        jsr          OctagonalDistance.l                           ; $019796
        cmpi.w       #$a, d0                                       ; $01979C
        bcs.w        ChooseBeatressGoalOrDie                       ; $0197A0
        move.w       ActorMotionX(a0), d0                          ; $0197A4
        move.w       ActorMotionY(a0), d1                          ; $0197A8
        bsr.w        MoveActorWithWallMargin32                     ; $0197AC
        asr.w        ActorMotionX(a0)                              ; $0197B0
        asr.w        ActorMotionY(a0)                              ; $0197B4
        rts                                                        ; $0197B8

InitializeBeatressMarkerSearch:
; Goal starts at current XY; Byte51=0, Byte52=0, word56=0. Scan neighboring markers; none -> flags51/52=FF and local-player goal with word56 high byte set.
        move.b       #$0, ActorState(a0)                           ; $0197BA
        clr.b        ActorBehaviorByte51(a0)                       ; $0197C0
        move.b       #$5, ActorBehaviorByte52(a0)                  ; $0197C4
        jsr          NextRandom.l                                  ; $0197CA
        asr.l        #$4, d2                                       ; $0197D0
        andi.w       #$1ff, d2                                     ; $0197D2
        move.w       d2, ActorGoalAngle(a0)                        ; $0197D6
        move.w       ActorY(a0), d0                                ; $0197DA
        move.w       d0, ActorGoalY(a0)                            ; $0197DE
        move.w       ActorX(a0), d0                                ; $0197E2
        move.w       d0, ActorGoalX(a0)                            ; $0197E6
        clr.b        ActorBehaviorByte52(a0)                       ; $0197EA
        clr.w        ActorCloseGoalFlag(a0)                        ; $0197EE
        bsr.w        FindBeatressNeighborMarkerGoal                ; $0197F2
        tst.w        d7                                            ; $0197F6
        beq.b        loc_019806                                    ; $0197F8
        st.b         ActorBehaviorByte52(a0)                       ; $0197FA
        st.b         ActorBehaviorByte51(a0)                       ; $0197FE
        bra.w        ChooseLocalPlayerGoalAndArmMelee              ; $019802

loc_019806:
        rts                                                        ; $019806
        ifne *-$19808
        fail "ROM end moved"
        endif
