; $01A982..$01AA2D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Normal damage=$400-inputD0; hit statistic increments before distance rejection. States2/5/6 ignore hit. BOTH weapon0B and0D set state5/counter8; neither assigns state6.
        ifne *-$1A982
        fail "ROM start moved"
        endif

HitWhiteDummy:
; Normal damage=$400-inputD0; hit statistic increments before distance rejection. States2/5/6 ignore hit. BOTH weapon0B and0D set state5/counter8; neither assigns state6.
        cmpi.b       #$2, ActorState(a0)                           ; $01A982
        beq.w        loc_01A9A4                                    ; $01A988
        cmpi.b       #$5, ActorState(a0)                           ; $01A98C
        beq.w        loc_01A9A4                                    ; $01A992
        cmpi.b       #$6, ActorState(a0)                           ; $01A996
        beq.w        loc_01A9A4                                    ; $01A99C
        bra.w        loc_01A9A6                                    ; $01A9A0

loc_01A9A4:
        rts                                                        ; $01A9A4

loc_01A9A6:
        addq.w       #$1, -$71c2(a6)                               ; $01A9A6
        clr.b        ActorStateCounter(a0)                         ; $01A9AA
        clr.w        ActorMotionX(a0)                              ; $01A9AE
        clr.w        ActorMotionY(a0)                              ; $01A9B2
        neg.w        d3                                            ; $01A9B6
        neg.w        d4                                            ; $01A9B8
        move.w       d0, -(a7)                                     ; $01A9BA
        move.w       d3, d0                                        ; $01A9BC
        move.w       d4, d1                                        ; $01A9BE
        jsr          OctagonalDistance.l                           ; $01A9C0
        ext.l        d3                                            ; $01A9C6
        ext.l        d4                                            ; $01A9C8
        lsl.l        #$8, d3                                       ; $01A9CA
        lsl.l        #$8, d4                                       ; $01A9CC
        addq.w       #$1, d0                                       ; $01A9CE
        beq.b        loc_01A9D6                                    ; $01A9D0
        divs.w       d0, d3                                        ; $01A9D2
        divs.w       d0, d4                                        ; $01A9D4

loc_01A9D6:
        move.w       #$400, d0                                     ; $01A9D6
        sub.w        (a7)+, d0                                     ; $01A9DA
        bmi.b        loc_01AA10                                    ; $01A9DC
        sub.w        d0, ActorHealth(a0)                           ; $01A9DE
        bsr.w        ActorsRoutine_01D92C                          ; $01A9E2
        asr.w        #$3, d0                                       ; $01A9E6
        muls.w       d0, d3                                        ; $01A9E8
        muls.w       d0, d4                                        ; $01A9EA
        asr.l        #$8, d3                                       ; $01A9EC
        asr.l        #$8, d4                                       ; $01A9EE
        move.w       d3, ActorMotionX(a0)                          ; $01A9F0
        move.w       d4, ActorMotionY(a0)                          ; $01A9F4
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $01A9F8
        beq.b        loc_01AA12                                    ; $01A9FE
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $01AA00
        beq.w        loc_01AA20                                    ; $01AA06
        move.b       #$2, ActorState(a0)                           ; $01AA0A

loc_01AA10:
        rts                                                        ; $01AA10

loc_01AA12:
        move.b       #$5, ActorState(a0)                           ; $01AA12
        move.b       #$8, ActorStateCounter(a0)                    ; $01AA18
        rts                                                        ; $01AA1E

loc_01AA20:
        move.b       #$5, ActorState(a0)                           ; $01AA20
        move.b       #$8, ActorStateCounter(a0)                    ; $01AA26
        rts                                                        ; $01AA2C
        ifne *-$1AA2E
        fail "ROM end moved"
        endif
