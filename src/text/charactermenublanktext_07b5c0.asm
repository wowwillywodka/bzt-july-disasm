; $07B5C0..$07B5E3 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7B5C0
        fail "ROM start moved"
        endif

CharacterMenuBlankText equ $07B5C0

        incbin "generated/data/07b5c0.bin"
        ifne *-$7B5E4
        fail "ROM end moved"
        endif
