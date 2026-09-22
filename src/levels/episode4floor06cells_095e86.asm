; $095E86..$09646D | map-grid:42
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$95E86
        fail "ROM start moved"
        endif

Episode4Floor06Cells equ $095E86

        incbin "generated/data/095e86.bin"
        ifne *-$9646E
        fail "ROM end moved"
        endif
