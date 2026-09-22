; $029AD8..$029B17 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29AD8
        fail "ROM start moved"
        endif

PasswordCodeAlphabet equ $029AD8

        incbin "generated/data/029ad8.bin"
        ifne *-$29B18
        fail "ROM end moved"
        endif
