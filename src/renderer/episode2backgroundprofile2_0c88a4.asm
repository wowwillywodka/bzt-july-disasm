; $0C88A4..$0C8943 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C88A4
        fail "ROM start moved"
        endif

Episode2BackgroundProfile2 equ $0C88A4

        incbin "generated/data/0c88a4.bin"
        ifne *-$C8944
        fail "ROM end moved"
        endif
