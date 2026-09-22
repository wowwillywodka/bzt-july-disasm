; $019808..$0198B3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Signed HP<0 dies. Random movement counter1..31 retries zero; discarded distance delay. Flag52=0 retries scan;52!=0/51=0 runs selector once; both nonzero pursues local player.
        ifne *-$19808
        fail "ROM start moved"
        endif

ChooseBeatressGoalOrDie:
; Signed HP<0 dies. Random movement counter1..31 retries zero; discarded distance delay. Flag52=0 retries scan;52!=0/51=0 runs selector once; both nonzero pursues local player.
        tst.w        ActorHealth(a0)                               ; $019808
        bmi.w        EnterBeatressDeath                            ; $01980C
        movea.l      ActorTarget(a0), a3                           ; $019810
        jsr          NextRandom.l                                  ; $019814
        swap         d2                                            ; $01981A
        andi.w       #$1f, d2                                      ; $01981C
        move.w       d2, -(a7)                                     ; $019820
        move.w       ActorX(a0), d0                                ; $019822
        sub.w        ActorX(a3), d0                                ; $019826
        move.w       ActorY(a0), d1                                ; $01982A
        sub.w        ActorY(a3), d1                                ; $01982E
        jsr          OctagonalDistance.l                           ; $019832
        asr.w        #$6, d0                                       ; $019838
        add.w        (a7)+, d0                                     ; $01983A

loc_01983C:
        jsr          NextRandom.l                                  ; $01983C
        swap         d2                                            ; $019842
        andi.w       #$1f, d2                                      ; $019844
        tst.w        d2                                            ; $019848
        beq.b        loc_01983C                                    ; $01984A
        move.w       d2, d0                                        ; $01984C
        move.b       d0, ActorStateCounter(a0)                     ; $01984E
        move.b       #$0, ActorState(a0)                           ; $019852
        tst.b        ActorBehaviorByte52(a0)                       ; $019858
        beq.b        RetryBeatressMarkerSearch                     ; $01985C
        tst.b        ActorBehaviorByte51(a0)                       ; $01985E
        bne.b        loc_0198B0                                    ; $019862

BeatressRunNeighborSpawnSelector:
; Call $9918 on 5x5 grid around actor cell with temporary CurrentFloor=ActorFloor. $9918 still uses PLAYER XY for bounds and spawn coordinate counters; not a simple spawn-at-goal call. Floor restored afterward; Byte51 set even on no spawn.
        clr.w        d5                                            ; $019864
        move.b       ActorFloor(a0), d5                            ; $019866
        movem.l      d0-d1/d5/a0, -(a7)                            ; $01986A
        clr.w        d0                                            ; $01986E
        lea.l        rVisibleMapWindow(a6), a1                     ; $019870
        move.w       ActorX(a0), d0                                ; $019874
        lsr.w        #$8, d0                                       ; $019878
        adda.w       d0, a1                                        ; $01987A
        move.w       ActorY(a0), d0                                ; $01987C
        lsr.w        #$8, d0                                       ; $019880
        lsl.w        #$5, d0                                       ; $019882
        adda.w       d0, a1                                        ; $019884
        movea.l      a1, a0                                        ; $019886
        clr.w        d3                                            ; $019888
        lea.l        rCellTypeByIndex(a6), a5                      ; $01988A
        movea.l      #ActorSpawnCellSelectors, a4                  ; $01988E
        move.w       rCurrentFloor(a6), -(a7)                      ; $019894
        move.w       d5, rCurrentFloor(a6)                         ; $019898
        jsr          ScanNearbyActorCells5x5.l                     ; $01989C
        move.w       (a7)+, rCurrentFloor(a6)                      ; $0198A2
        movem.l      (a7)+, d0-d1/d5/a0                            ; $0198A6
        st.b         ActorBehaviorByte51(a0)                       ; $0198AA
        rts                                                        ; $0198AE

loc_0198B0:
        bra.w        ChooseLocalPlayerGoalAndArmMelee              ; $0198B0
        ifne *-$198B4
        fail "ROM end moved"
        endif
