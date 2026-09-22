; $095952..$095E85 | map-grid:36
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$95952
        fail "ROM start moved"
        endif

Episode4Floor05Cells equ $095952

        incbin "generated/data/095952.bin"
        ifne *-$95E86
        fail "ROM end moved"
        endif
