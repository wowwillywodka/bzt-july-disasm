; $003E04..$003EA7 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3E04
        fail "ROM start moved"
        endif

WallColumnCopyTails equ $003E04

        incbin "generated/data/003e04.bin"
        ifne *-$3EA8
        fail "ROM end moved"
        endif
