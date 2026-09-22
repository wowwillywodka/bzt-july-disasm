; $00824E..$008A4D | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$824E
        fail "ROM start moved"
        endif

RaySlopePairs equ $00824E

        incbin "generated/data/00824e.bin"
        ifne *-$8A4E
        fail "ROM end moved"
        endif
