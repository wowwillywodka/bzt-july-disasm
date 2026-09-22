; $029144..$0292AF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29144
        fail "ROM start moved"
        endif

MenuTextGlyphPairs equ $029144

        incbin "generated/data/029144.bin"
        ifne *-$292B0
        fail "ROM end moved"
        endif
