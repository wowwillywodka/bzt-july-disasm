; $0028AC..$0028C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Writes command $16 into the shared scratch buffer and enqueues it through
; QueueLinkCommand. This is a link packet, not a GEMS sound event.
        ifne *-$28AC
        fail "ROM start moved"
        endif

QueueLinkCommand16:
        movem.l      d0-d1/a0-a1, -(a7)                            ; $0028AC
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0028B0
        move.b       #$16, (a0)                                    ; $0028B4
        jsr          QueueLinkCommand.l                            ; $0028B8
        movem.l      (a7)+, d0-d1/a0-a1                            ; $0028BE
        rts                                                        ; $0028C2
        ifne *-$28C4
        fail "ROM end moved"
        endif
