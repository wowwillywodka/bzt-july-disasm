; $0F7664..$0F8663 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F7664
        fail "ROM start moved"
        endif

Episode3PanoramaTilemap equ $0F7664

        incbin "generated/data/0f7664.bin"
        ifne *-$F8664
        fail "ROM end moved"
        endif
