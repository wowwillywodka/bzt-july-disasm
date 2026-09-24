; $003D60..$003E03 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3D60
        fail "ROM start moved"
        endif

DirectWallColumnScalers equ $003D60

        incbin "generated/data/003d60.bin"
        ifne *-$3E04
        fail "ROM end moved"
        endif
