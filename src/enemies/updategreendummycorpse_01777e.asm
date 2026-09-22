; $01777E..$0178EB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same local corpse transition/pickup contract as Grey Dummy: item0C and BULIGUN message, remote packet item08; C8/C9 skip pickup.
        ifne *-$1777E
        fail "ROM start moved"
        endif

UpdateGreenDummyCorpse:
; Same local corpse transition/pickup contract as Grey Dummy: item0C and BULIGUN message, remote packet item08; C8/C9 skip pickup.
        clr.b        ActorUpdateDelay(a0)                          ; $01777E
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $017782
        beq.w        loc_0177BC                                    ; $017788
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01778C
        beq.w        loc_0177CA                                    ; $017792
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $017796
        beq.w        loc_0177B8                                    ; $01779C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0177A0
        beq.w        loc_0177B8                                    ; $0177A6
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $0177AA
        beq.w        loc_0177E0                                    ; $0177B0
        bra.w        loc_0177E0                                    ; $0177B4

loc_0177B8:
        bra.w        loc_0177E0                                    ; $0177B8

loc_0177BC:
        move.b       #$cc, ActorDeathMode(a0)                      ; $0177BC
        move.b       #$1, ActorStateCounter(a0)                    ; $0177C2
        rts                                                        ; $0177C8

loc_0177CA:
        subq.b       #$1, ActorState(a0)                           ; $0177CA
        bne.w        loc_0177DE                                    ; $0177CE
        move.b       #$ca, ActorDeathMode(a0)                      ; $0177D2
        move.b       #$3, ActorState(a0)                           ; $0177D8

loc_0177DE:
        rts                                                        ; $0177DE

loc_0177E0:
        move.w       ActorMotionX(a0), d0                          ; $0177E0
        bmi.b        loc_0177EA                                    ; $0177E4
        asr.w        #$1, d0                                       ; $0177E6
        bra.b        loc_0177F0                                    ; $0177E8

loc_0177EA:
        neg.w        d0                                            ; $0177EA
        asr.w        #$1, d0                                       ; $0177EC
        neg.w        d0                                            ; $0177EE

loc_0177F0:
        move.w       d0, ActorMotionX(a0)                          ; $0177F0
        move.w       ActorMotionY(a0), d1                          ; $0177F4
        bmi.b        loc_0177FE                                    ; $0177F8
        asr.w        #$1, d1                                       ; $0177FA
        bra.b        loc_017804                                    ; $0177FC

loc_0177FE:
        neg.w        d1                                            ; $0177FE
        asr.w        #$1, d1                                       ; $017800
        neg.w        d1                                            ; $017802

loc_017804:
        move.w       d1, ActorMotionY(a0)                          ; $017804
        move.w       d0, d2                                        ; $017808
        or.w         d1, d2                                        ; $01780A
        beq.b        loc_01781A                                    ; $01780C
        move.w       d0, ActorMotionX(a0)                          ; $01780E
        move.w       d1, ActorMotionY(a0)                          ; $017812
        bsr.w        MoveActorWithWallMargin32                     ; $017816

loc_01781A:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01781A
        beq.b        loc_01782C                                    ; $017820
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $017822
        beq.b        loc_01782C                                    ; $017828
        bra.b        loc_017830                                    ; $01782A

loc_01782C:
        bra.w        EnemiesRoutine_01E25A                         ; $01782C

loc_017830:
        movea.l      ActorTarget(a0), a3                           ; $017830
        move.w       ActorX(a0), d0                                ; $017834
        sub.w        ActorX(a3), d0                                ; $017838
        move.w       ActorY(a0), d1                                ; $01783C
        sub.w        ActorY(a3), d1                                ; $017840
        move.w       d0, d3                                        ; $017844
        move.w       d1, d4                                        ; $017846
        jsr          OctagonalDistance.l                           ; $017848
        cmpi.w       #$60, d0                                      ; $01784E
        bcs.b        loc_017858                                    ; $017852
        bra.w        EnemiesRoutine_01E25A                         ; $017854

loc_017858:
        tst.b        ActorMarkerTracked(a0)                        ; $017858
        beq.b        loc_017868                                    ; $01785C
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01785E
        clr.b        ActorMarkerTracked(a0)                        ; $017864

loc_017868:
        cmpi.b       #$3, ActorState(a0)                           ; $017868
        bne.b        loc_0178EA                                    ; $01786E
        cmpa.l       #$ff11e2, a3                                  ; $017870
        bne.b        loc_0178BE                                    ; $017876
        jsr          NextRandom.l                                  ; $017878
        asr.w        #$8, d2                                       ; $01787E
        andi.w       #$1, d2                                       ; $017880
        addq.w       #$2, d2                                       ; $017884
        lsl.w        #$8, d2                                       ; $017886
        move.w       d2, -$6fa2(a6)                                ; $017888
        move.w       #$c, d0                                       ; $01788C
        move.l       a0, -(a7)                                     ; $017890
        jsr          UiRoutine_011C78(pc)                          ; $017892
        movea.l      (a7)+, a0                                     ; $017896
        clr.w        -$6fa2(a6)                                    ; $017898
        cmpi.w       #$ffff, d7                                    ; $01789C
        beq.b        loc_0178EA                                    ; $0178A0
        move.b       #$4, ActorState(a0)                           ; $0178A2
        move.w       #$60, d0                                      ; $0178A8
        jsr          SoundRoutine_00DF64.l                         ; $0178AC
        movea.l      #StatusMessageBuligunCollected, a0            ; $0178B2
        jmp          QueueStatusMessage.l                          ; $0178B8

loc_0178BE:
        lea.l        -$6fdc(a6), a1                                ; $0178BE
        move.b       #$4, ActorState(a0)                           ; $0178C2
        move.b       #$13, (a1)+                                   ; $0178C8
        move.b       #$8, (a1)+                                    ; $0178CC
        jsr          NextRandom.l                                  ; $0178D0
        asr.w        #$8, d2                                       ; $0178D6
        andi.w       #$1, d2                                       ; $0178D8
        addq.w       #$2, d2                                       ; $0178DC
        move.b       d2, (a1)+                                     ; $0178DE
        lea.l        -$6fdc(a6), a0                                ; $0178E0
        jmp          QueueLinkCommand.l                            ; $0178E4

loc_0178EA:
        rts                                                        ; $0178EA
        ifne *-$178EC
        fail "ROM end moved"
        endif
