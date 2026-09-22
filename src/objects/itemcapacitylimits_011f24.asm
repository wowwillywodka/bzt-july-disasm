; $011F24..$011F47 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$11F24
        fail "ROM start moved"
        endif

ItemCapacityLimits equ $011F24

        incbin "generated/data/011f24.bin"
        ifne *-$11F48
        fail "ROM end moved"
        endif
