; $01F06C..$01F07F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: this entry sets D0/D2, then queues the already prepared
; rSharedScratchBuffer packet. QueueLinkCommand overwrites D0 and does not read
; D2, so these variant register writes do not change the transmitted bytes.
; Any draw labels after an unconditional JMP are separate callback entries.
        ifne *-$1F06C
        fail "ROM start moved"
        endif

QueueBloodBodyStatePacketVariantA:
        move.w       #$2, d0                                       ; $01F06C
        move.w       #$1, d2                                       ; $01F070
        bra.b        loc_01F088                                    ; $01F074

loc_01F076:
        move.w       #$2, d0                                       ; $01F076
        move.w       #$2, d2                                       ; $01F07A
        bra.b        loc_01F088                                    ; $01F07E
        ifne *-$1F080
        fail "ROM end moved"
        endif
