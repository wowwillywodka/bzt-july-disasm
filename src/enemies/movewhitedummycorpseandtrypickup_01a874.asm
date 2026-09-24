; $01A874..$01A981 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse motion damping and pickup. Local item0C, quantity2/3, BULIGUN message; remote command13 item08. C8/C9 bypass pickup.
        ifne *-$1A874
        fail "ROM start moved"
        endif

MoveWhiteDummyCorpseAndTryPickup:
; Corpse motion damping and pickup. Local item0C, quantity2/3, BULIGUN message; remote command13 item08. C8/C9 bypass pickup.
        move.w       ActorMotionX(a0), d0                          ; $01A874
        bmi.b        loc_01A87E                                    ; $01A878
        asr.w        #$1, d0                                       ; $01A87A
        bra.b        loc_01A884                                    ; $01A87C

loc_01A87E:
        neg.w        d0                                            ; $01A87E
        asr.w        #$1, d0                                       ; $01A880
        neg.w        d0                                            ; $01A882

loc_01A884:
        move.w       d0, ActorMotionX(a0)                          ; $01A884
        move.w       ActorMotionY(a0), d1                          ; $01A888
        bmi.b        loc_01A892                                    ; $01A88C
        asr.w        #$1, d1                                       ; $01A88E
        bra.b        loc_01A898                                    ; $01A890

loc_01A892:
        neg.w        d1                                            ; $01A892
        asr.w        #$1, d1                                       ; $01A894
        neg.w        d1                                            ; $01A896

loc_01A898:
        move.w       d1, ActorMotionY(a0)                          ; $01A898
        move.w       d0, d2                                        ; $01A89C
        or.w         d1, d2                                        ; $01A89E
        beq.b        loc_01A8AE                                    ; $01A8A0
        move.w       d0, ActorMotionX(a0)                          ; $01A8A2
        move.w       d1, ActorMotionY(a0)                          ; $01A8A6
        bsr.w        MoveActorWithWallMargin32                     ; $01A8AA

loc_01A8AE:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01A8AE
        beq.b        loc_01A8C0                                    ; $01A8B4
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01A8B6
        beq.b        loc_01A8C0                                    ; $01A8BC
        bra.b        loc_01A8C4                                    ; $01A8BE

loc_01A8C0:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01A8C0

loc_01A8C4:
        movea.l      ActorTarget(a0), a3                           ; $01A8C4
        move.w       ActorX(a0), d0                                ; $01A8C8
        sub.w        ActorX(a3), d0                                ; $01A8CC
        move.w       ActorY(a0), d1                                ; $01A8D0
        sub.w        ActorY(a3), d1                                ; $01A8D4
        move.w       d0, d3                                        ; $01A8D8
        move.w       d1, d4                                        ; $01A8DA
        jsr          OctagonalDistance.l                           ; $01A8DC
        cmpi.w       #$60, d0                                      ; $01A8E2
        bcs.b        loc_01A8EC                                    ; $01A8E6
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $01A8E8

loc_01A8EC:
        tst.b        ActorMarkerTracked(a0)                        ; $01A8EC
        beq.b        loc_01A8FC                                    ; $01A8F0
        move.w       #$1, rWallOpeningPermit(a6)                   ; $01A8F2
        clr.b        ActorMarkerTracked(a0)                        ; $01A8F8

loc_01A8FC:
        cmpi.b       #$3, ActorState(a0)                           ; $01A8FC
        bne.b        loc_01A980                                    ; $01A902
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01A904
        bne.b        loc_01A954                                    ; $01A90A
        jsr          NextRandom.l                                  ; $01A90C
        asr.w        #$8, d2                                       ; $01A912
        andi.w       #$1, d2                                       ; $01A914
        addq.w       #$2, d2                                       ; $01A918
        lsl.w        #$8, d2                                       ; $01A91A
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $01A91C
        move.w       #$c, d0                                       ; $01A920
        move.l       a0, -(a7)                                     ; $01A924
        jsr          GrantInventoryItem.l                            ; $01A926
        movea.l      (a7)+, a0                                     ; $01A92C
        clr.w        rItemGrantAmountOverride(a6)                                    ; $01A92E
        cmpi.w       #$ffff, d7                                    ; $01A932
        beq.b        loc_01A980                                    ; $01A936
        move.b       #$4, ActorState(a0)                           ; $01A938
        move.w       #$60, d0                                      ; $01A93E
        jsr          RouteSoundEventByActorFloor.l                         ; $01A942
        movea.l      #StatusMessageBuligunCollected, a0            ; $01A948
        jmp          QueueStatusMessage.l                          ; $01A94E

loc_01A954:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01A954
        move.b       #$4, ActorState(a0)                           ; $01A958
        move.b       #$13, (a1)+                                   ; $01A95E
        move.b       #$8, (a1)+                                    ; $01A962
        jsr          NextRandom.l                                  ; $01A966
        asr.w        #$8, d2                                       ; $01A96C
        andi.w       #$1, d2                                       ; $01A96E
        addq.w       #$2, d2                                       ; $01A972
        move.b       d2, (a1)+                                     ; $01A974
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01A976
        jmp          QueueLinkCommand.l                            ; $01A97A

loc_01A980:
        rts                                                        ; $01A980
        ifne *-$1A982
        fail "ROM end moved"
        endif
