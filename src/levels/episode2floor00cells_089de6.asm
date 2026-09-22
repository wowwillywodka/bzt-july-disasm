; $089DE6..$08A97D | map-grid:56
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$89DE6
        fail "ROM start moved"
        endif

Episode2Floor00Cells equ $089DE6

        incbin "generated/data/089de6.bin"
        ifne *-$8A97E
        fail "ROM end moved"
        endif
