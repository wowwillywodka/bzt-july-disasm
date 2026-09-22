; $0F5BE8..$0F5C87 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5BE8
        fail "ROM start moved"
        endif

Episode3BackgroundProfile2 equ $0F5BE8

        incbin "generated/data/0f5be8.bin"
        ifne *-$F5C88
        fail "ROM end moved"
        endif
