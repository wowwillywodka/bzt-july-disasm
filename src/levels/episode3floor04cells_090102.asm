; $090102..$090561 | map-grid:40
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$90102
        fail "ROM start moved"
        endif

Episode3Floor04Cells equ $090102

        incbin "generated/data/090102.bin"
        ifne *-$90562
        fail "ROM end moved"
        endif
