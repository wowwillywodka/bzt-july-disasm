; $01D5D0..$01D6CF | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1D5D0
        fail "ROM start moved"
        endif

EnemyWalkabilityClasses equ $01D5D0

        incbin "generated/data/01d5d0.bin"
        ifne *-$1D6D0
        fail "ROM end moved"
        endif
