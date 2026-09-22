; $09B5C0..$09B65F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B5C0
        fail "ROM start moved"
        endif

Episode1BackgroundProfile1 equ $09B5C0

        incbin "generated/data/09b5c0.bin"
        ifne *-$9B660
        fail "ROM end moved"
        endif
