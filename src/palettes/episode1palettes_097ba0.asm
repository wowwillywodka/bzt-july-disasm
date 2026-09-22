; $097BA0..$097C9F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97BA0
        fail "ROM start moved"
        endif

Episode1Palettes equ $097BA0

        incbin "generated/data/097ba0.bin"
        ifne *-$97CA0
        fail "ROM end moved"
        endif
