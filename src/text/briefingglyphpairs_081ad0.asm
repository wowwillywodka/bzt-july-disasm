; $081AD0..$081C3B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$81AD0
        fail "ROM start moved"
        endif

BriefingGlyphPairs equ $081AD0

        incbin "generated/data/081ad0.bin"
        ifne *-$81C3C
        fail "ROM end moved"
        endif
