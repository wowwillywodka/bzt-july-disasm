; $08D1B2..$08D3F1 | floor-transitions
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8D1B2
        fail "ROM start moved"
        endif

Episode2FloorTransitions equ $08D1B2

        incbin "generated/data/08d1b2.bin"
        ifne *-$8D3F2
        fail "ROM end moved"
        endif
