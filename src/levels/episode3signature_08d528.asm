; $08D528..$08D52B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8D528
        fail "ROM start moved"
        endif

Episode3Signature equ $08D528

        incbin "generated/data/08d528.bin"
        ifne *-$8D52C
        fail "ROM end moved"
        endif
