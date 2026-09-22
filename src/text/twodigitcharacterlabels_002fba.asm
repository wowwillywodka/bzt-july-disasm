; $002FBA..$002FE1 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2FBA
        fail "ROM start moved"
        endif

TwoDigitCharacterLabels equ $002FBA

        incbin "generated/data/002fba.bin"
        ifne *-$2FE2
        fail "ROM end moved"
        endif
