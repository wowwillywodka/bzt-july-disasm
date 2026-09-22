; $0023FA..$0024E9 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23FA
        fail "ROM start moved"
        endif

RetainedPanoramaSpriteRows equ $0023FA

        incbin "generated/data/0023fa.bin"
        ifne *-$24EA
        fail "ROM end moved"
        endif
