; $08F054..$08F593 | map-grid:32
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8F054
        fail "ROM start moved"
        endif

Episode3Floor00Cells equ $08F054

        incbin "generated/data/08f054.bin"
        ifne *-$8F594
        fail "ROM end moved"
        endif
