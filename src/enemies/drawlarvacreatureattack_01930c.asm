; $01930C..$019371 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack1 frames1,1,2,2,3,2,2,1,1 for counter9..1.
        ifne *-$1930C
        fail "ROM start moved"
        endif

DrawLarvaCreatureAttack:
; Active attack1 frames1,1,2,2,3,2,2,1,1 for counter9..1.
        move.b       ActorStateCounter(a0), d7                     ; $01930C
        cmpi.b       #$9, d7                                       ; $019310
        beq.b        loc_019348                                    ; $019314
        cmpi.b       #$8, d7                                       ; $019316
        beq.b        loc_019348                                    ; $01931A
        cmpi.b       #$7, d7                                       ; $01931C
        beq.b        loc_019356                                    ; $019320
        cmpi.b       #$6, d7                                       ; $019322
        beq.b        loc_019356                                    ; $019326
        cmpi.b       #$5, d7                                       ; $019328
        beq.b        loc_019364                                    ; $01932C
        cmpi.b       #$4, d7                                       ; $01932E
        beq.b        loc_019356                                    ; $019332
        cmpi.b       #$3, d7                                       ; $019334
        beq.b        loc_019356                                    ; $019338
        cmpi.b       #$2, d7                                       ; $01933A
        beq.b        loc_019348                                    ; $01933E
        cmpi.b       #$1, d7                                       ; $019340
        beq.b        loc_019348                                    ; $019344
        rts                                                        ; $019346

loc_019348:
        move.w       #$1, d0                                       ; $019348
        move.w       #$1, d2                                       ; $01934C
        jmp          DrawActorAnimation.l                          ; $019350

loc_019356:
        move.w       #$1, d0                                       ; $019356
        move.w       #$2, d2                                       ; $01935A
        jmp          DrawActorAnimation.l                          ; $01935E

loc_019364:
        move.w       #$1, d0                                       ; $019364
        move.w       #$3, d2                                       ; $019368
        jmp          DrawActorAnimation.l                          ; $01936C
        ifne *-$19372
        fail "ROM end moved"
        endif
