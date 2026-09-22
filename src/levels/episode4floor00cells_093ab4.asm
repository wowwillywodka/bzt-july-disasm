; $093AB4..$0948BF | map-grid:58
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93AB4
        fail "ROM start moved"
        endif

Episode4Floor00Cells equ $093AB4

        incbin "generated/data/093ab4.bin"
        ifne *-$948C0
        fail "ROM end moved"
        endif
