; $08553C..$08563B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8553C
        fail "ROM start moved"
        endif

Episode1CellTypes equ $08553C

        incbin "generated/data/08553c.bin"
        ifne *-$8563C
        fail "ROM end moved"
        endif
