; $087644..$087A17 | map-grid:28
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$87644
        fail "ROM start moved"
        endif

Episode1Floor06Cells equ $087644

        incbin "generated/data/087644.bin"
        ifne *-$87A18
        fail "ROM end moved"
        endif
