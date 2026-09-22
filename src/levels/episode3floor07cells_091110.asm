; $091110..$0913CD | map-grid:26
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$91110
        fail "ROM start moved"
        endif

Episode3Floor07Cells equ $091110

        incbin "generated/data/091110.bin"
        ifne *-$913CE
        fail "ROM end moved"
        endif
