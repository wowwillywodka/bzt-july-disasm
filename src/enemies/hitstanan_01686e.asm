; $01686E..$016919 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ignores hits in states2/5/6. Unlike Blood Body, increments hit statistic BEFORE checking damage=$400-inputD0, even if input distance>$400 rejects damage.
        ifne *-$1686E
        fail "ROM start moved"
        endif

HitStanan:
; Ignores hits in states2/5/6. Unlike Blood Body, increments hit statistic BEFORE checking damage=$400-inputD0, even if input distance>$400 rejects damage.
        cmpi.b       #$2, ActorState(a0)                           ; $01686E
        beq.w        loc_016890                                    ; $016874
        cmpi.b       #$5, ActorState(a0)                           ; $016878
        beq.w        loc_016890                                    ; $01687E
        cmpi.b       #$6, ActorState(a0)                           ; $016882
        beq.w        loc_016890                                    ; $016888
        bra.w        loc_016892                                    ; $01688C

loc_016890:
        rts                                                        ; $016890

loc_016892:
        addq.w       #$1, -$71c2(a6)                               ; $016892
        clr.b        ActorStateCounter(a0)                         ; $016896
        clr.w        ActorMotionX(a0)                              ; $01689A
        clr.w        ActorMotionY(a0)                              ; $01689E
        neg.w        d3                                            ; $0168A2
        neg.w        d4                                            ; $0168A4
        move.w       d0, -(a7)                                     ; $0168A6
        move.w       d3, d0                                        ; $0168A8
        move.w       d4, d1                                        ; $0168AA
        jsr          OctagonalDistance.l                           ; $0168AC
        ext.l        d3                                            ; $0168B2
        ext.l        d4                                            ; $0168B4
        lsl.l        #$8, d3                                       ; $0168B6
        lsl.l        #$8, d4                                       ; $0168B8
        addq.w       #$1, d0                                       ; $0168BA
        beq.b        loc_0168C2                                    ; $0168BC
        divs.w       d0, d3                                        ; $0168BE
        divs.w       d0, d4                                        ; $0168C0

loc_0168C2:
        move.w       #$400, d0                                     ; $0168C2
        sub.w        (a7)+, d0                                     ; $0168C6
        bmi.b        loc_0168FC                                    ; $0168C8
        sub.w        d0, ActorHealth(a0)                           ; $0168CA
        bsr.w        ActorsRoutine_01D92C                          ; $0168CE
        asr.w        #$3, d0                                       ; $0168D2
        muls.w       d0, d3                                        ; $0168D4
        muls.w       d0, d4                                        ; $0168D6
        asr.l        #$8, d3                                       ; $0168D8
        asr.l        #$8, d4                                       ; $0168DA
        move.w       d3, ActorMotionX(a0)                          ; $0168DC
        move.w       d4, ActorMotionY(a0)                          ; $0168E0
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $0168E4
        beq.b        loc_0168FE                                    ; $0168EA
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $0168EC
        beq.w        loc_01690C                                    ; $0168F2
        move.b       #$2, ActorState(a0)                           ; $0168F6

loc_0168FC:
        rts                                                        ; $0168FC

loc_0168FE:
        move.b       #$5, ActorState(a0)                           ; $0168FE
        move.b       #$8, ActorStateCounter(a0)                    ; $016904
        rts                                                        ; $01690A

loc_01690C:
        move.b       #$6, ActorState(a0)                           ; $01690C
        move.b       #$6, ActorStateCounter(a0)                    ; $016912
        rts                                                        ; $016918
        ifne *-$1691A
        fail "ROM end moved"
        endif
