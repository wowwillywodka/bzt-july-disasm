; $017A90..$017AA7 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$17A90
        fail "ROM start moved"
        endif

InventoryChoiceRowPointers equ $017A90

        incbin "generated/data/017a90.bin"
        ifne *-$17AA8
        fail "ROM end moved"
        endif
