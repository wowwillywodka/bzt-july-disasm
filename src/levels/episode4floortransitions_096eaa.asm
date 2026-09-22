; $096EAA..$0970E9 | floor-transitions
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$96EAA
        fail "ROM start moved"
        endif

Episode4FloorTransitions equ $096EAA

        incbin "generated/data/096eaa.bin"
        ifne *-$970EA
        fail "ROM end moved"
        endif
