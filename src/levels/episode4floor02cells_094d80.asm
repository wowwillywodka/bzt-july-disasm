; $094D80..$095115 | map-grid:34
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$94D80
        fail "ROM start moved"
        endif

Episode4Floor02Cells equ $094D80

        incbin "generated/data/094d80.bin"
        ifne *-$95116
        fail "ROM end moved"
        endif
