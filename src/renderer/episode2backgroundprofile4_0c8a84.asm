; $0C8A84..$0C8B23 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C8A84
        fail "ROM start moved"
        endif

Episode2BackgroundProfile4 equ $0C8A84

        incbin "generated/data/0c8a84.bin"
        ifne *-$C8B24
        fail "ROM end moved"
        endif
