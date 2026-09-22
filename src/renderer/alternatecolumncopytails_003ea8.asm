; $003EA8..$003F4B | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3EA8
        fail "ROM start moved"
        endif

AlternateColumnCopyTails equ $003EA8

        incbin "generated/data/003ea8.bin"
        ifne *-$3F4C
        fail "ROM end moved"
        endif
