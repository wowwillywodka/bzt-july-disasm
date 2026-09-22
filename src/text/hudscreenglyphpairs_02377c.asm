; $02377C..$0238E7 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2377C
        fail "ROM start moved"
        endif

HudScreenGlyphPairs equ $02377C

        incbin "generated/data/02377c.bin"
        ifne *-$238E8
        fail "ROM end moved"
        endif
