; $08BC82..$08CEA1 | map-grid:80
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8BC82
        fail "ROM start moved"
        endif

Episode2Floor04Cells equ $08BC82

        incbin "generated/data/08bc82.bin"
        ifne *-$8CEA2
        fail "ROM end moved"
        endif
