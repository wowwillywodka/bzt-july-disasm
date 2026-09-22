; $00A3E8..$00A4E7 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$A3E8
        fail "ROM start moved"
        endif

PlayerInteractionCellClasses equ $00A3E8

        incbin "generated/data/00a3e8.bin"
        ifne *-$A4E8
        fail "ROM end moved"
        endif
