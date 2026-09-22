; $090562..$090887 | map-grid:26
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$90562
        fail "ROM start moved"
        endif

Episode3Floor05Cells equ $090562

        incbin "generated/data/090562.bin"
        ifne *-$90888
        fail "ROM end moved"
        endif
