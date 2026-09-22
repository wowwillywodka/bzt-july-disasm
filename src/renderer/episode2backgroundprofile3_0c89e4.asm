; $0C89E4..$0C8A83 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C89E4
        fail "ROM start moved"
        endif

Episode2BackgroundProfile3 equ $0C89E4

        incbin "generated/data/0c89e4.bin"
        ifne *-$C8A84
        fail "ROM end moved"
        endif
