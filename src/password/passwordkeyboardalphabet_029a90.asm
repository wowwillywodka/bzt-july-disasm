; $029A90..$029ACF | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29A90
        fail "ROM start moved"
        endif

PasswordKeyboardAlphabet equ $029A90

        incbin "generated/data/029a90.bin"
        ifne *-$29AD0
        fail "ROM end moved"
        endif
