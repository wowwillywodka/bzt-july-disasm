; $023756..$02377B | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23756
        fail "ROM start moved"
        endif

TitleLabels equ $023756

        incbin "generated/data/023756.bin"
        ifne *-$2377C
        fail "ROM end moved"
        endif
