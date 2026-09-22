; $009A88..$009B77 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9A88
        fail "ROM start moved"
        endif

ActorSpawnCellSelectors equ $009A88

        incbin "generated/data/009a88.bin"
        ifne *-$9B78
        fail "ROM end moved"
        endif
