; $0223D0..$0223EF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$223D0
        fail "ROM start moved"
        endif

IntroPaletteB equ $0223D0

        incbin "generated/data/0223d0.bin"
        ifne *-$223F0
        fail "ROM end moved"
        endif
