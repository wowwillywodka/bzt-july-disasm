; $0948C0..$094D7F | map-grid:38
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$948C0
        fail "ROM start moved"
        endif

Episode4Floor01Cells equ $0948C0

        incbin "generated/data/0948c0.bin"
        ifne *-$94D80
        fail "ROM end moved"
        endif
