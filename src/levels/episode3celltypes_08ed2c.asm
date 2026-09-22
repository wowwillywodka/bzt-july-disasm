; $08ED2C..$08EE2B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8ED2C
        fail "ROM start moved"
        endif

Episode3CellTypes equ $08ED2C

        incbin "generated/data/08ed2c.bin"
        ifne *-$8EE2C
        fail "ROM end moved"
        endif
