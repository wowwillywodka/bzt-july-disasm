; $01F232..$01F2A5 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1F232
        fail "ROM start moved"
        endif

SendGreyDummyState:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F232
        move.b       #$d, (a1)+                                    ; $01F236
        move.b       ActorLinkId(a0), (a1)+                        ; $01F23A
        move.w       ActorX(a0), (a1)+                             ; $01F23E
        move.w       ActorY(a0), (a1)+                             ; $01F242
        move.w       ActorMotionX(a0), (a1)+                       ; $01F246
        move.w       ActorMotionY(a0), (a1)+                       ; $01F24A
        move.b       ActorState(a0), d7                            ; $01F24E
        cmpi.b       #$2, d7                                       ; $01F252
        beq.b        loc_01F260                                    ; $01F256
        cmpi.b       #$1, d7                                       ; $01F258
        beq.b        loc_01F26A                                    ; $01F25C
        bra.b        QueueGreyDummyPreparedStatePacket                          ; $01F25E

loc_01F260:
        tst.w        ActorHealth(a0)                               ; $01F260
        bmi.b        loc_01F268                                    ; $01F264
        bra.b        QueueGreyDummyPreparedStatePacket                          ; $01F266

loc_01F268:
        bra.b        QueueGreyDummyPreparedStatePacket                          ; $01F268

loc_01F26A:
        move.b       ActorStateCounter(a0), d7                     ; $01F26A
        cmpi.b       #$9, d7                                       ; $01F26E
        beq.b        QueueGreyDummyStatePacketVariantA                          ; $01F272
        cmpi.b       #$8, d7                                       ; $01F274
        beq.b        QueueGreyDummyStatePacketVariantA                          ; $01F278
        cmpi.b       #$2, d7                                       ; $01F27A
        beq.b        QueueGreyDummyStatePacketVariantA                          ; $01F27E
        cmpi.b       #$1, d7                                       ; $01F280
        beq.b        QueueGreyDummyStatePacketVariantA                          ; $01F284
        cmpi.b       #$7, d7                                       ; $01F286
        beq.b        loc_01F2B0                                    ; $01F28A
        cmpi.b       #$6, d7                                       ; $01F28C
        beq.b        loc_01F2B0                                    ; $01F290
        cmpi.b       #$4, d7                                       ; $01F292
        beq.b        loc_01F2B0                                    ; $01F296
        cmpi.b       #$3, d7                                       ; $01F298
        beq.b        loc_01F2B0                                    ; $01F29C
        cmpi.b       #$5, d7                                       ; $01F29E
        beq.b        QueueGreyDummyStatePacketVariantC                          ; $01F2A2
        rts                                                        ; $01F2A4
        ifne *-$1F2A6
        fail "ROM end moved"
        endif
