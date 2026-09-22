; $029A60..$029A67 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29A60
        fail "ROM start moved"
        endif

PasswordActionTableA equ $029A60

        incbin "generated/data/029a60.bin"
        ifne *-$29A68
        fail "ROM end moved"
        endif
