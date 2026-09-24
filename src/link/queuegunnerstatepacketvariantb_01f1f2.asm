; $01F1F2..$01F231 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F1F2
        fail "ROM start moved"
        endif

QueueGunnerStatePacketVariantB:
        move.w       #$1, d0                                       ; $01F1F2
        move.w       #$2, d2                                       ; $01F1F6
        bra.b        loc_01F204                                    ; $01F1FA

loc_01F1FC:
        move.w       #$1, d0                                       ; $01F1FC
        move.w       #$3, d2                                       ; $01F200

loc_01F204:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F204
        jmp          QueueLinkCommand.l                            ; $01F208
        ifne *-$1F20E
        fail "ROM end moved"
        endif
