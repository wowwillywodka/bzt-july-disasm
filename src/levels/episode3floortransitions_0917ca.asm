; $0917CA..$091A09 | floor-transitions
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$917CA
        fail "ROM start moved"
        endif

Episode3FloorTransitions equ $0917CA

        incbin "generated/data/0917ca.bin"
        ifne *-$91A0A
        fail "ROM end moved"
        endif
