; $01F666..$01F6A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F666
        fail "ROM start moved"
        endif

QueueBeatressStatePacketVariantB:
        move.w       #$1, d0                                       ; $01F666
        move.w       #$2, d2                                       ; $01F66A
        bra.b        loc_01F678                                    ; $01F66E

loc_01F670:
        move.w       #$1, d0                                       ; $01F670
        move.w       #$3, d2                                       ; $01F674

loc_01F678:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F678
        jmp          QueueLinkCommand.l                            ; $01F67C
        ifne *-$1F682
        fail "ROM end moved"
        endif
