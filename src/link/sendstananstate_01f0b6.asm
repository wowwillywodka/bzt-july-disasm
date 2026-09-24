; $01F0B6..$01F129 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Command0D writes ID, XY and MotionXY. Computed animation values D0/D2 are not written by the send tail $1F146. Full link reception remains separate.
        ifne *-$1F0B6
        fail "ROM start moved"
        endif

SendStananState:
; Command0D writes ID, XY and MotionXY. Computed animation values D0/D2 are not written by the send tail $1F146. Full link reception remains separate.
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F0B6
        move.b       #$d, (a1)+                                    ; $01F0BA
        move.b       ActorLinkId(a0), (a1)+                        ; $01F0BE
        move.w       ActorX(a0), (a1)+                             ; $01F0C2
        move.w       ActorY(a0), (a1)+                             ; $01F0C6
        move.w       ActorMotionX(a0), (a1)+                       ; $01F0CA
        move.w       ActorMotionY(a0), (a1)+                       ; $01F0CE
        move.b       ActorState(a0), d7                            ; $01F0D2
        cmpi.b       #$2, d7                                       ; $01F0D6
        beq.b        loc_01F0E4                                    ; $01F0DA
        cmpi.b       #$1, d7                                       ; $01F0DC
        beq.b        loc_01F0EE                                    ; $01F0E0
        bra.b        QueueStananPreparedStatePacket                          ; $01F0E2

loc_01F0E4:
        tst.w        ActorHealth(a0)                               ; $01F0E4
        bmi.b        loc_01F0EC                                    ; $01F0E8
        bra.b        QueueStananPreparedStatePacket                          ; $01F0EA

loc_01F0EC:
        bra.b        QueueStananPreparedStatePacket                          ; $01F0EC

loc_01F0EE:
        move.b       ActorStateCounter(a0), d7                     ; $01F0EE
        cmpi.b       #$9, d7                                       ; $01F0F2
        beq.b        QueueStananStatePacketVariantA                          ; $01F0F6
        cmpi.b       #$8, d7                                       ; $01F0F8
        beq.b        QueueStananStatePacketVariantA                          ; $01F0FC
        cmpi.b       #$2, d7                                       ; $01F0FE
        beq.b        QueueStananStatePacketVariantA                          ; $01F102
        cmpi.b       #$1, d7                                       ; $01F104
        beq.b        QueueStananStatePacketVariantA                          ; $01F108
        cmpi.b       #$7, d7                                       ; $01F10A
        beq.b        loc_01F134                                    ; $01F10E
        cmpi.b       #$6, d7                                       ; $01F110
        beq.b        loc_01F134                                    ; $01F114
        cmpi.b       #$4, d7                                       ; $01F116
        beq.b        loc_01F134                                    ; $01F11A
        cmpi.b       #$3, d7                                       ; $01F11C
        beq.b        loc_01F134                                    ; $01F120
        cmpi.b       #$5, d7                                       ; $01F122
        beq.b        loc_01F13E                                    ; $01F126
        rts                                                        ; $01F128
        ifne *-$1F12A
        fail "ROM end moved"
        endif
