; $087A18..$088117 | map-grid:56
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$87A18
        fail "ROM start moved"
        endif

Episode1Floor07Cells equ $087A18

        incbin "generated/data/087a18.bin"
        ifne *-$88118
        fail "ROM end moved"
        endif
