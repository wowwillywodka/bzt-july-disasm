; $002FAE..$002FB9 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2FAE
        fail "ROM start moved"
        endif

TitleCharacterOrder equ $002FAE

        incbin "generated/data/002fae.bin"
        ifne *-$2FBA
        fail "ROM end moved"
        endif
