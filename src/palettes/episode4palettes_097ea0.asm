; $097EA0..$097F1F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97EA0
        fail "ROM start moved"
        endif

Episode4Palettes equ $097EA0

        incbin "generated/data/097ea0.bin"
        ifne *-$97F20
        fail "ROM end moved"
        endif
