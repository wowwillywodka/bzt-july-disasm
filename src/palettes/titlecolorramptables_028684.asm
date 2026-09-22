; $028684..$0286E3 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$28684
        fail "ROM start moved"
        endif

TitleColorRampTables equ $028684

        incbin "generated/data/028684.bin"
        ifne *-$286E4
        fail "ROM end moved"
        endif
