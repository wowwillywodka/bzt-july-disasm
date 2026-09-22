; $00F7F6..$00F815 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F7F6
        fail "ROM start moved"
        endif

ViewDirectionSteps equ $00F7F6

        incbin "generated/data/00f7f6.bin"
        ifne *-$F816
        fail "ROM end moved"
        endif
