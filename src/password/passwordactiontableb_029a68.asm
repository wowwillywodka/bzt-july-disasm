; $029A68..$029A6F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29A68
        fail "ROM start moved"
        endif

PasswordActionTableB equ $029A68

        incbin "generated/data/029a68.bin"
        ifne *-$29A70
        fail "ROM end moved"
        endif
