; $00C078..$00C08B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C078
        fail "ROM start moved"
        endif

FloorNameOffsets equ $00C078
Data_00C07A equ $00C07A

        incbin "generated/data/00c078.bin"
        ifne *-$C08C
        fail "ROM end moved"
        endif
