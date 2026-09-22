; $01D6D0..$01D755 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1D6D0
        fail "ROM start moved"
        endif

EnemyWalkabilityTrailingZeros equ $01D6D0

        incbin "generated/data/01d6d0.bin"
        ifne *-$1D756
        fail "ROM end moved"
        endif
