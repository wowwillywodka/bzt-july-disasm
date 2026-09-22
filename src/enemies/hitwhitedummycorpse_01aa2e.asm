; $01AA2E..$01AA75 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes Motion/counter, not HP. Following shared alternate-death setup is a separate procedure.
        ifne *-$1AA2E
        fail "ROM start moved"
        endif

HitWhiteDummyCorpse:
; Corpse hit changes Motion/counter, not HP. Following shared alternate-death setup is a separate procedure.
        clr.w        ActorMotionX(a0)                              ; $01AA2E
        clr.w        ActorMotionY(a0)                              ; $01AA32
        neg.w        d3                                            ; $01AA36
        neg.w        d4                                            ; $01AA38
        move.w       d0, -(a7)                                     ; $01AA3A
        move.w       d3, d0                                        ; $01AA3C
        move.w       d4, d1                                        ; $01AA3E
        jsr          OctagonalDistance.l                           ; $01AA40
        ext.l        d3                                            ; $01AA46
        ext.l        d4                                            ; $01AA48
        lsl.l        #$8, d3                                       ; $01AA4A
        lsl.l        #$8, d4                                       ; $01AA4C
        addq.w       #$1, d0                                       ; $01AA4E
        beq.b        loc_01AA56                                    ; $01AA50
        divs.w       d0, d3                                        ; $01AA52
        divs.w       d0, d4                                        ; $01AA54

loc_01AA56:
        move.w       #$400, d0                                     ; $01AA56
        sub.w        (a7)+, d0                                     ; $01AA5A
        bmi.b        loc_01AA74                                    ; $01AA5C
        asr.w        #$4, d0                                       ; $01AA5E
        muls.w       d0, d3                                        ; $01AA60
        muls.w       d0, d4                                        ; $01AA62
        asr.l        #$8, d3                                       ; $01AA64
        asr.l        #$8, d4                                       ; $01AA66
        move.w       d3, ActorMotionX(a0)                          ; $01AA68
        move.w       d4, ActorMotionY(a0)                          ; $01AA6C
        addq.b       #$1, ActorStateCounter(a0)                    ; $01AA70

loc_01AA74:
        rts                                                        ; $01AA74
        ifne *-$1AA76
        fail "ROM end moved"
        endif
