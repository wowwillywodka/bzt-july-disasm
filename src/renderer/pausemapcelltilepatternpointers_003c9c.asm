; $003C9C..$003CBB | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3C9C
        fail "ROM start moved"
        endif

PauseMapCellTilePatternPointers equ $003C9C

        incbin "generated/data/003c9c.bin"
        ifne *-$3CBC
        fail "ROM end moved"
        endif
