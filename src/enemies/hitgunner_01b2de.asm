; $01B2DE..$01B38B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; States2/5/6 ignore hits; statistic before distance rejection. Damage=($400-inputD0) ASR1, so distance$3FF causes zero damage but still recoil/special death. Both weapons0B/0D force state5/counter8.
        ifne *-$1B2DE
        fail "ROM start moved"
        endif

HitGunner:
; States2/5/6 ignore hits; statistic before distance rejection. Damage=($400-inputD0) ASR1, so distance$3FF causes zero damage but still recoil/special death. Both weapons0B/0D force state5/counter8.
        cmpi.b       #$2, ActorState(a0)                           ; $01B2DE
        beq.w        loc_01B300                                    ; $01B2E4
        cmpi.b       #$5, ActorState(a0)                           ; $01B2E8
        beq.w        loc_01B300                                    ; $01B2EE
        cmpi.b       #$6, ActorState(a0)                           ; $01B2F2
        beq.w        loc_01B300                                    ; $01B2F8
        bra.w        loc_01B302                                    ; $01B2FC

loc_01B300:
        rts                                                        ; $01B300

loc_01B302:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $01B302
        clr.b        ActorStateCounter(a0)                         ; $01B306
        clr.w        ActorMotionX(a0)                              ; $01B30A
        clr.w        ActorMotionY(a0)                              ; $01B30E
        neg.w        d3                                            ; $01B312
        neg.w        d4                                            ; $01B314
        move.w       d0, -(a7)                                     ; $01B316
        move.w       d3, d0                                        ; $01B318
        move.w       d4, d1                                        ; $01B31A
        jsr          OctagonalDistance.l                           ; $01B31C
        ext.l        d3                                            ; $01B322
        ext.l        d4                                            ; $01B324
        lsl.l        #$8, d3                                       ; $01B326
        lsl.l        #$8, d4                                       ; $01B328
        addq.w       #$1, d0                                       ; $01B32A
        beq.b        loc_01B332                                    ; $01B32C
        divs.w       d0, d3                                        ; $01B32E
        divs.w       d0, d4                                        ; $01B330

loc_01B332:
        move.w       #$400, d0                                     ; $01B332
        sub.w        (a7)+, d0                                     ; $01B336
        bmi.b        loc_01B36E                                    ; $01B338
        asr.w        #$1, d0                                       ; $01B33A
        sub.w        d0, ActorHealth(a0)                           ; $01B33C
        bsr.w        SpawnHitParticles                          ; $01B340
        asr.w        #$3, d0                                       ; $01B344
        muls.w       d0, d3                                        ; $01B346
        muls.w       d0, d4                                        ; $01B348
        asr.l        #$8, d3                                       ; $01B34A
        asr.l        #$8, d4                                       ; $01B34C
        move.w       d3, ActorMotionX(a0)                          ; $01B34E
        move.w       d4, ActorMotionY(a0)                          ; $01B352
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $01B356
        beq.b        loc_01B370                                    ; $01B35C
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $01B35E
        beq.w        loc_01B37E                                    ; $01B364
        move.b       #$2, ActorState(a0)                           ; $01B368

loc_01B36E:
        rts                                                        ; $01B36E

loc_01B370:
        move.b       #$5, ActorState(a0)                           ; $01B370
        move.b       #$8, ActorStateCounter(a0)                    ; $01B376
        rts                                                        ; $01B37C

loc_01B37E:
        move.b       #$5, ActorState(a0)                           ; $01B37E
        move.b       #$8, ActorStateCounter(a0)                    ; $01B384
        rts                                                        ; $01B38A
        ifne *-$1B38C
        fail "ROM end moved"
        endif
