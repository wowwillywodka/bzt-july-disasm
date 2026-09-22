; $089D92..$089DA1 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$89D92
        fail "ROM start moved"
        endif

Episode2Environment equ $089D92

        incbin "generated/data/089d92.bin"
        ifne *-$89DA2
        fail "ROM end moved"
        endif
