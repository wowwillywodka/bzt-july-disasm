; $01691A..$016961 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes recoil/counter but not HP, like Blood Body.
        ifne *-$1691A
        fail "ROM start moved"
        endif

HitStananCorpse:
; Corpse hit changes recoil/counter but not HP, like Blood Body.
        clr.w        ActorMotionX(a0)                              ; $01691A
        clr.w        ActorMotionY(a0)                              ; $01691E
        neg.w        d3                                            ; $016922
        neg.w        d4                                            ; $016924
        move.w       d0, -(a7)                                     ; $016926
        move.w       d3, d0                                        ; $016928
        move.w       d4, d1                                        ; $01692A
        jsr          OctagonalDistance.l                           ; $01692C
        ext.l        d3                                            ; $016932
        ext.l        d4                                            ; $016934
        lsl.l        #$8, d3                                       ; $016936
        lsl.l        #$8, d4                                       ; $016938
        addq.w       #$1, d0                                       ; $01693A
        beq.b        loc_016942                                    ; $01693C
        divs.w       d0, d3                                        ; $01693E
        divs.w       d0, d4                                        ; $016940

loc_016942:
        move.w       #$400, d0                                     ; $016942
        sub.w        (a7)+, d0                                     ; $016946
        bmi.b        loc_016960                                    ; $016948
        asr.w        #$4, d0                                       ; $01694A
        muls.w       d0, d3                                        ; $01694C
        muls.w       d0, d4                                        ; $01694E
        asr.l        #$8, d3                                       ; $016950
        asr.l        #$8, d4                                       ; $016952
        move.w       d3, ActorMotionX(a0)                          ; $016954
        move.w       d4, ActorMotionY(a0)                          ; $016958
        addq.b       #$1, ActorStateCounter(a0)                    ; $01695C

loc_016960:
        rts                                                        ; $016960
        ifne *-$16962
        fail "ROM end moved"
        endif
