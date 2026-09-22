; $01A05A..$01A0A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes motion/counter without HP change. Following marker scanners are separate procedures.
        ifne *-$1A05A
        fail "ROM start moved"
        endif

HitBeatressCorpse:
; Corpse hit changes motion/counter without HP change. Following marker scanners are separate procedures.
        clr.w        ActorMotionX(a0)                              ; $01A05A
        clr.w        ActorMotionY(a0)                              ; $01A05E
        neg.w        d3                                            ; $01A062
        neg.w        d4                                            ; $01A064
        move.w       d0, -(a7)                                     ; $01A066
        move.w       d3, d0                                        ; $01A068
        move.w       d4, d1                                        ; $01A06A
        jsr          OctagonalDistance.l                           ; $01A06C
        ext.l        d3                                            ; $01A072
        ext.l        d4                                            ; $01A074
        lsl.l        #$8, d3                                       ; $01A076
        lsl.l        #$8, d4                                       ; $01A078
        addq.w       #$1, d0                                       ; $01A07A
        beq.b        loc_01A082                                    ; $01A07C
        divs.w       d0, d3                                        ; $01A07E
        divs.w       d0, d4                                        ; $01A080

loc_01A082:
        move.w       #$400, d0                                     ; $01A082
        sub.w        (a7)+, d0                                     ; $01A086
        bmi.b        loc_01A0A0                                    ; $01A088
        asr.w        #$4, d0                                       ; $01A08A
        muls.w       d0, d3                                        ; $01A08C
        muls.w       d0, d4                                        ; $01A08E
        asr.l        #$8, d3                                       ; $01A090
        asr.l        #$8, d4                                       ; $01A092
        move.w       d3, ActorMotionX(a0)                          ; $01A094
        move.w       d4, ActorMotionY(a0)                          ; $01A098
        addq.b       #$1, ActorStateCounter(a0)                    ; $01A09C

loc_01A0A0:
        rts                                                        ; $01A0A0
        ifne *-$1A0A2
        fail "ROM end moved"
        endif
