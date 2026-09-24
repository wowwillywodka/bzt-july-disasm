; $01F12A..$01F145 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F12A
        fail "ROM start moved"
        endif

QueueStananStatePacketVariantA:
        move.w       #$2, d0                                       ; $01F12A
        move.w       #$1, d2                                       ; $01F12E
        bra.b        QueueStananPreparedStatePacket                          ; $01F132

loc_01F134:
        move.w       #$2, d0                                       ; $01F134
        move.w       #$2, d2                                       ; $01F138
        bra.b        QueueStananPreparedStatePacket                          ; $01F13C

loc_01F13E:
        move.w       #$2, d0                                       ; $01F13E
        move.w       #$3, d2                                       ; $01F142
        ifne *-$1F146
        fail "ROM end moved"
        endif
