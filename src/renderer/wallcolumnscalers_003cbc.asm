; $003CBC..$003D5F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3CBC
        fail "ROM start moved"
        endif

WallColumnScalers equ $003CBC

        incbin "generated/data/003cbc.bin"
        ifne *-$3D60
        fail "ROM end moved"
        endif
