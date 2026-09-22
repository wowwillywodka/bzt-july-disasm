; $018D62..$018DA9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes impulse/counter only. Unlike Larva, Dog corpse countdown runs in update.
        ifne *-$18D62
        fail "ROM start moved"
        endif

HitDogCorpse:
; Corpse hit changes impulse/counter only. Unlike Larva, Dog corpse countdown runs in update.
        clr.w        ActorMotionX(a0)                              ; $018D62
        clr.w        ActorMotionY(a0)                              ; $018D66
        neg.w        d3                                            ; $018D6A
        neg.w        d4                                            ; $018D6C
        move.w       d0, -(a7)                                     ; $018D6E
        move.w       d3, d0                                        ; $018D70
        move.w       d4, d1                                        ; $018D72
        jsr          OctagonalDistance.l                           ; $018D74
        ext.l        d3                                            ; $018D7A
        ext.l        d4                                            ; $018D7C
        lsl.l        #$8, d3                                       ; $018D7E
        lsl.l        #$8, d4                                       ; $018D80
        addq.w       #$1, d0                                       ; $018D82
        beq.b        loc_018D8A                                    ; $018D84
        divs.w       d0, d3                                        ; $018D86
        divs.w       d0, d4                                        ; $018D88

loc_018D8A:
        move.w       #$400, d0                                     ; $018D8A
        sub.w        (a7)+, d0                                     ; $018D8E
        bmi.b        loc_018DA8                                    ; $018D90
        asr.w        #$4, d0                                       ; $018D92
        muls.w       d0, d3                                        ; $018D94
        muls.w       d0, d4                                        ; $018D96
        asr.l        #$8, d3                                       ; $018D98
        asr.l        #$8, d4                                       ; $018D9A
        move.w       d3, ActorMotionX(a0)                          ; $018D9C
        move.w       d4, ActorMotionY(a0)                          ; $018DA0
        addq.b       #$1, ActorStateCounter(a0)                    ; $018DA4

loc_018DA8:
        rts                                                        ; $018DA8
        ifne *-$18DAA
        fail "ROM end moved"
        endif
