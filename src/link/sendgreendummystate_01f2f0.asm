; $01F2F0..$01F363 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1F2F0
        fail "ROM start moved"
        endif

SendGreenDummyState:
        lea.l        -$6fdc(a6), a1                                ; $01F2F0
        move.b       #$d, (a1)+                                    ; $01F2F4
        move.b       ActorLinkId(a0), (a1)+                        ; $01F2F8
        move.w       ActorX(a0), (a1)+                             ; $01F2FC
        move.w       ActorY(a0), (a1)+                             ; $01F300
        move.w       ActorMotionX(a0), (a1)+                       ; $01F304
        move.w       ActorMotionY(a0), (a1)+                       ; $01F308
        move.b       ActorState(a0), d7                            ; $01F30C
        cmpi.b       #$2, d7                                       ; $01F310
        beq.b        loc_01F31E                                    ; $01F314
        cmpi.b       #$1, d7                                       ; $01F316
        beq.b        loc_01F328                                    ; $01F31A
        bra.b        ActorsRoutine_01F380                          ; $01F31C

loc_01F31E:
        tst.w        ActorHealth(a0)                               ; $01F31E
        bmi.b        loc_01F326                                    ; $01F322
        bra.b        ActorsRoutine_01F380                          ; $01F324

loc_01F326:
        bra.b        ActorsRoutine_01F380                          ; $01F326

loc_01F328:
        move.b       ActorStateCounter(a0), d7                     ; $01F328
        cmpi.b       #$9, d7                                       ; $01F32C
        beq.b        ActorsRoutine_01F364                          ; $01F330
        cmpi.b       #$8, d7                                       ; $01F332
        beq.b        ActorsRoutine_01F364                          ; $01F336
        cmpi.b       #$2, d7                                       ; $01F338
        beq.b        ActorsRoutine_01F364                          ; $01F33C
        cmpi.b       #$1, d7                                       ; $01F33E
        beq.b        ActorsRoutine_01F364                          ; $01F342
        cmpi.b       #$7, d7                                       ; $01F344
        beq.b        loc_01F36E                                    ; $01F348
        cmpi.b       #$6, d7                                       ; $01F34A
        beq.b        loc_01F36E                                    ; $01F34E
        cmpi.b       #$4, d7                                       ; $01F350
        beq.b        loc_01F36E                                    ; $01F354
        cmpi.b       #$3, d7                                       ; $01F356
        beq.b        loc_01F36E                                    ; $01F35A
        cmpi.b       #$5, d7                                       ; $01F35C
        beq.b        loc_01F378                                    ; $01F360
        rts                                                        ; $01F362
        ifne *-$1F364
        fail "ROM end moved"
        endif
