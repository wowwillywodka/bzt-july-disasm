; $0117AC..$0117E3 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$117AC
        fail "ROM start moved"
        endif

InventoryIconPointers equ $0117AC

        incbin "generated/data/0117ac.bin"
        ifne *-$117E4
        fail "ROM end moved"
        endif
