; $01F5A8..$01F5E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F5A8
        fail "ROM start moved"
        endif

QueueWhiteDummyStatePacketVariantB:
        move.w       #$1, d0                                       ; $01F5A8
        move.w       #$2, d2                                       ; $01F5AC
        bra.b        loc_01F5BA                                    ; $01F5B0

loc_01F5B2:
        move.w       #$1, d0                                       ; $01F5B2
        move.w       #$3, d2                                       ; $01F5B6

loc_01F5BA:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F5BA
        jmp          QueueLinkCommand.l                            ; $01F5BE
        ifne *-$1F5C4
        fail "ROM end moved"
        endif
