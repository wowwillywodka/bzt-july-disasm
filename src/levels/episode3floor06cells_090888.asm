; $090888..$09110F | map-grid:52
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$90888
        fail "ROM start moved"
        endif

Episode3Floor06Cells equ $090888

        incbin "generated/data/090888.bin"
        ifne *-$91110
        fail "ROM end moved"
        endif
