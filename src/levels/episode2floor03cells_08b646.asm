; $08B646..$08BC81 | map-grid:38
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8B646
        fail "ROM start moved"
        endif

Episode2Floor03Cells equ $08B646

        incbin "generated/data/08b646.bin"
        ifne *-$8BC82
        fail "ROM end moved"
        endif
