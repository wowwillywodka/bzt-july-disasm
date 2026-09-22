; $08A97E..$08B005 | map-grid:38
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8A97E
        fail "ROM start moved"
        endif

Episode2Floor01Cells equ $08A97E

        incbin "generated/data/08a97e.bin"
        ifne *-$8B006
        fail "ROM end moved"
        endif
