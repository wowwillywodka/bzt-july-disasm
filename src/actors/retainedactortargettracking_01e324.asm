; $01E324..$01E405 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1E324
        fail "ROM start moved"
        endif

RetainedActorTargetTracking:
        move.w       rGameTick(a6), d0                             ; $01E324
        add.b        ActorLinkId(a0), d0                           ; $01E328
        andi.w       #$3, d0                                       ; $01E32C
        bne.b        loc_01E33E                                    ; $01E330
        bsr.w        SelectEnemyPlayerTarget                       ; $01E332
        move.l       a1, ActorTarget(a0)                           ; $01E336
        beq.w        loc_01E3F6                                    ; $01E33A

loc_01E33E:
        movea.l      ActorTarget(a0), a1                           ; $01E33E
        move.w       ActorX(a0), d0                                ; $01E342
        move.w       ActorY(a0), d1                                ; $01E346
        sub.w        $24(a1), d0                                   ; $01E34A
        sub.w        $26(a1), d1                                   ; $01E34E
        jsr          OctagonalDistance.l                           ; $01E352
        cmpi.w       #$600, d0                                     ; $01E358
        bcc.w        loc_01E3F6                                    ; $01E35C
        move.w       rGameTick(a6), d0                             ; $01E360
        add.b        ActorLinkId(a0), d0                           ; $01E364
        andi.w       #$7, d0                                       ; $01E368
        bne.b        loc_01E3A8                                    ; $01E36C
        bsr.w        GetVisibleMapBase                             ; $01E36E
        move.w       ActorX(a0), d0                                ; $01E372
        asr.w        #$8, d0                                       ; $01E376
        adda.w       d0, a1                                        ; $01E378
        move.w       ActorY(a0), d0                                ; $01E37A
        clr.b        d0                                            ; $01E37E
        asr.w        #$3, d0                                       ; $01E380
        clr.w        d3                                            ; $01E382
        move.b       (a1, d0.w), d3                                ; $01E384
        lea.l        rCellTypeByIndex(a6), a1                      ; $01E388
        move.b       (a1, d3.w), d3                                ; $01E38C
        cmpi.b       #$6, d3                                       ; $01E390
        beq.b        loc_01E3AA                                    ; $01E394
        cmpi.b       #$7, d3                                       ; $01E396
        beq.b        loc_01E3D0                                    ; $01E39A
        cmpi.b       #$83, d3                                      ; $01E39C
        beq.b        loc_01E3AA                                    ; $01E3A0
        cmpi.b       #$84, d3                                      ; $01E3A2
        beq.b        loc_01E3D0                                    ; $01E3A6

loc_01E3A8:
        rts                                                        ; $01E3A8

loc_01E3AA:
        move.b       $27(a6), d0                                   ; $01E3AA
        bmi.b        loc_01E3C0                                    ; $01E3AE
        cmpi.b       #$20, d0                                      ; $01E3B0
        bls.b        loc_01E3A8                                    ; $01E3B4
        move.b       #$20, $27(a6)                                 ; $01E3B6
        bra.w        loc_01E3FC                                    ; $01E3BC

loc_01E3C0:
        cmpi.b       #$e0, d0                                      ; $01E3C0
        bcc.b        loc_01E3A8                                    ; $01E3C4
        move.b       #$e0, $27(a6)                                 ; $01E3C6
        bra.w        loc_01E3FC                                    ; $01E3CC

loc_01E3D0:
        move.b       $25(a6), d0                                   ; $01E3D0
        bmi.b        loc_01E3E6                                    ; $01E3D4
        cmpi.b       #$20, d0                                      ; $01E3D6
        bls.b        loc_01E3A8                                    ; $01E3DA
        move.b       #$20, $25(a6)                                 ; $01E3DC
        bra.w        loc_01E3FC                                    ; $01E3E2

loc_01E3E6:
        cmpi.b       #$e0, d0                                      ; $01E3E6
        bcc.b        loc_01E3A8                                    ; $01E3EA
        move.b       #$e0, $25(a6)                                 ; $01E3EC
        bra.w        loc_01E3FC                                    ; $01E3F2

loc_01E3F6:
        movea.l      ActorExitCallback(a0), a1                     ; $01E3F6
        jmp          (a1)                                          ; $01E3FA

loc_01E3FC:
        move.w       #$3, d0                                       ; $01E3FC
        jmp          SoundRoutine_00DF64.l                         ; $01E400
        ifne *-$1E406
        fail "ROM end moved"
        endif
