; $007A4E..$00824D | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7A4E
        fail "ROM start moved"
        endif

AngleVectorPairs equ $007A4E

        incbin "generated/data/007a4e.bin"
        ifne *-$824E
        fail "ROM end moved"
        endif
