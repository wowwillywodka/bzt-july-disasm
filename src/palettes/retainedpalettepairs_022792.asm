; $022792..$0227D1 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22792
        fail "ROM start moved"
        endif

RetainedPalettePairs equ $022792

        incbin "generated/data/022792.bin"
        ifne *-$227D2
        fail "ROM end moved"
        endif
