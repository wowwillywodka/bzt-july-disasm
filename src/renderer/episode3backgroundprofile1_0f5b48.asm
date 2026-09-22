; $0F5B48..$0F5BE7 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5B48
        fail "ROM start moved"
        endif

Episode3BackgroundProfile1 equ $0F5B48

        incbin "generated/data/0f5b48.bin"
        ifne *-$F5BE8
        fail "ROM end moved"
        endif
