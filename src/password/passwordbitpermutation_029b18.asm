; $029B18..$029B4D | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29B18
        fail "ROM start moved"
        endif

PasswordBitPermutation equ $029B18

        incbin "generated/data/029b18.bin"
        ifne *-$29B4E
        fail "ROM end moved"
        endif
