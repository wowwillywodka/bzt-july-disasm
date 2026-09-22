; $089C92..$089D91 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$89C92
        fail "ROM start moved"
        endif

Episode2CellTypes equ $089C92

        incbin "generated/data/089c92.bin"
        ifne *-$89D92
        fail "ROM end moved"
        endif
