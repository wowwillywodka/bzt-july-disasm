; $0F5B3C..$0F5B47 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5B3C
        fail "ROM start moved"
        endif

Episode3FloorColorModes equ $0F5B3C

        incbin "generated/data/0f5b3c.bin"
        ifne *-$F5B48
        fail "ROM end moved"
        endif
