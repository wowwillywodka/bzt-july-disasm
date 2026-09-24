; $01F364..$01F37F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F364
        fail "ROM start moved"
        endif

QueueGreenDummyStatePacketVariantA:
        move.w       #$1, d0                                       ; $01F364
        move.w       #$1, d2                                       ; $01F368
        bra.b        QueueGreenDummyPreparedStatePacket                          ; $01F36C

loc_01F36E:
        move.w       #$1, d0                                       ; $01F36E
        move.w       #$2, d2                                       ; $01F372
        bra.b        QueueGreenDummyPreparedStatePacket                          ; $01F376

loc_01F378:
        move.w       #$1, d0                                       ; $01F378
        move.w       #$3, d2                                       ; $01F37C
        ifne *-$1F380
        fail "ROM end moved"
        endif
