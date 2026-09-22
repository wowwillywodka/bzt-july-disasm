; $017998..$0179DF | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$17998
        fail "ROM start moved"
        endif

HitGreenDummyCorpse:
        clr.w        ActorMotionX(a0)                              ; $017998
        clr.w        ActorMotionY(a0)                              ; $01799C
        neg.w        d3                                            ; $0179A0
        neg.w        d4                                            ; $0179A2
        move.w       d0, -(a7)                                     ; $0179A4
        move.w       d3, d0                                        ; $0179A6
        move.w       d4, d1                                        ; $0179A8
        jsr          OctagonalDistance.l                           ; $0179AA
        ext.l        d3                                            ; $0179B0
        ext.l        d4                                            ; $0179B2
        lsl.l        #$8, d3                                       ; $0179B4
        lsl.l        #$8, d4                                       ; $0179B6
        addq.w       #$1, d0                                       ; $0179B8
        beq.b        loc_0179C0                                    ; $0179BA
        divs.w       d0, d3                                        ; $0179BC
        divs.w       d0, d4                                        ; $0179BE

loc_0179C0:
        move.w       #$400, d0                                     ; $0179C0
        sub.w        (a7)+, d0                                     ; $0179C4
        bmi.b        loc_0179DE                                    ; $0179C6
        asr.w        #$4, d0                                       ; $0179C8
        muls.w       d0, d3                                        ; $0179CA
        muls.w       d0, d4                                        ; $0179CC
        asr.l        #$8, d3                                       ; $0179CE
        asr.l        #$8, d4                                       ; $0179D0
        move.w       d3, ActorMotionX(a0)                          ; $0179D2
        move.w       d4, ActorMotionY(a0)                          ; $0179D6
        addq.b       #$1, ActorStateCounter(a0)                    ; $0179DA

loc_0179DE:
        rts                                                        ; $0179DE
        ifne *-$179E0
        fail "ROM end moved"
        endif
