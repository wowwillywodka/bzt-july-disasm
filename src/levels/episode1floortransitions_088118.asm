; $088118..$088357 | floor-transitions
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$88118
        fail "ROM start moved"
        endif

Episode1FloorTransitions equ $088118

        incbin "generated/data/088118.bin"
        ifne *-$88358
        fail "ROM end moved"
        endif
