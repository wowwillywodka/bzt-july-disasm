; $01674C..$01686D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse transition, movement and pickup tail. Normal local pickup grants item $0C, amount2/3, SHOTGUN message. C8/C9 skip pickup.
        ifne *-$1674C
        fail "ROM start moved"
        endif

TickStananCorpseTransition:
; Corpse transition, movement and pickup tail. Normal local pickup grants item $0C, amount2/3, SHOTGUN message. C8/C9 skip pickup.
        subq.b       #$1, ActorState(a0)                           ; $01674C
        bne.w        loc_016760                                    ; $016750
        move.b       #$ca, ActorDeathMode(a0)                      ; $016754
        move.b       #$3, ActorState(a0)                           ; $01675A

loc_016760:
        rts                                                        ; $016760

StananMoveCorpse:
        move.w       ActorMotionX(a0), d0                          ; $016762
        bmi.b        loc_01676C                                    ; $016766
        asr.w        #$1, d0                                       ; $016768
        bra.b        loc_016772                                    ; $01676A

loc_01676C:
        neg.w        d0                                            ; $01676C
        asr.w        #$1, d0                                       ; $01676E
        neg.w        d0                                            ; $016770

loc_016772:
        move.w       d0, ActorMotionX(a0)                          ; $016772
        move.w       ActorMotionY(a0), d1                          ; $016776
        bmi.b        loc_016780                                    ; $01677A
        asr.w        #$1, d1                                       ; $01677C
        bra.b        loc_016786                                    ; $01677E

loc_016780:
        neg.w        d1                                            ; $016780
        asr.w        #$1, d1                                       ; $016782
        neg.w        d1                                            ; $016784

loc_016786:
        move.w       d1, ActorMotionY(a0)                          ; $016786
        move.w       d0, d2                                        ; $01678A
        or.w         d1, d2                                        ; $01678C
        beq.b        loc_01679C                                    ; $01678E
        move.w       d0, ActorMotionX(a0)                          ; $016790
        move.w       d1, ActorMotionY(a0)                          ; $016794
        bsr.w        MoveActorWithWallMargin32                     ; $016798

loc_01679C:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01679C
        beq.b        loc_0167AE                                    ; $0167A2
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0167A4
        beq.b        loc_0167AE                                    ; $0167AA
        bra.b        loc_0167B2                                    ; $0167AC

loc_0167AE:
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $0167AE

loc_0167B2:
        movea.l      ActorTarget(a0), a3                           ; $0167B2
        move.w       ActorX(a0), d0                                ; $0167B6
        sub.w        ActorX(a3), d0                                ; $0167BA
        move.w       ActorY(a0), d1                                ; $0167BE
        sub.w        ActorY(a3), d1                                ; $0167C2
        move.w       d0, d3                                        ; $0167C6
        move.w       d1, d4                                        ; $0167C8
        jsr          OctagonalDistance.l                           ; $0167CA
        cmpi.w       #$60, d0                                      ; $0167D0
        bcs.b        StananTryCorpsePickup                         ; $0167D4
        bra.w        SteerEnemyMotionAtNearbyWall                         ; $0167D6

StananTryCorpsePickup:
        tst.b        ActorMarkerTracked(a0)                        ; $0167DA
        beq.b        loc_0167EA                                    ; $0167DE
        move.w       #$1, rWallOpeningPermit(a6)                   ; $0167E0
        clr.b        ActorMarkerTracked(a0)                        ; $0167E6

loc_0167EA:
        cmpi.b       #$3, ActorState(a0)                           ; $0167EA
        bne.b        loc_01686C                                    ; $0167F0
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $0167F2
        bne.b        loc_016840                                    ; $0167F8
        jsr          NextRandom.l                                  ; $0167FA
        asr.w        #$8, d2                                       ; $016800
        andi.w       #$1, d2                                       ; $016802
        addq.w       #$2, d2                                       ; $016806
        lsl.w        #$8, d2                                       ; $016808
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $01680A
        move.w       #$c, d0                                       ; $01680E
        move.l       a0, -(a7)                                     ; $016812
        jsr          GrantInventoryItem(pc)                          ; $016814
        movea.l      (a7)+, a0                                     ; $016818
        clr.w        rItemGrantAmountOverride(a6)                                    ; $01681A
        cmpi.w       #$ffff, d7                                    ; $01681E
        beq.b        loc_01686C                                    ; $016822
        move.b       #$4, ActorState(a0)                           ; $016824
        move.w       #$60, d0                                      ; $01682A
        jsr          RouteSoundEventByActorFloor.l                         ; $01682E
        movea.l      #StatusMessageShotgunCollected, a0            ; $016834
        jmp          QueueStatusMessage.l                          ; $01683A

loc_016840:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $016840
        move.b       #$4, ActorState(a0)                           ; $016844
        move.b       #$13, (a1)+                                   ; $01684A
; Original local/link mismatch: remote pickup packet $13 contains item08, while local inventory call at $01680E uses item0C. Receiver behavior is outside this local contract.
        move.b       #$8, (a1)+                                    ; $01684E
        jsr          NextRandom.l                                  ; $016852
        asr.w        #$8, d2                                       ; $016858
        andi.w       #$1, d2                                       ; $01685A
        addq.w       #$2, d2                                       ; $01685E
        move.b       d2, (a1)+                                     ; $016860
        lea.l        rSharedScratchBuffer(a6), a0                                ; $016862
        jmp          QueueLinkCommand.l                            ; $016866

loc_01686C:
        rts                                                        ; $01686C
        ifne *-$1686E
        fail "ROM end moved"
        endif
