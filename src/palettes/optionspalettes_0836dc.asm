; $0836DC..$08375B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$836DC
        fail "ROM start moved"
        endif

OptionsPalettes equ $0836DC

        incbin "generated/data/0836dc.bin"
        ifne *-$8375C
        fail "ROM end moved"
        endif
