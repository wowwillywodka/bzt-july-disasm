; $0208B6..$0208BF | m68k
; Separate link command handler entry.
        ifne *-$208B6
        fail "ROM start moved"
        endif

ReceiveRemoteSoundEvent:
        clr.w        d0                                            ; $0208B6
        move.b       (a0)+, d0                                     ; $0208B8
        jmp          DispatchSoundEventWithIrqMask.l                         ; $0208BA
        ifne *-$208C0
        fail "ROM end moved"
        endif
