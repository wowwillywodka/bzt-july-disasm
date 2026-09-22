; $0170FE..$017145 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$170FE
        fail "ROM start moved"
        endif

HitGreyDummyCorpse:
        clr.w        ActorMotionX(a0)                              ; $0170FE
        clr.w        ActorMotionY(a0)                              ; $017102
        neg.w        d3                                            ; $017106
        neg.w        d4                                            ; $017108
        move.w       d0, -(a7)                                     ; $01710A
        move.w       d3, d0                                        ; $01710C
        move.w       d4, d1                                        ; $01710E
        jsr          OctagonalDistance.l                           ; $017110
        ext.l        d3                                            ; $017116
        ext.l        d4                                            ; $017118
        lsl.l        #$8, d3                                       ; $01711A
        lsl.l        #$8, d4                                       ; $01711C
        addq.w       #$1, d0                                       ; $01711E
        beq.b        loc_017126                                    ; $017120
        divs.w       d0, d3                                        ; $017122
        divs.w       d0, d4                                        ; $017124

loc_017126:
        move.w       #$400, d0                                     ; $017126
        sub.w        (a7)+, d0                                     ; $01712A
        bmi.b        loc_017144                                    ; $01712C
        asr.w        #$4, d0                                       ; $01712E
        muls.w       d0, d3                                        ; $017130
        muls.w       d0, d4                                        ; $017132
        asr.l        #$8, d3                                       ; $017134
        asr.l        #$8, d4                                       ; $017136
        move.w       d3, ActorMotionX(a0)                          ; $017138
        move.w       d4, ActorMotionY(a0)                          ; $01713C
        addq.b       #$1, ActorStateCounter(a0)                    ; $017140

loc_017144:
        rts                                                        ; $017144
        ifne *-$17146
        fail "ROM end moved"
        endif
