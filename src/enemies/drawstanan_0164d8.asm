; $0164D8..$01666D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Stanan animation/frame selection matches Blood Body: walk0, attack2, recoil7/5, weapon deaths6/3. Animation1 is not selected by these local draw callbacks.
        ifne *-$164D8
        fail "ROM start moved"
        endif

DrawStanan:
; Stanan animation/frame selection matches Blood Body: walk0, attack2, recoil7/5, weapon deaths6/3. Animation1 is not selected by these local draw callbacks.
        move.b       ActorState(a0), d7                            ; $0164D8
        cmpi.b       #$2, d7                                       ; $0164DC
        beq.b        loc_016506                                    ; $0164E0
        cmpi.b       #$1, d7                                       ; $0164E2
        beq.w        loc_016608                                    ; $0164E6
        cmpi.b       #$5, d7                                       ; $0164EA
        beq.b        loc_016528                                    ; $0164EE
        cmpi.b       #$6, d7                                       ; $0164F0
        beq.w        loc_01659E                                    ; $0164F4
        move.w       #$0, d0                                       ; $0164F8
        move.w       #$ffff, d2                                    ; $0164FC
        jmp          DrawActorAnimation.l                          ; $016500

loc_016506:
        tst.w        ActorHealth(a0)                               ; $016506
        bmi.b        loc_01651A                                    ; $01650A
        move.w       #$7, d0                                       ; $01650C
        move.w       #$1, d2                                       ; $016510
        jmp          DrawActorAnimation.l                          ; $016514

loc_01651A:
        move.w       #$5, d0                                       ; $01651A
        move.w       #$1, d2                                       ; $01651E
        jmp          DrawActorAnimation.l                          ; $016522

loc_016528:
        move.b       ActorStateCounter(a0), d7                     ; $016528
        cmpi.b       #$7, d7                                       ; $01652C
        beq.b        loc_016558                                    ; $016530
        cmpi.b       #$6, d7                                       ; $016532
        beq.b        loc_016558                                    ; $016536
        cmpi.b       #$5, d7                                       ; $016538
        beq.b        loc_016566                                    ; $01653C
        cmpi.b       #$4, d7                                       ; $01653E
        beq.b        loc_016566                                    ; $016542
        cmpi.b       #$3, d7                                       ; $016544
        beq.b        loc_016574                                    ; $016548
        cmpi.b       #$2, d7                                       ; $01654A
        beq.b        loc_016582                                    ; $01654E
        cmpi.b       #$1, d7                                       ; $016550
        beq.b        loc_016590                                    ; $016554
        rts                                                        ; $016556

loc_016558:
        move.w       #$7, d0                                       ; $016558
        move.w       #$1, d2                                       ; $01655C
        jmp          DrawActorAnimation.l                          ; $016560

loc_016566:
        move.w       #$6, d0                                       ; $016566
        move.w       #$1, d2                                       ; $01656A
        jmp          DrawActorAnimation.l                          ; $01656E

loc_016574:
        move.w       #$6, d0                                       ; $016574
        move.w       #$2, d2                                       ; $016578
        jmp          DrawActorAnimation.l                          ; $01657C

loc_016582:
        move.w       #$6, d0                                       ; $016582
        move.w       #$3, d2                                       ; $016586
        jmp          DrawActorAnimation.l                          ; $01658A

loc_016590:
        move.w       #$6, d0                                       ; $016590
        move.w       #$4, d2                                       ; $016594
        jmp          DrawActorAnimation.l                          ; $016598

loc_01659E:
        move.b       ActorStateCounter(a0), d7                     ; $01659E
        cmpi.b       #$5, d7                                       ; $0165A2
        beq.b        loc_0165C2                                    ; $0165A6
        cmpi.b       #$4, d7                                       ; $0165A8
        beq.b        loc_0165D0                                    ; $0165AC
        cmpi.b       #$3, d7                                       ; $0165AE
        beq.b        loc_0165DE                                    ; $0165B2
        cmpi.b       #$2, d7                                       ; $0165B4
        beq.b        loc_0165EC                                    ; $0165B8
        cmpi.b       #$1, d7                                       ; $0165BA
        beq.b        loc_0165FA                                    ; $0165BE
        rts                                                        ; $0165C0

loc_0165C2:
        move.w       #$3, d0                                       ; $0165C2
        move.w       #$1, d2                                       ; $0165C6
        jmp          DrawActorAnimation.l                          ; $0165CA

loc_0165D0:
        move.w       #$3, d0                                       ; $0165D0
        move.w       #$2, d2                                       ; $0165D4
        jmp          DrawActorAnimation.l                          ; $0165D8

loc_0165DE:
        move.w       #$3, d0                                       ; $0165DE
        move.w       #$3, d2                                       ; $0165E2
        jmp          DrawActorAnimation.l                          ; $0165E6

loc_0165EC:
        move.w       #$3, d0                                       ; $0165EC
        move.w       #$4, d2                                       ; $0165F0
        jmp          DrawActorAnimation.l                          ; $0165F4

loc_0165FA:
        move.w       #$3, d0                                       ; $0165FA
        move.w       #$5, d2                                       ; $0165FE
        jmp          DrawActorAnimation.l                          ; $016602

loc_016608:
        move.b       ActorStateCounter(a0), d7                     ; $016608
        cmpi.b       #$9, d7                                       ; $01660C
        beq.b        loc_016644                                    ; $016610
        cmpi.b       #$8, d7                                       ; $016612
        beq.b        loc_016644                                    ; $016616
        cmpi.b       #$7, d7                                       ; $016618
        beq.b        loc_016652                                    ; $01661C
        cmpi.b       #$6, d7                                       ; $01661E
        beq.b        loc_016652                                    ; $016622
        cmpi.b       #$5, d7                                       ; $016624
        beq.b        loc_016660                                    ; $016628
        cmpi.b       #$4, d7                                       ; $01662A
        beq.b        loc_016652                                    ; $01662E
        cmpi.b       #$3, d7                                       ; $016630
        beq.b        loc_016652                                    ; $016634
        cmpi.b       #$2, d7                                       ; $016636
        beq.b        loc_016644                                    ; $01663A
        cmpi.b       #$1, d7                                       ; $01663C
        beq.b        loc_016644                                    ; $016640
        rts                                                        ; $016642

loc_016644:
        move.w       #$2, d0                                       ; $016644
        move.w       #$1, d2                                       ; $016648
        jmp          DrawActorAnimation.l                          ; $01664C

loc_016652:
        move.w       #$2, d0                                       ; $016652
        move.w       #$2, d2                                       ; $016656
        jmp          DrawActorAnimation.l                          ; $01665A

loc_016660:
        move.w       #$2, d0                                       ; $016660
        move.w       #$3, d2                                       ; $016664
        jmp          DrawActorAnimation.l                          ; $016668
        ifne *-$1666E
        fail "ROM end moved"
        endif
