; $0195EA..$0196AD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Full damage, states2/5/6 immune. Both0B/0D->5/8;05->7/1. Special modes ignore surviving positive HP. Statistics before distance rejection.
        ifne *-$195EA
        fail "ROM start moved"
        endif

HitLarvaCreature:
; Full damage, states2/5/6 immune. Both0B/0D->5/8;05->7/1. Special modes ignore surviving positive HP. Statistics before distance rejection.
        cmpi.b       #$2, ActorState(a0)                           ; $0195EA
        beq.w        loc_01960C                                    ; $0195F0
        cmpi.b       #$5, ActorState(a0)                           ; $0195F4
        beq.w        loc_01960C                                    ; $0195FA
        cmpi.b       #$6, ActorState(a0)                           ; $0195FE
        beq.w        loc_01960C                                    ; $019604
        bra.w        loc_01960E                                    ; $019608

loc_01960C:
        rts                                                        ; $01960C

loc_01960E:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $01960E
        clr.b        ActorStateCounter(a0)                         ; $019612
        clr.w        ActorMotionX(a0)                              ; $019616
        clr.w        ActorMotionY(a0)                              ; $01961A
        neg.w        d3                                            ; $01961E
        neg.w        d4                                            ; $019620
        move.w       d0, -(a7)                                     ; $019622
        move.w       d3, d0                                        ; $019624
        move.w       d4, d1                                        ; $019626
        jsr          OctagonalDistance.l                           ; $019628
        ext.l        d3                                            ; $01962E
        ext.l        d4                                            ; $019630
        lsl.l        #$8, d3                                       ; $019632
        lsl.l        #$8, d4                                       ; $019634
        addq.w       #$1, d0                                       ; $019636
        beq.b        loc_01963E                                    ; $019638
        divs.w       d0, d3                                        ; $01963A
        divs.w       d0, d4                                        ; $01963C

loc_01963E:
        move.w       #$400, d0                                     ; $01963E
        sub.w        (a7)+, d0                                     ; $019642
        bmi.b        loc_019682                                    ; $019644
        sub.w        d0, ActorHealth(a0)                           ; $019646
        bsr.w        SpawnHitParticles                          ; $01964A
        asr.w        #$3, d0                                       ; $01964E
        muls.w       d0, d3                                        ; $019650
        muls.w       d0, d4                                        ; $019652
        asr.l        #$8, d3                                       ; $019654
        asr.l        #$8, d4                                       ; $019656
        move.w       d3, ActorMotionX(a0)                          ; $019658
        move.w       d4, ActorMotionY(a0)                          ; $01965C
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $019660
        beq.b        loc_019684                                    ; $019666
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $019668
        beq.w        loc_019692                                    ; $01966E
        cmpi.b       #$5, rCurrentWeaponId(a6)                     ; $019672
        beq.w        loc_0196A0                                    ; $019678
        move.b       #$2, ActorState(a0)                           ; $01967C

loc_019682:
        rts                                                        ; $019682

loc_019684:
        move.b       #$5, ActorState(a0)                           ; $019684
        move.b       #$8, ActorStateCounter(a0)                    ; $01968A
        rts                                                        ; $019690

loc_019692:
        move.b       #$5, ActorState(a0)                           ; $019692
        move.b       #$8, ActorStateCounter(a0)                    ; $019698
        rts                                                        ; $01969E

loc_0196A0:
        move.b       #$7, ActorState(a0)                           ; $0196A0
        move.b       #$1, ActorStateCounter(a0)                    ; $0196A6
        rts                                                        ; $0196AC
        ifne *-$196AE
        fail "ROM end moved"
        endif
