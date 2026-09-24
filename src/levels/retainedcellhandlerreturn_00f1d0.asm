; $00F1D0..$00F1D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Only the two-byte RTS is retained; following callable entries have separate files.
        ifne *-$F1D0
        fail "ROM start moved"
        endif

RetainedCellHandlerReturn:
        rts                                                        ; $00F1D0
        ifne *-$F1D2
        fail "ROM end moved"
        endif
