; $01F146..$01F173 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F146
        fail "ROM start moved"
        endif

QueueStananPreparedStatePacket:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F146
        jmp          QueueLinkCommand.l                            ; $01F14A
        ifne *-$1F150
        fail "ROM end moved"
        endif
