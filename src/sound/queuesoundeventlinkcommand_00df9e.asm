; $00DF9E..$00DFB9 | m68k
; Maintained assembly input; no extraction occurs during build.
; Link command $08 carrying the low byte of the sound event ID in D0.
; QueueLinkCommand sends it through the multiplayer command path, not GEMS.
        ifne *-$DF9E
        fail "ROM start moved"
        endif

QueueSoundEventLinkCommand:
; Direct entry queues link command $08 only. Fallthrough from $00DF9C has already played the local sound.
        movem.l      d0-d1/a0-a1, -(a7)                            ; $00DF9E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00DFA2
        move.b       #$8, (a0)                                     ; $00DFA6
        move.b       d0, $1(a0)                                    ; $00DFAA
        jsr          QueueLinkCommand.l                            ; $00DFAE
        movem.l      (a7)+, d0-d1/a0-a1                            ; $00DFB4
        rts                                                        ; $00DFB8
        ifne *-$DFBA
        fail "ROM end moved"
        endif
