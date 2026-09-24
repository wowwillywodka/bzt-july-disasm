; $01F1E8..$01F1F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F1E8
        fail "ROM start moved"
        endif

QueueGunnerStatePacketVariantA:
        move.w       #$1, d0                                       ; $01F1E8
        move.w       #$1, d2                                       ; $01F1EC
        bra.b        loc_01F204                                    ; $01F1F0
        ifne *-$1F1F2
        fail "ROM end moved"
        endif
