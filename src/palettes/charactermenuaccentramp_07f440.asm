; $07F440..$07F49F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7F440
        fail "ROM start moved"
        endif

CharacterMenuAccentRamp equ $07F440

        incbin "generated/data/07f440.bin"
        ifne *-$7F4A0
        fail "ROM end moved"
        endif
