; $096896..$096B29 | map-grid:22
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$96896
        fail "ROM start moved"
        endif

Episode4Floor08Cells equ $096896

        incbin "generated/data/096896.bin"
        ifne *-$96B2A
        fail "ROM end moved"
        endif
