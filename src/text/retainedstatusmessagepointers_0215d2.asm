; $0215D2..$0216BD | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$215D2
        fail "ROM start moved"
        endif

RetainedStatusMessagePointers equ $0215D2

        incbin "generated/data/0215d2.bin"
        ifne *-$216BE
        fail "ROM end moved"
        endif
