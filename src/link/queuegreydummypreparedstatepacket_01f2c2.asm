; $01F2C2..$01F2EF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F2C2
        fail "ROM start moved"
        endif

QueueGreyDummyPreparedStatePacket:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F2C2
        jmp          QueueLinkCommand.l                            ; $01F2C6
        ifne *-$1F2CC
        fail "ROM end moved"
        endif
