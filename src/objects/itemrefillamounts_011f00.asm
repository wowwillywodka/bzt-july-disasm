; $011F00..$011F23 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$11F00
        fail "ROM start moved"
        endif

ItemRefillAmounts equ $011F00

        incbin "generated/data/011f00.bin"
        ifne *-$11F24
        fail "ROM end moved"
        endif
