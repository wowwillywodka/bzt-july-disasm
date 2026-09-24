; $01F724..$01F763 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Draw callbacks are in separate actors partitions.
        ifne *-$1F724
        fail "ROM start moved"
        endif

QueueBlueDummyStatePacketVariantB:
        move.w       #$1, d0                                       ; $01F724
        move.w       #$2, d2                                       ; $01F728
        bra.b        loc_01F736                                    ; $01F72C

loc_01F72E:
        move.w       #$1, d0                                       ; $01F72E
        move.w       #$3, d2                                       ; $01F732

loc_01F736:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F736
        jmp          QueueLinkCommand.l                            ; $01F73A
        ifne *-$1F740
        fail "ROM end moved"
        endif
