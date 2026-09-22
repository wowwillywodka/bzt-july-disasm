; $0C8944..$0C89E3 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C8944
        fail "ROM start moved"
        endif

Episode2BackgroundProfile0 equ $0C8944

        incbin "generated/data/0c8944.bin"
        ifne *-$C89E4
        fail "ROM end moved"
        endif
