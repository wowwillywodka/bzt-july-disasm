; $029AD0..$029AD7 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29AD0
        fail "ROM start moved"
        endif

PasswordKeyboardControlCodes equ $029AD0

        incbin "generated/data/029ad0.bin"
        ifne *-$29AD8
        fail "ROM end moved"
        endif
