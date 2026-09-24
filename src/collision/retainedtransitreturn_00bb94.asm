; $00BB94..$00BB95 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Isolated retained RTS; the active transit path follows.
        ifne *-$BB94
        fail "ROM start moved"
        endif

RetainedTransitReturn:
        rts                                                        ; $00BB94

        ifne *-$BB96
        fail "ROM end moved"
        endif
