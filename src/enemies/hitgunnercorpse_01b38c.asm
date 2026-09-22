; $01B38C..$01B3D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse hit changes recoil and increments animation counter without changing HP; may delay draw-driven transition.
        ifne *-$1B38C
        fail "ROM start moved"
        endif

HitGunnerCorpse:
; Corpse hit changes recoil and increments animation counter without changing HP; may delay draw-driven transition.
        clr.w        ActorMotionX(a0)                              ; $01B38C
        clr.w        ActorMotionY(a0)                              ; $01B390
        neg.w        d3                                            ; $01B394
        neg.w        d4                                            ; $01B396
        move.w       d0, -(a7)                                     ; $01B398
        move.w       d3, d0                                        ; $01B39A
        move.w       d4, d1                                        ; $01B39C
        jsr          OctagonalDistance.l                           ; $01B39E
        ext.l        d3                                            ; $01B3A4
        ext.l        d4                                            ; $01B3A6
        lsl.l        #$8, d3                                       ; $01B3A8
        lsl.l        #$8, d4                                       ; $01B3AA
        addq.w       #$1, d0                                       ; $01B3AC
        beq.b        loc_01B3B4                                    ; $01B3AE
        divs.w       d0, d3                                        ; $01B3B0
        divs.w       d0, d4                                        ; $01B3B2

loc_01B3B4:
        move.w       #$400, d0                                     ; $01B3B4
        sub.w        (a7)+, d0                                     ; $01B3B8
        bmi.b        loc_01B3D2                                    ; $01B3BA
        asr.w        #$4, d0                                       ; $01B3BC
        muls.w       d0, d3                                        ; $01B3BE
        muls.w       d0, d4                                        ; $01B3C0
        asr.l        #$8, d3                                       ; $01B3C2
        asr.l        #$8, d4                                       ; $01B3C4
        move.w       d3, ActorMotionX(a0)                          ; $01B3C6
        move.w       d4, ActorMotionY(a0)                          ; $01B3CA
        addq.b       #$1, ActorStateCounter(a0)                    ; $01B3CE

loc_01B3D2:
        rts                                                        ; $01B3D2
        ifne *-$1B3D4
        fail "ROM end moved"
        endif
