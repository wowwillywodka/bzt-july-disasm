; $0913CE..$0917C9 | map-grid:34
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$913CE
        fail "ROM start moved"
        endif

Episode3Floor08Cells equ $0913CE

        incbin "generated/data/0913ce.bin"
        ifne *-$917CA
        fail "ROM end moved"
        endif
