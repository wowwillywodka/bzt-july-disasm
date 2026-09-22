; $00EC6C..$00ED6B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$EC6C
        fail "ROM start moved"
        endif

PlayerCollisionCellClasses equ $00EC6C

        incbin "generated/data/00ec6c.bin"
        ifne *-$ED6C
        fail "ROM end moved"
        endif
