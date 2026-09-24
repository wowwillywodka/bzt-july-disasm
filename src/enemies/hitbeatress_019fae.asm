; $019FAE..$01A059 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Full incoming damage=$400-D0; statistics before range rejection; states2/5/6 ignore. Both weapon0B/0D force state5/counter8 even with positive HP.
        ifne *-$19FAE
        fail "ROM start moved"
        endif

HitBeatress:
; Full incoming damage=$400-D0; statistics before range rejection; states2/5/6 ignore. Both weapon0B/0D force state5/counter8 even with positive HP.
        cmpi.b       #$2, ActorState(a0)                           ; $019FAE
        beq.w        loc_019FD0                                    ; $019FB4
        cmpi.b       #$5, ActorState(a0)                           ; $019FB8
        beq.w        loc_019FD0                                    ; $019FBE
        cmpi.b       #$6, ActorState(a0)                           ; $019FC2
        beq.w        loc_019FD0                                    ; $019FC8
        bra.w        loc_019FD2                                    ; $019FCC

loc_019FD0:
        rts                                                        ; $019FD0

loc_019FD2:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $019FD2
        clr.b        ActorStateCounter(a0)                         ; $019FD6
        clr.w        ActorMotionX(a0)                              ; $019FDA
        clr.w        ActorMotionY(a0)                              ; $019FDE
        neg.w        d3                                            ; $019FE2
        neg.w        d4                                            ; $019FE4
        move.w       d0, -(a7)                                     ; $019FE6
        move.w       d3, d0                                        ; $019FE8
        move.w       d4, d1                                        ; $019FEA
        jsr          OctagonalDistance.l                           ; $019FEC
        ext.l        d3                                            ; $019FF2
        ext.l        d4                                            ; $019FF4
        lsl.l        #$8, d3                                       ; $019FF6
        lsl.l        #$8, d4                                       ; $019FF8
        addq.w       #$1, d0                                       ; $019FFA
        beq.b        loc_01A002                                    ; $019FFC
        divs.w       d0, d3                                        ; $019FFE
        divs.w       d0, d4                                        ; $01A000

loc_01A002:
        move.w       #$400, d0                                     ; $01A002
        sub.w        (a7)+, d0                                     ; $01A006
        bmi.b        loc_01A03C                                    ; $01A008
        sub.w        d0, ActorHealth(a0)                           ; $01A00A
        bsr.w        SpawnHitParticles                          ; $01A00E
        asr.w        #$3, d0                                       ; $01A012
        muls.w       d0, d3                                        ; $01A014
        muls.w       d0, d4                                        ; $01A016
        asr.l        #$8, d3                                       ; $01A018
        asr.l        #$8, d4                                       ; $01A01A
        move.w       d3, ActorMotionX(a0)                          ; $01A01C
        move.w       d4, ActorMotionY(a0)                          ; $01A020
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $01A024
        beq.b        loc_01A03E                                    ; $01A02A
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $01A02C
        beq.w        loc_01A04C                                    ; $01A032
        move.b       #$2, ActorState(a0)                           ; $01A036

loc_01A03C:
        rts                                                        ; $01A03C

loc_01A03E:
        move.b       #$5, ActorState(a0)                           ; $01A03E
        move.b       #$8, ActorStateCounter(a0)                    ; $01A044
        rts                                                        ; $01A04A

loc_01A04C:
        move.b       #$5, ActorState(a0)                           ; $01A04C
        move.b       #$8, ActorStateCounter(a0)                    ; $01A052
        rts                                                        ; $01A058
        ifne *-$1A05A
        fail "ROM end moved"
        endif
