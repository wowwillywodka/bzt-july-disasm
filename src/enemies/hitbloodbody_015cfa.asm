; $015CFA..$015DA3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; States 2/5/6 ignore hits. Otherwise damage=$400-D0.w if signed result >=0; hit direction is normalized for recoil. Weapon byte $0D selects state5/8 ticks; $0B selects state6/6 ticks.
        ifne *-$15CFA
        fail "ROM start moved"
        endif

HitBloodBody:
; States 2/5/6 ignore hits. Otherwise damage=$400-D0.w if signed result >=0; hit direction is normalized for recoil. Weapon byte $0D selects state5/8 ticks; $0B selects state6/6 ticks.
        cmpi.b       #$2, ActorState(a0)                           ; $015CFA
        beq.w        loc_015D1C                                    ; $015D00
        cmpi.b       #$5, ActorState(a0)                           ; $015D04
        beq.w        loc_015D1C                                    ; $015D0A
        cmpi.b       #$6, ActorState(a0)                           ; $015D0E
        beq.w        loc_015D1C                                    ; $015D14
        bra.w        loc_015D1E                                    ; $015D18

loc_015D1C:
        rts                                                        ; $015D1C

loc_015D1E:
        clr.b        ActorStateCounter(a0)                         ; $015D1E
        clr.w        ActorMotionX(a0)                              ; $015D22
        clr.w        ActorMotionY(a0)                              ; $015D26
        neg.w        d3                                            ; $015D2A
        neg.w        d4                                            ; $015D2C
        move.w       d0, -(a7)                                     ; $015D2E
        move.w       d3, d0                                        ; $015D30
        move.w       d4, d1                                        ; $015D32
        jsr          OctagonalDistance(pc)                         ; $015D34
        ext.l        d3                                            ; $015D38
        ext.l        d4                                            ; $015D3A
        lsl.l        #$8, d3                                       ; $015D3C
        lsl.l        #$8, d4                                       ; $015D3E
        addq.w       #$1, d0                                       ; $015D40
        beq.b        loc_015D48                                    ; $015D42
        divs.w       d0, d3                                        ; $015D44
        divs.w       d0, d4                                        ; $015D46

loc_015D48:
        move.w       #$400, d0                                     ; $015D48
        sub.w        (a7)+, d0                                     ; $015D4C
        bmi.b        loc_015D86                                    ; $015D4E
        sub.w        d0, ActorHealth(a0)                           ; $015D50
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $015D54
        bsr.w        SpawnHitParticles                          ; $015D58
        asr.w        #$3, d0                                       ; $015D5C
        muls.w       d0, d3                                        ; $015D5E
        muls.w       d0, d4                                        ; $015D60
        asr.l        #$8, d3                                       ; $015D62
        asr.l        #$8, d4                                       ; $015D64
        move.w       d3, ActorMotionX(a0)                          ; $015D66
        move.w       d4, ActorMotionY(a0)                          ; $015D6A
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $015D6E
        beq.b        loc_015D88                                    ; $015D74
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $015D76
        beq.w        loc_015D96                                    ; $015D7C
        move.b       #$2, ActorState(a0)                           ; $015D80

loc_015D86:
        rts                                                        ; $015D86

loc_015D88:
        move.b       #$5, ActorState(a0)                           ; $015D88
        move.b       #$8, ActorStateCounter(a0)                    ; $015D8E
        rts                                                        ; $015D94

loc_015D96:
        move.b       #$6, ActorState(a0)                           ; $015D96
        move.b       #$6, ActorStateCounter(a0)                    ; $015D9C
        rts                                                        ; $015DA2
        ifne *-$15DA4
        fail "ROM end moved"
        endif
