; $08F594..$08FA13 | map-grid:36
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8F594
        fail "ROM start moved"
        endif

Episode3Floor01Cells equ $08F594

        incbin "generated/data/08f594.bin"
        ifne *-$8FA14
        fail "ROM end moved"
        endif
