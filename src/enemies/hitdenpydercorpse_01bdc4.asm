; $01BDC4..$01BE0B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes motion/counter only, never makes corpse State3.
        ifne *-$1BDC4
        fail "ROM start moved"
        endif

HitDenpyderCorpse:
; Corpse hit changes motion/counter only, never makes corpse State3.
        clr.w        ActorMotionX(a0)                              ; $01BDC4
        clr.w        ActorMotionY(a0)                              ; $01BDC8
        neg.w        d3                                            ; $01BDCC
        neg.w        d4                                            ; $01BDCE
        move.w       d0, -(a7)                                     ; $01BDD0
        move.w       d3, d0                                        ; $01BDD2
        move.w       d4, d1                                        ; $01BDD4
        jsr          OctagonalDistance.l                           ; $01BDD6
        ext.l        d3                                            ; $01BDDC
        ext.l        d4                                            ; $01BDDE
        lsl.l        #$8, d3                                       ; $01BDE0
        lsl.l        #$8, d4                                       ; $01BDE2
        addq.w       #$1, d0                                       ; $01BDE4
        beq.b        loc_01BDEC                                    ; $01BDE6
        divs.w       d0, d3                                        ; $01BDE8
        divs.w       d0, d4                                        ; $01BDEA

loc_01BDEC:
        move.w       #$400, d0                                     ; $01BDEC
        sub.w        (a7)+, d0                                     ; $01BDF0
        bmi.b        loc_01BE0A                                    ; $01BDF2
        asr.w        #$4, d0                                       ; $01BDF4
        muls.w       d0, d3                                        ; $01BDF6
        muls.w       d0, d4                                        ; $01BDF8
        asr.l        #$8, d3                                       ; $01BDFA
        asr.l        #$8, d4                                       ; $01BDFC
        move.w       d3, ActorMotionX(a0)                          ; $01BDFE
        move.w       d4, ActorMotionY(a0)                          ; $01BE02
        addq.b       #$1, ActorStateCounter(a0)                    ; $01BE06

loc_01BE0A:
        rts                                                        ; $01BE0A
        ifne *-$1BE0C
        fail "ROM end moved"
        endif
