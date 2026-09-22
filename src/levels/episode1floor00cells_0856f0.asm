; $0856F0..$085DFD | map-grid:42
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$856F0
        fail "ROM start moved"
        endif

Episode1Floor00Cells equ $0856F0

        incbin "generated/data/0856f0.bin"
        ifne *-$85DFE
        fail "ROM end moved"
        endif
