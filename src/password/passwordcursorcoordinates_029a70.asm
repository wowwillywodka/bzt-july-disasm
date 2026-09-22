; $029A70..$029A8F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29A70
        fail "ROM start moved"
        endif

PasswordCursorCoordinates equ $029A70

        incbin "generated/data/029a70.bin"
        ifne *-$29A90
        fail "ROM end moved"
        endif
