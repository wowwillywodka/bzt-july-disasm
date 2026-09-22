; $093344..$093443 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93344
        fail "ROM start moved"
        endif

Episode4CellTypes equ $093344

        incbin "generated/data/093344.bin"
        ifne *-$93444
        fail "ROM end moved"
        endif
