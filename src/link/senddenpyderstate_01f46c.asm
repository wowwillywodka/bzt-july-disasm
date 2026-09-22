; $01F46C..$01F529 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D contains ID/XY/MotionXY; computed animation7 values not serialized. Does not implement local wake or melee animation.
        ifne *-$1F46C
        fail "ROM start moved"
        endif

SendDenpyderState:
; Command0D contains ID/XY/MotionXY; computed animation7 values not serialized. Does not implement local wake or melee animation.
        lea.l        -$6fdc(a6), a1                                ; $01F46C
        move.b       #$d, (a1)+                                    ; $01F470
        move.b       ActorLinkId(a0), (a1)+                        ; $01F474
        move.w       ActorX(a0), (a1)+                             ; $01F478
        move.w       ActorY(a0), (a1)+                             ; $01F47C
        move.w       ActorMotionX(a0), (a1)+                       ; $01F480
        move.w       ActorMotionY(a0), (a1)+                       ; $01F484
        move.b       ActorState(a0), d7                            ; $01F488
        cmpi.b       #$2, d7                                       ; $01F48C
        beq.b        loc_01F49A                                    ; $01F490
        cmpi.b       #$1, d7                                       ; $01F492
        beq.b        loc_01F4A4                                    ; $01F496
        bra.b        loc_01F4FC                                    ; $01F498

loc_01F49A:
        tst.w        ActorHealth(a0)                               ; $01F49A
        bmi.b        loc_01F4A2                                    ; $01F49E
        bra.b        loc_01F4FC                                    ; $01F4A0

loc_01F4A2:
        bra.b        loc_01F4FC                                    ; $01F4A2

loc_01F4A4:
        move.b       ActorStateCounter(a0), d7                     ; $01F4A4
        cmpi.b       #$9, d7                                       ; $01F4A8
        beq.b        loc_01F4E0                                    ; $01F4AC
        cmpi.b       #$8, d7                                       ; $01F4AE
        beq.b        loc_01F4E0                                    ; $01F4B2
        cmpi.b       #$2, d7                                       ; $01F4B4
        beq.b        loc_01F4E0                                    ; $01F4B8
        cmpi.b       #$1, d7                                       ; $01F4BA
        beq.b        loc_01F4E0                                    ; $01F4BE
        cmpi.b       #$7, d7                                       ; $01F4C0
        beq.b        loc_01F4EA                                    ; $01F4C4
        cmpi.b       #$6, d7                                       ; $01F4C6
        beq.b        loc_01F4EA                                    ; $01F4CA
        cmpi.b       #$4, d7                                       ; $01F4CC
        beq.b        loc_01F4EA                                    ; $01F4D0
        cmpi.b       #$3, d7                                       ; $01F4D2
        beq.b        loc_01F4EA                                    ; $01F4D6
        cmpi.b       #$5, d7                                       ; $01F4D8
        beq.b        loc_01F4F4                                    ; $01F4DC
        rts                                                        ; $01F4DE

loc_01F4E0:
        move.w       #$7, d0                                       ; $01F4E0
        move.w       #$1, d2                                       ; $01F4E4
        bra.b        loc_01F4FC                                    ; $01F4E8

loc_01F4EA:
        move.w       #$7, d0                                       ; $01F4EA
        move.w       #$2, d2                                       ; $01F4EE
        bra.b        loc_01F4FC                                    ; $01F4F2

loc_01F4F4:
        move.w       #$7, d0                                       ; $01F4F4
        move.w       #$3, d2                                       ; $01F4F8

loc_01F4FC:
        lea.l        -$6fdc(a6), a0                                ; $01F4FC
        jmp          QueueLinkCommand.l                            ; $01F500

loc_01F506:
        move.l       #DenpyderSpriteBank, ActorSpriteBank(a0)      ; $01F506
        move.w       #$0, d0                                       ; $01F50E
        move.w       #$ffff, d2                                    ; $01F512
        bra.w        DrawActorAnimation                            ; $01F516

loc_01F51A:
        move.l       #DenpyderSpriteBank, ActorSpriteBank(a0)      ; $01F51A
        move.w       #$1, d0                                       ; $01F522
        bra.w        loc_01F844                                    ; $01F526
        ifne *-$1F52A
        fail "ROM end moved"
        endif
