; $096B2A..$096EA9 | map-grid:28
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$96B2A
        fail "ROM start moved"
        endif

Episode4Floor09Cells equ $096B2A

        incbin "generated/data/096b2a.bin"
        ifne *-$96EAA
        fail "ROM end moved"
        endif
