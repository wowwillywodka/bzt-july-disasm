; $097DA0..$097E9F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97DA0
        fail "ROM start moved"
        endif

Episode3Palettes equ $097DA0

        incbin "generated/data/097da0.bin"
        ifne *-$97EA0
        fail "ROM end moved"
        endif
