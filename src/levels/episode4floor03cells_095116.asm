; $095116..$095511 | map-grid:30
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$95116
        fail "ROM start moved"
        endif

Episode4Floor03Cells equ $095116

        incbin "generated/data/095116.bin"
        ifne *-$95512
        fail "ROM end moved"
        endif
