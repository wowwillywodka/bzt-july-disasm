; $2B9570..$2FFFFF | zero-fill
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B9570
        fail "ROM start moved"
        endif

RomZeroFill equ $2B9570

        incbin "generated/data/2b9570.bin"
        ifne *-$300000
        fail "ROM end moved"
        endif
