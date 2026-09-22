; $097CA0..$097D9F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97CA0
        fail "ROM start moved"
        endif

Episode2Palettes equ $097CA0

        incbin "generated/data/097ca0.bin"
        ifne *-$97DA0
        fail "ROM end moved"
        endif
