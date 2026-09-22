; $0F5DC8..$0F5E67 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5DC8
        fail "ROM start moved"
        endif

Episode3BackgroundProfile4 equ $0F5DC8

        incbin "generated/data/0f5dc8.bin"
        ifne *-$F5E68
        fail "ROM end moved"
        endif
