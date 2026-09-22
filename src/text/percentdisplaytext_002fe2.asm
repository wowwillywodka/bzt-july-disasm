; $002FE2..$002FEB | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2FE2
        fail "ROM start moved"
        endif

PercentDisplayText equ $002FE2

        incbin "generated/data/002fe2.bin"
        ifne *-$2FEC
        fail "ROM end moved"
        endif
