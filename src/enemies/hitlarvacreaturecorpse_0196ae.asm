; $0196AE..$0196F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse impulse/counter++; can prolong draw-driven transition. HP/state unchanged.
        ifne *-$196AE
        fail "ROM start moved"
        endif

HitLarvaCreatureCorpse:
; Corpse impulse/counter++; can prolong draw-driven transition. HP/state unchanged.
        clr.w        ActorMotionX(a0)                              ; $0196AE
        clr.w        ActorMotionY(a0)                              ; $0196B2
        neg.w        d3                                            ; $0196B6
        neg.w        d4                                            ; $0196B8
        move.w       d0, -(a7)                                     ; $0196BA
        move.w       d3, d0                                        ; $0196BC
        move.w       d4, d1                                        ; $0196BE
        jsr          OctagonalDistance.l                           ; $0196C0
        ext.l        d3                                            ; $0196C6
        ext.l        d4                                            ; $0196C8
        lsl.l        #$8, d3                                       ; $0196CA
        lsl.l        #$8, d4                                       ; $0196CC
        addq.w       #$1, d0                                       ; $0196CE
        beq.b        loc_0196D6                                    ; $0196D0
        divs.w       d0, d3                                        ; $0196D2
        divs.w       d0, d4                                        ; $0196D4

loc_0196D6:
        move.w       #$400, d0                                     ; $0196D6
        sub.w        (a7)+, d0                                     ; $0196DA
        bmi.b        loc_0196F4                                    ; $0196DC
        asr.w        #$4, d0                                       ; $0196DE
        muls.w       d0, d3                                        ; $0196E0
        muls.w       d0, d4                                        ; $0196E2
        asr.l        #$8, d3                                       ; $0196E4
        asr.l        #$8, d4                                       ; $0196E6
        move.w       d3, ActorMotionX(a0)                          ; $0196E8
        move.w       d4, ActorMotionY(a0)                          ; $0196EC
        addq.b       #$1, ActorStateCounter(a0)                    ; $0196F0

loc_0196F4:
        rts                                                        ; $0196F4
        ifne *-$196F6
        fail "ROM end moved"
        endif
