; $01922A..$0192A1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active state5 counters7/6 ->2/1;5/4 ->5/1;3 ->5/2;2/1 ->5/3. Bank animation5 ends at3.
        ifne *-$1922A
        fail "ROM start moved"
        endif

DrawLarvaCreatureWeaponDeath:
; Active state5 counters7/6 ->2/1;5/4 ->5/1;3 ->5/2;2/1 ->5/3. Bank animation5 ends at3.
        move.b       ActorStateCounter(a0), d7                     ; $01922A
        cmpi.b       #$7, d7                                       ; $01922E
        beq.b        loc_01925A                                    ; $019232
        cmpi.b       #$6, d7                                       ; $019234
        beq.b        loc_01925A                                    ; $019238
        cmpi.b       #$5, d7                                       ; $01923A
        beq.b        loc_019268                                    ; $01923E
        cmpi.b       #$4, d7                                       ; $019240
        beq.b        loc_019268                                    ; $019244
        cmpi.b       #$3, d7                                       ; $019246
        beq.b        loc_019276                                    ; $01924A
        cmpi.b       #$2, d7                                       ; $01924C
        beq.b        loc_019284                                    ; $019250
        cmpi.b       #$1, d7                                       ; $019252
        beq.b        loc_019292                                    ; $019256
        rts                                                        ; $019258

loc_01925A:
        move.w       #$2, d0                                       ; $01925A
        move.w       #$1, d2                                       ; $01925E
        jmp          DrawActorAnimation.l                          ; $019262

loc_019268:
        move.w       #$5, d0                                       ; $019268
        move.w       #$1, d2                                       ; $01926C
        jmp          DrawActorAnimation.l                          ; $019270

loc_019276:
        move.w       #$5, d0                                       ; $019276
        move.w       #$2, d2                                       ; $01927A
        jmp          DrawActorAnimation.l                          ; $01927E

loc_019284:
        move.w       #$5, d0                                       ; $019284
        move.w       #$3, d2                                       ; $019288
        jmp          DrawActorAnimation.l                          ; $01928C

loc_019292:
        move.w       #$5, d0                                       ; $019292
        move.w       #$3, d2                                       ; $019296
        jmp          DrawActorAnimation.l                          ; $01929A

LarvaCreatureSkipStateSixDrawing:
        rts                                                        ; $0192A0
        ifne *-$192A2
        fail "ROM end moved"
        endif
