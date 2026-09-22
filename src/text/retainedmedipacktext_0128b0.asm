; $0128B0..$0128D5 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$128B0
        fail "ROM start moved"
        endif

RetainedMedipackText equ $0128B0

        incbin "generated/data/0128b0.bin"
        ifne *-$128D6
        fail "ROM end moved"
        endif
