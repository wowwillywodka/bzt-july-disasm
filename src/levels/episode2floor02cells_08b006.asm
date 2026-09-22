; $08B006..$08B645 | map-grid:40
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8B006
        fail "ROM start moved"
        endif

Episode2Floor02Cells equ $08B006

        incbin "generated/data/08b006.bin"
        ifne *-$8B646
        fail "ROM end moved"
        endif
