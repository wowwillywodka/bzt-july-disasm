; $0216BE..$021701 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$216BE
        fail "ROM start moved"
        endif

ItemPickupMessagePointers equ $0216BE

        incbin "generated/data/0216be.bin"
        ifne *-$21702
        fail "ROM end moved"
        endif
