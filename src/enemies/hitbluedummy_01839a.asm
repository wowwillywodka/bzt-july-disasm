; $01839A..$01845D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Full damage=$400-D0, signed-negative result rejected AFTER statistic/counter/motion changes. States2/5/6 ignore. Weapon0D->5/8,0B->6/6,05->7/1, independent of remaining HP.
        ifne *-$1839A
        fail "ROM start moved"
        endif

HitBlueDummy:
; Full damage=$400-D0, signed-negative result rejected AFTER statistic/counter/motion changes. States2/5/6 ignore. Weapon0D->5/8,0B->6/6,05->7/1, independent of remaining HP.
        cmpi.b       #$2, ActorState(a0)                           ; $01839A
        beq.w        loc_0183BC                                    ; $0183A0
        cmpi.b       #$5, ActorState(a0)                           ; $0183A4
        beq.w        loc_0183BC                                    ; $0183AA
        cmpi.b       #$6, ActorState(a0)                           ; $0183AE
        beq.w        loc_0183BC                                    ; $0183B4
        bra.w        loc_0183BE                                    ; $0183B8

loc_0183BC:
        rts                                                        ; $0183BC

loc_0183BE:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $0183BE
        clr.b        ActorStateCounter(a0)                         ; $0183C2
        clr.w        ActorMotionX(a0)                              ; $0183C6
        clr.w        ActorMotionY(a0)                              ; $0183CA
        neg.w        d3                                            ; $0183CE
        neg.w        d4                                            ; $0183D0
        move.w       d0, -(a7)                                     ; $0183D2
        move.w       d3, d0                                        ; $0183D4
        move.w       d4, d1                                        ; $0183D6
        jsr          OctagonalDistance.l                           ; $0183D8
        ext.l        d3                                            ; $0183DE
        ext.l        d4                                            ; $0183E0
        lsl.l        #$8, d3                                       ; $0183E2
        lsl.l        #$8, d4                                       ; $0183E4
        addq.w       #$1, d0                                       ; $0183E6
        beq.b        loc_0183EE                                    ; $0183E8
        divs.w       d0, d3                                        ; $0183EA
        divs.w       d0, d4                                        ; $0183EC

loc_0183EE:
        move.w       #$400, d0                                     ; $0183EE
        sub.w        (a7)+, d0                                     ; $0183F2
        bmi.b        loc_018432                                    ; $0183F4
        sub.w        d0, ActorHealth(a0)                           ; $0183F6
        bsr.w        SpawnHitParticles                          ; $0183FA
        asr.w        #$3, d0                                       ; $0183FE
        muls.w       d0, d3                                        ; $018400
        muls.w       d0, d4                                        ; $018402
        asr.l        #$8, d3                                       ; $018404
        asr.l        #$8, d4                                       ; $018406
        move.w       d3, ActorMotionX(a0)                          ; $018408
        move.w       d4, ActorMotionY(a0)                          ; $01840C
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $018410
        beq.b        loc_018434                                    ; $018416
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $018418
        beq.w        loc_018442                                    ; $01841E
        cmpi.b       #$5, rCurrentWeaponId(a6)                     ; $018422
        beq.w        loc_018450                                    ; $018428
        move.b       #$2, ActorState(a0)                           ; $01842C

loc_018432:
        rts                                                        ; $018432

loc_018434:
        move.b       #$5, ActorState(a0)                           ; $018434
        move.b       #$8, ActorStateCounter(a0)                    ; $01843A
        rts                                                        ; $018440

loc_018442:
        move.b       #$6, ActorState(a0)                           ; $018442
        move.b       #$6, ActorStateCounter(a0)                    ; $018448
        rts                                                        ; $01844E

loc_018450:
        move.b       #$7, ActorState(a0)                           ; $018450
        move.b       #$1, ActorStateCounter(a0)                    ; $018456
        rts                                                        ; $01845C
        ifne *-$1845E
        fail "ROM end moved"
        endif
