; $08563C..$08564B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8563C
        fail "ROM start moved"
        endif

Episode1Environment equ $08563C

        incbin "generated/data/08563c.bin"
        ifne *-$8564C
        fail "ROM end moved"
        endif
