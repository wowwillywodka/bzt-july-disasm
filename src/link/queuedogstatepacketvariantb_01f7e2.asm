; $01F7E2..$01F821 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F7E2
        fail "ROM start moved"
        endif

QueueDogStatePacketVariantB:
        move.w       #$1, d0                                       ; $01F7E2
        move.w       #$2, d2                                       ; $01F7E6
        bra.b        loc_01F7F4                                    ; $01F7EA

loc_01F7EC:
        move.w       #$1, d0                                       ; $01F7EC
        move.w       #$3, d2                                       ; $01F7F0

loc_01F7F4:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F7F4
        jmp          QueueLinkCommand.l                            ; $01F7F8
        ifne *-$1F7FE
        fail "ROM end moved"
        endif
