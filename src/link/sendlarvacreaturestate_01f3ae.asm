; $01F3AE..$01F46B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D writes ID/XY/MotionXY only. D0/D2 animation selection is not serialized; state1 invalid counter can return before queueing.
        ifne *-$1F3AE
        fail "ROM start moved"
        endif

SendLarvaCreatureState:
; Command0D writes ID/XY/MotionXY only. D0/D2 animation selection is not serialized; state1 invalid counter can return before queueing.
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F3AE
        move.b       #$d, (a1)+                                    ; $01F3B2
        move.b       ActorLinkId(a0), (a1)+                        ; $01F3B6
        move.w       ActorX(a0), (a1)+                             ; $01F3BA
        move.w       ActorY(a0), (a1)+                             ; $01F3BE
        move.w       ActorMotionX(a0), (a1)+                       ; $01F3C2
        move.w       ActorMotionY(a0), (a1)+                       ; $01F3C6
        move.b       ActorState(a0), d7                            ; $01F3CA
        cmpi.b       #$2, d7                                       ; $01F3CE
        beq.b        loc_01F3DC                                    ; $01F3D2
        cmpi.b       #$1, d7                                       ; $01F3D4
        beq.b        loc_01F3E6                                    ; $01F3D8
        bra.b        loc_01F43E                                    ; $01F3DA

loc_01F3DC:
        tst.w        ActorHealth(a0)                               ; $01F3DC
        bmi.b        loc_01F3E4                                    ; $01F3E0
        bra.b        loc_01F43E                                    ; $01F3E2

loc_01F3E4:
        bra.b        loc_01F43E                                    ; $01F3E4

loc_01F3E6:
        move.b       ActorStateCounter(a0), d7                     ; $01F3E6
        cmpi.b       #$9, d7                                       ; $01F3EA
        beq.b        loc_01F422                                    ; $01F3EE
        cmpi.b       #$8, d7                                       ; $01F3F0
        beq.b        loc_01F422                                    ; $01F3F4
        cmpi.b       #$2, d7                                       ; $01F3F6
        beq.b        loc_01F422                                    ; $01F3FA
        cmpi.b       #$1, d7                                       ; $01F3FC
        beq.b        loc_01F422                                    ; $01F400
        cmpi.b       #$7, d7                                       ; $01F402
        beq.b        loc_01F42C                                    ; $01F406
        cmpi.b       #$6, d7                                       ; $01F408
        beq.b        loc_01F42C                                    ; $01F40C
        cmpi.b       #$4, d7                                       ; $01F40E
        beq.b        loc_01F42C                                    ; $01F412
        cmpi.b       #$3, d7                                       ; $01F414
        beq.b        loc_01F42C                                    ; $01F418
        cmpi.b       #$5, d7                                       ; $01F41A
        beq.b        loc_01F436                                    ; $01F41E
        rts                                                        ; $01F420

loc_01F422:
        move.w       #$1, d0                                       ; $01F422
        move.w       #$1, d2                                       ; $01F426
        bra.b        loc_01F43E                                    ; $01F42A

loc_01F42C:
        move.w       #$1, d0                                       ; $01F42C
        move.w       #$2, d2                                       ; $01F430
        bra.b        loc_01F43E                                    ; $01F434

loc_01F436:
        move.w       #$1, d0                                       ; $01F436
        move.w       #$3, d2                                       ; $01F43A

loc_01F43E:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F43E
        jmp          QueueLinkCommand.l                            ; $01F442

loc_01F448:
        move.l       #LarvaCreatureSpriteBank, ActorSpriteBank(a0) ; $01F448
        move.w       #$0, d0                                       ; $01F450
        move.w       #$ffff, d2                                    ; $01F454
        bra.w        DrawActorAnimation                            ; $01F458

loc_01F45C:
        move.l       #LarvaCreatureSpriteBank, ActorSpriteBank(a0) ; $01F45C
        move.w       #$3, d0                                       ; $01F464
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F468
        ifne *-$1F46C
        fail "ROM end moved"
        endif
