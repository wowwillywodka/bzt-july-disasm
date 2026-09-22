; $083D38..$083D3B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$83D38
        fail "ROM start moved"
        endif

Episode1Signature equ $083D38

        incbin "generated/data/083d38.bin"
        ifne *-$83D3C
        fail "ROM end moved"
        endif
