; $01F2A6..$01F2B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F2A6
        fail "ROM start moved"
        endif

QueueGreyDummyStatePacketVariantA:
        move.w       #$1, d0                                       ; $01F2A6
        move.w       #$1, d2                                       ; $01F2AA
        bra.b        QueueGreyDummyPreparedStatePacket                          ; $01F2AE

loc_01F2B0:
        move.w       #$1, d0                                       ; $01F2B0
        move.w       #$2, d2                                       ; $01F2B4
        bra.b        QueueGreyDummyPreparedStatePacket                          ; $01F2B8
        ifne *-$1F2BA
        fail "ROM end moved"
        endif
