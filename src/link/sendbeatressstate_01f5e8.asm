; $01F5E8..$01F665 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D contains ID/XY/MotionXY; copied counter9..1 selection differs from local melee6..1, but D0/D2 are not serialized by tail.
        ifne *-$1F5E8
        fail "ROM start moved"
        endif

SendBeatressState:
; Command0D contains ID/XY/MotionXY; copied counter9..1 selection differs from local melee6..1, but D0/D2 are not serialized by tail.
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F5E8
        move.b       #$d, (a1)+                                    ; $01F5EC
        move.b       ActorLinkId(a0), (a1)+                        ; $01F5F0
        move.w       ActorX(a0), (a1)+                             ; $01F5F4
        move.w       ActorY(a0), (a1)+                             ; $01F5F8
        move.w       ActorMotionX(a0), (a1)+                       ; $01F5FC
        move.w       ActorMotionY(a0), (a1)+                       ; $01F600
        move.b       ActorState(a0), d7                            ; $01F604
        cmpi.b       #$2, d7                                       ; $01F608
        beq.b        loc_01F616                                    ; $01F60C
        cmpi.b       #$1, d7                                       ; $01F60E
        beq.b        loc_01F620                                    ; $01F612
        bra.b        loc_01F678                                    ; $01F614

loc_01F616:
        tst.w        ActorHealth(a0)                               ; $01F616
        bmi.b        loc_01F61E                                    ; $01F61A
        bra.b        loc_01F678                                    ; $01F61C

loc_01F61E:
        bra.b        loc_01F678                                    ; $01F61E

loc_01F620:
        move.b       ActorStateCounter(a0), d7                     ; $01F620
        cmpi.b       #$9, d7                                       ; $01F624
        beq.b        loc_01F65C                                    ; $01F628
        cmpi.b       #$8, d7                                       ; $01F62A
        beq.b        loc_01F65C                                    ; $01F62E
        cmpi.b       #$2, d7                                       ; $01F630
        beq.b        loc_01F65C                                    ; $01F634
        cmpi.b       #$1, d7                                       ; $01F636
        beq.b        loc_01F65C                                    ; $01F63A
        cmpi.b       #$7, d7                                       ; $01F63C
        beq.b        QueueBeatressStatePacketVariantB                          ; $01F640
        cmpi.b       #$6, d7                                       ; $01F642
        beq.b        QueueBeatressStatePacketVariantB                          ; $01F646
        cmpi.b       #$4, d7                                       ; $01F648
        beq.b        QueueBeatressStatePacketVariantB                          ; $01F64C
        cmpi.b       #$3, d7                                       ; $01F64E
        beq.b        QueueBeatressStatePacketVariantB                          ; $01F652
        cmpi.b       #$5, d7                                       ; $01F654
        beq.b        loc_01F670                                    ; $01F658
        rts                                                        ; $01F65A

loc_01F65C:
        move.w       #$1, d0                                       ; $01F65C
        move.w       #$1, d2                                       ; $01F660
        bra.b        loc_01F678                                    ; $01F664
        ifne *-$1F666
        fail "ROM end moved"
        endif
