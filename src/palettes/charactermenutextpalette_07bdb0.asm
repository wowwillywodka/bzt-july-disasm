; $07BDB0..$07BDCF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7BDB0
        fail "ROM start moved"
        endif

CharacterMenuTextPalette equ $07BDB0

        incbin "generated/data/07bdb0.bin"
        ifne *-$7BDD0
        fail "ROM end moved"
        endif
