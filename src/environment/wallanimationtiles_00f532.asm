; $00F532..$00F551 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F532
        fail "ROM start moved"
        endif

WallAnimationTiles equ $00F532

        incbin "generated/data/00f532.bin"
        ifne *-$F552
        fail "ROM end moved"
        endif
