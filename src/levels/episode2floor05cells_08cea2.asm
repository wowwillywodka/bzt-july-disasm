; $08CEA2..$08D1B1 | map-grid:28
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8CEA2
        fail "ROM start moved"
        endif

Episode2Floor05Cells equ $08CEA2

        incbin "generated/data/08cea2.bin"
        ifne *-$8D1B2
        fail "ROM end moved"
        endif
