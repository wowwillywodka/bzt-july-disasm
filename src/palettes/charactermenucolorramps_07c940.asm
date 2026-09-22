; $07C940..$07C99F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7C940
        fail "ROM start moved"
        endif

CharacterMenuColorRamps equ $07C940

        incbin "generated/data/07c940.bin"
        ifne *-$7C9A0
        fail "ROM end moved"
        endif
