; $01273C..$0127D3 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1273C
        fail "ROM start moved"
        endif

ItemPlacementHandlersEnd equ $01273C

        incbin "generated/data/01273c.bin"
        ifne *-$127D4
        fail "ROM end moved"
        endif
