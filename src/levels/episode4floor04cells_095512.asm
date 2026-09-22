; $095512..$095951 | map-grid:34
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$95512
        fail "ROM start moved"
        endif

Episode4Floor04Cells equ $095512

        incbin "generated/data/095512.bin"
        ifne *-$95952
        fail "ROM end moved"
        endif
