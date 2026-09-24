; $018C9E..$018D61 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Full damage, states2/5/6 immune. Both0B/0D->state5/counter8; weapon05->state0C/counter1 (next update CE corpse), even if HP positive.
        ifne *-$18C9E
        fail "ROM start moved"
        endif

HitDog:
; Full damage, states2/5/6 immune. Both0B/0D->state5/counter8; weapon05->state0C/counter1 (next update CE corpse), even if HP positive.
        cmpi.b       #$2, ActorState(a0)                           ; $018C9E
        beq.w        loc_018CC0                                    ; $018CA4
        cmpi.b       #$5, ActorState(a0)                           ; $018CA8
        beq.w        loc_018CC0                                    ; $018CAE
        cmpi.b       #$6, ActorState(a0)                           ; $018CB2
        beq.w        loc_018CC0                                    ; $018CB8
        bra.w        loc_018CC2                                    ; $018CBC

loc_018CC0:
        rts                                                        ; $018CC0

loc_018CC2:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $018CC2
        clr.b        ActorStateCounter(a0)                         ; $018CC6
        clr.w        ActorMotionX(a0)                              ; $018CCA
        clr.w        ActorMotionY(a0)                              ; $018CCE
        neg.w        d3                                            ; $018CD2
        neg.w        d4                                            ; $018CD4
        move.w       d0, -(a7)                                     ; $018CD6
        move.w       d3, d0                                        ; $018CD8
        move.w       d4, d1                                        ; $018CDA
        jsr          OctagonalDistance.l                           ; $018CDC
        ext.l        d3                                            ; $018CE2
        ext.l        d4                                            ; $018CE4
        lsl.l        #$8, d3                                       ; $018CE6
        lsl.l        #$8, d4                                       ; $018CE8
        addq.w       #$1, d0                                       ; $018CEA
        beq.b        loc_018CF2                                    ; $018CEC
        divs.w       d0, d3                                        ; $018CEE
        divs.w       d0, d4                                        ; $018CF0

loc_018CF2:
        move.w       #$400, d0                                     ; $018CF2
        sub.w        (a7)+, d0                                     ; $018CF6
        bmi.b        loc_018D36                                    ; $018CF8
        sub.w        d0, ActorHealth(a0)                           ; $018CFA
        bsr.w        SpawnHitParticles                          ; $018CFE
        asr.w        #$3, d0                                       ; $018D02
        muls.w       d0, d3                                        ; $018D04
        muls.w       d0, d4                                        ; $018D06
        asr.l        #$8, d3                                       ; $018D08
        asr.l        #$8, d4                                       ; $018D0A
        move.w       d3, ActorMotionX(a0)                          ; $018D0C
        move.w       d4, ActorMotionY(a0)                          ; $018D10
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $018D14
        beq.b        loc_018D38                                    ; $018D1A
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $018D1C
        beq.w        loc_018D46                                    ; $018D22
        cmpi.b       #$5, rCurrentWeaponId(a6)                     ; $018D26
        beq.w        loc_018D54                                    ; $018D2C
        move.b       #$2, ActorState(a0)                           ; $018D30

loc_018D36:
        rts                                                        ; $018D36

loc_018D38:
        move.b       #$5, ActorState(a0)                           ; $018D38
        move.b       #$8, ActorStateCounter(a0)                    ; $018D3E
        rts                                                        ; $018D44

loc_018D46:
        move.b       #$5, ActorState(a0)                           ; $018D46
        move.b       #$8, ActorStateCounter(a0)                    ; $018D4C
        rts                                                        ; $018D52

loc_018D54:
        move.b       #$c, ActorState(a0)                           ; $018D54
        move.b       #$1, ActorStateCounter(a0)                    ; $018D5A
        rts                                                        ; $018D60
        ifne *-$18D62
        fail "ROM end moved"
        endif
