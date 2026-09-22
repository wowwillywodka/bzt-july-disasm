; $017556..$0176EB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Like Grey Dummy, except state6 DOES draw animation4 frames1..5. Attack1 has draw support but no transition from ordinary Green update into the retained attack code.
        ifne *-$17556
        fail "ROM start moved"
        endif

DrawGreenDummy:
; Like Grey Dummy, except state6 DOES draw animation4 frames1..5. Attack1 has draw support but no transition from ordinary Green update into the retained attack code.
        move.b       ActorState(a0), d7                            ; $017556
        cmpi.b       #$2, d7                                       ; $01755A
        beq.b        loc_017584                                    ; $01755E
        cmpi.b       #$1, d7                                       ; $017560
        beq.w        loc_017686                                    ; $017564
        cmpi.b       #$5, d7                                       ; $017568
        beq.b        loc_0175A6                                    ; $01756C
        cmpi.b       #$6, d7                                       ; $01756E
        beq.w        loc_01761C                                    ; $017572
        move.w       #$0, d0                                       ; $017576
        move.w       #$ffff, d2                                    ; $01757A
        jmp          DrawActorAnimation.l                          ; $01757E

loc_017584:
        tst.w        ActorHealth(a0)                               ; $017584
        bmi.b        loc_017598                                    ; $017588
        move.w       #$6, d0                                       ; $01758A
        move.w       #$1, d2                                       ; $01758E
        jmp          DrawActorAnimation.l                          ; $017592

loc_017598:
        move.w       #$3, d0                                       ; $017598
        move.w       #$1, d2                                       ; $01759C
        jmp          DrawActorAnimation.l                          ; $0175A0

loc_0175A6:
        move.b       ActorStateCounter(a0), d7                     ; $0175A6
        cmpi.b       #$7, d7                                       ; $0175AA
        beq.b        loc_0175D6                                    ; $0175AE
        cmpi.b       #$6, d7                                       ; $0175B0
        beq.b        loc_0175D6                                    ; $0175B4
        cmpi.b       #$5, d7                                       ; $0175B6
        beq.b        loc_0175E4                                    ; $0175BA
        cmpi.b       #$4, d7                                       ; $0175BC
        beq.b        loc_0175E4                                    ; $0175C0
        cmpi.b       #$3, d7                                       ; $0175C2
        beq.b        loc_0175F2                                    ; $0175C6
        cmpi.b       #$2, d7                                       ; $0175C8
        beq.b        loc_017600                                    ; $0175CC
        cmpi.b       #$1, d7                                       ; $0175CE
        beq.b        loc_01760E                                    ; $0175D2
        rts                                                        ; $0175D4

loc_0175D6:
        move.w       #$6, d0                                       ; $0175D6
        move.w       #$1, d2                                       ; $0175DA
        jmp          DrawActorAnimation.l                          ; $0175DE

loc_0175E4:
        move.w       #$4, d0                                       ; $0175E4
        move.w       #$1, d2                                       ; $0175E8
        jmp          DrawActorAnimation.l                          ; $0175EC

loc_0175F2:
        move.w       #$4, d0                                       ; $0175F2
        move.w       #$2, d2                                       ; $0175F6
        jmp          DrawActorAnimation.l                          ; $0175FA

loc_017600:
        move.w       #$4, d0                                       ; $017600
        move.w       #$3, d2                                       ; $017604
        jmp          DrawActorAnimation.l                          ; $017608

loc_01760E:
        move.w       #$4, d0                                       ; $01760E
        move.w       #$4, d2                                       ; $017612
        jmp          DrawActorAnimation.l                          ; $017616

loc_01761C:
        move.b       ActorStateCounter(a0), d7                     ; $01761C
        cmpi.b       #$5, d7                                       ; $017620
        beq.b        loc_017640                                    ; $017624
        cmpi.b       #$4, d7                                       ; $017626
        beq.b        loc_01764E                                    ; $01762A
        cmpi.b       #$3, d7                                       ; $01762C
        beq.b        loc_01765C                                    ; $017630
        cmpi.b       #$2, d7                                       ; $017632
        beq.b        loc_01766A                                    ; $017636
        cmpi.b       #$1, d7                                       ; $017638
        beq.b        loc_017678                                    ; $01763C
        rts                                                        ; $01763E

loc_017640:
        move.w       #$4, d0                                       ; $017640
        move.w       #$1, d2                                       ; $017644
        jmp          DrawActorAnimation.l                          ; $017648

loc_01764E:
        move.w       #$4, d0                                       ; $01764E
        move.w       #$2, d2                                       ; $017652
        jmp          DrawActorAnimation.l                          ; $017656

loc_01765C:
        move.w       #$4, d0                                       ; $01765C
        move.w       #$3, d2                                       ; $017660
        jmp          DrawActorAnimation.l                          ; $017664

loc_01766A:
        move.w       #$4, d0                                       ; $01766A
        move.w       #$4, d2                                       ; $01766E
        jmp          DrawActorAnimation.l                          ; $017672

loc_017678:
        move.w       #$4, d0                                       ; $017678
        move.w       #$5, d2                                       ; $01767C
        jmp          DrawActorAnimation.l                          ; $017680

loc_017686:
        move.b       ActorStateCounter(a0), d7                     ; $017686
        cmpi.b       #$9, d7                                       ; $01768A
        beq.b        loc_0176C2                                    ; $01768E
        cmpi.b       #$8, d7                                       ; $017690
        beq.b        loc_0176C2                                    ; $017694
        cmpi.b       #$7, d7                                       ; $017696
        beq.b        loc_0176D0                                    ; $01769A
        cmpi.b       #$6, d7                                       ; $01769C
        beq.b        loc_0176D0                                    ; $0176A0
        cmpi.b       #$5, d7                                       ; $0176A2
        beq.b        loc_0176DE                                    ; $0176A6
        cmpi.b       #$4, d7                                       ; $0176A8
        beq.b        loc_0176D0                                    ; $0176AC
        cmpi.b       #$3, d7                                       ; $0176AE
        beq.b        loc_0176D0                                    ; $0176B2
        cmpi.b       #$2, d7                                       ; $0176B4
        beq.b        loc_0176C2                                    ; $0176B8
        cmpi.b       #$1, d7                                       ; $0176BA
        beq.b        loc_0176C2                                    ; $0176BE
        rts                                                        ; $0176C0

loc_0176C2:
        move.w       #$1, d0                                       ; $0176C2
        move.w       #$1, d2                                       ; $0176C6
        jmp          DrawActorAnimation.l                          ; $0176CA

loc_0176D0:
        move.w       #$1, d0                                       ; $0176D0
        move.w       #$2, d2                                       ; $0176D4
        jmp          DrawActorAnimation.l                          ; $0176D8

loc_0176DE:
        move.w       #$1, d0                                       ; $0176DE
        move.w       #$3, d2                                       ; $0176E2
        jmp          DrawActorAnimation.l                          ; $0176E6
        ifne *-$176EC
        fail "ROM end moved"
        endif
