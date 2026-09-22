; $0F5C88..$0F5D27 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5C88
        fail "ROM start moved"
        endif

Episode3BackgroundProfile0 equ $0F5C88

        incbin "generated/data/0f5c88.bin"
        ifne *-$F5D28
        fail "ROM end moved"
        endif
