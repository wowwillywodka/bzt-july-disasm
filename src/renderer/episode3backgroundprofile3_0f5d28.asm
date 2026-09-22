; $0F5D28..$0F5DC7 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5D28
        fail "ROM start moved"
        endif

Episode3BackgroundProfile3 equ $0F5D28

        incbin "generated/data/0f5d28.bin"
        ifne *-$F5DC8
        fail "ROM end moved"
        endif
