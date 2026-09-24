; $01F2BA..$01F2C1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F2BA
        fail "ROM start moved"
        endif

QueueGreyDummyStatePacketVariantC:
        move.w       #$1, d0                                       ; $01F2BA
        move.w       #$3, d2                                       ; $01F2BE
        ifne *-$1F2C2
        fail "ROM end moved"
        endif
