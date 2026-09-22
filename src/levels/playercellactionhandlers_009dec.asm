; $009DEC..$009E2B | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9DEC
        fail "ROM start moved"
        endif

PlayerCellActionHandlers equ $009DEC

        incbin "generated/data/009dec.bin"
        ifne *-$9E2C
        fail "ROM end moved"
        endif
