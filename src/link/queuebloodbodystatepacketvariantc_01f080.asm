; $01F080..$01F0B5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F080
        fail "ROM start moved"
        endif

QueueBloodBodyStatePacketVariantC:
        move.w       #$2, d0                                       ; $01F080
        move.w       #$3, d2                                       ; $01F084

loc_01F088:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F088
        jmp          QueueLinkCommand.l                            ; $01F08C
        ifne *-$1F092
        fail "ROM end moved"
        endif
