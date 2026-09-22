; $009CEC..$009DEB | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9CEC
        fail "ROM start moved"
        endif

PlayerCellActionSelectors equ $009CEC

        incbin "generated/data/009cec.bin"
        ifne *-$9DEC
        fail "ROM end moved"
        endif
