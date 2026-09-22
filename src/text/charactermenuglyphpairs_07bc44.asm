; $07BC44..$07BDAF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7BC44
        fail "ROM start moved"
        endif

CharacterMenuGlyphPairs equ $07BC44

        incbin "generated/data/07bc44.bin"
        ifne *-$7BDB0
        fail "ROM end moved"
        endif
