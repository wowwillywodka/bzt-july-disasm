; $087284..$087643 | map-grid:30
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$87284
        fail "ROM start moved"
        endif

Episode1Floor05Cells equ $087284

        incbin "generated/data/087284.bin"
        ifne *-$87644
        fail "ROM end moved"
        endif
