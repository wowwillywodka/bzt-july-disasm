; $000000..$0000FF | vectors
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$0
        fail "ROM start moved"
        endif

ExceptionVectors equ $000000

        incbin "generated/data/000000.bin"
        ifne *-$100
        fail "ROM end moved"
        endif
