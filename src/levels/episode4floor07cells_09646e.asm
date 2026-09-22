; $09646E..$096895 | map-grid:38
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9646E
        fail "ROM start moved"
        endif

Episode4Floor07Cells equ $09646E

        incbin "generated/data/09646e.bin"
        ifne *-$96896
        fail "ROM end moved"
        endif
