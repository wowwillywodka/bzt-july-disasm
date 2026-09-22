; $08226C..$08227B | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8226C
        fail "ROM start moved"
        endif

HexadecimalDigits equ $08226C

        incbin "generated/data/08226c.bin"
        ifne *-$8227C
        fail "ROM end moved"
        endif
