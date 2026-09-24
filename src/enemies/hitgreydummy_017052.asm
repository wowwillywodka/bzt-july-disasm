; $017052..$0170FD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ignores states2/5/6. Hit statistic increments before rejecting distance>$400; accepted damage=$400-D0. Weapon0D/0B force states5/6 even with positive HP.
        ifne *-$17052
        fail "ROM start moved"
        endif

HitGreyDummy:
; A0=recipient, D0.w=hit parameter, D3/D4=impulse direction.
; Assigns reaction state here; corpse callbacks are installed by later update/death code.
; Ignores states2/5/6. Hit statistic increments before rejecting distance>$400; accepted damage=$400-D0. Weapon0D/0B force states5/6 even with positive HP.
        cmpi.b       #$2, ActorState(a0)                           ; $017052
        beq.w        loc_017074                                    ; $017058
        cmpi.b       #$5, ActorState(a0)                           ; $01705C
        beq.w        loc_017074                                    ; $017062
        cmpi.b       #$6, ActorState(a0)                           ; $017066
        beq.w        loc_017074                                    ; $01706C
        bra.w        loc_017076                                    ; $017070

loc_017074:
        rts                                                        ; $017074

loc_017076:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $017076
        clr.b        ActorStateCounter(a0)                         ; $01707A
        clr.w        ActorMotionX(a0)                              ; $01707E
        clr.w        ActorMotionY(a0)                              ; $017082
        neg.w        d3                                            ; $017086
        neg.w        d4                                            ; $017088
        move.w       d0, -(a7)                                     ; $01708A
        move.w       d3, d0                                        ; $01708C
        move.w       d4, d1                                        ; $01708E
        jsr          OctagonalDistance.l                           ; $017090
        ext.l        d3                                            ; $017096
        ext.l        d4                                            ; $017098
        lsl.l        #$8, d3                                       ; $01709A
        lsl.l        #$8, d4                                       ; $01709C
        addq.w       #$1, d0                                       ; $01709E
        beq.b        loc_0170A6                                    ; $0170A0
        divs.w       d0, d3                                        ; $0170A2
        divs.w       d0, d4                                        ; $0170A4

loc_0170A6:
        move.w       #$400, d0                                     ; $0170A6
        sub.w        (a7)+, d0                                     ; $0170AA
        bmi.b        loc_0170E0                                    ; $0170AC
        sub.w        d0, ActorHealth(a0)                           ; $0170AE
        bsr.w        SpawnHitParticles                          ; $0170B2
        asr.w        #$3, d0                                       ; $0170B6
        muls.w       d0, d3                                        ; $0170B8
        muls.w       d0, d4                                        ; $0170BA
        asr.l        #$8, d3                                       ; $0170BC
        asr.l        #$8, d4                                       ; $0170BE
        move.w       d3, ActorMotionX(a0)                          ; $0170C0
        move.w       d4, ActorMotionY(a0)                          ; $0170C4
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $0170C8
        beq.b        loc_0170E2                                    ; $0170CE
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $0170D0
        beq.w        loc_0170F0                                    ; $0170D6
        move.b       #$2, ActorState(a0)                           ; $0170DA

loc_0170E0:
        rts                                                        ; $0170E0

loc_0170E2:
        move.b       #$5, ActorState(a0)                           ; $0170E2
        move.b       #$8, ActorStateCounter(a0)                    ; $0170E8
        rts                                                        ; $0170EE

loc_0170F0:
        move.b       #$6, ActorState(a0)                           ; $0170F0
        move.b       #$6, ActorStateCounter(a0)                    ; $0170F6
        rts                                                        ; $0170FC
        ifne *-$170FE
        fail "ROM end moved"
        endif
