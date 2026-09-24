; $008DF6..$008E03 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: visible-cell table handler. Saves A0 as the cell render-state
; source, calls CountAndClearObjectiveCellRenderState (which may increment the
; objective counter unless side effects are suppressed), then returns D3=1.
        ifne *-$8DF6
        fail "ROM start moved"
        endif

HandleVisibleObjectiveCellRenderState:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $008DF6
        bsr.w        CountAndClearObjectiveCellRenderState                     ; $008DFA
        move.w       #$1, d3                                       ; $008DFE
        rts                                                        ; $008E02
        ifne *-$8E04
        fail "ROM end moved"
        endif
