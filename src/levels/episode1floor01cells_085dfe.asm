; $085DFE..$086499 | map-grid:36
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$85DFE
        fail "ROM start moved"
        endif

Episode1Floor01Cells equ $085DFE

        incbin "generated/data/085dfe.bin"
        ifne *-$8649A
        fail "ROM end moved"
        endif
