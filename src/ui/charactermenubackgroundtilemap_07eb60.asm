; $07EB60..$07F41F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7EB60
        fail "ROM start moved"
        endif

CharacterMenuBackgroundTilemap equ $07EB60

        incbin "generated/data/07eb60.bin"
        ifne *-$7F420
        fail "ROM end moved"
        endif
