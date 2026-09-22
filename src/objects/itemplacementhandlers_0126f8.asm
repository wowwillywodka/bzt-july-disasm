; $0126F8..$01273B | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$126F8
        fail "ROM start moved"
        endif

ItemPlacementHandlers equ $0126F8

        incbin "generated/data/0126f8.bin"
        ifne *-$1273C
        fail "ROM end moved"
        endif
