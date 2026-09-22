; $0223B0..$0223CF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$223B0
        fail "ROM start moved"
        endif

IntroPaletteA equ $0223B0

        incbin "generated/data/0223b0.bin"
        ifne *-$223D0
        fail "ROM end moved"
        endif
