; $01F52A..$01F5A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D writes ID, XY and MotionXY. Selected animation D0/D2 are not serialized by tail $1F5BA.
        ifne *-$1F52A
        fail "ROM start moved"
        endif

SendWhiteDummyState:
; Command0D writes ID, XY and MotionXY. Selected animation D0/D2 are not serialized by tail $1F5BA.
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F52A
        move.b       #$d, (a1)+                                    ; $01F52E
        move.b       ActorLinkId(a0), (a1)+                        ; $01F532
        move.w       ActorX(a0), (a1)+                             ; $01F536
        move.w       ActorY(a0), (a1)+                             ; $01F53A
        move.w       ActorMotionX(a0), (a1)+                       ; $01F53E
        move.w       ActorMotionY(a0), (a1)+                       ; $01F542
        move.b       ActorState(a0), d7                            ; $01F546
        cmpi.b       #$2, d7                                       ; $01F54A
        beq.b        loc_01F558                                    ; $01F54E
        cmpi.b       #$1, d7                                       ; $01F550
        beq.b        loc_01F562                                    ; $01F554
        bra.b        loc_01F5BA                                    ; $01F556

loc_01F558:
        tst.w        ActorHealth(a0)                               ; $01F558
        bmi.b        loc_01F560                                    ; $01F55C
        bra.b        loc_01F5BA                                    ; $01F55E

loc_01F560:
        bra.b        loc_01F5BA                                    ; $01F560

loc_01F562:
        move.b       ActorStateCounter(a0), d7                     ; $01F562
        cmpi.b       #$9, d7                                       ; $01F566
        beq.b        loc_01F59E                                    ; $01F56A
        cmpi.b       #$8, d7                                       ; $01F56C
        beq.b        loc_01F59E                                    ; $01F570
        cmpi.b       #$2, d7                                       ; $01F572
        beq.b        loc_01F59E                                    ; $01F576
        cmpi.b       #$1, d7                                       ; $01F578
        beq.b        loc_01F59E                                    ; $01F57C
        cmpi.b       #$7, d7                                       ; $01F57E
        beq.b        QueueWhiteDummyStatePacketVariantB                           ; $01F582
        cmpi.b       #$6, d7                                       ; $01F584
        beq.b        QueueWhiteDummyStatePacketVariantB                           ; $01F588
        cmpi.b       #$4, d7                                       ; $01F58A
        beq.b        QueueWhiteDummyStatePacketVariantB                           ; $01F58E
        cmpi.b       #$3, d7                                       ; $01F590
        beq.b        QueueWhiteDummyStatePacketVariantB                           ; $01F594
        cmpi.b       #$5, d7                                       ; $01F596
        beq.b        loc_01F5B2                                    ; $01F59A
        rts                                                        ; $01F59C

loc_01F59E:
        move.w       #$1, d0                                       ; $01F59E
        move.w       #$1, d2                                       ; $01F5A2
        bra.b        loc_01F5BA                                    ; $01F5A6
        ifne *-$1F5A8
        fail "ROM end moved"
        endif
