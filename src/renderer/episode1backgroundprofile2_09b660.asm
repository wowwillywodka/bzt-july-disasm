; $09B660..$09B6FF | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B660
        fail "ROM start moved"
        endif

Episode1BackgroundProfile2 equ $09B660

        incbin "generated/data/09b660.bin"
        ifne *-$9B700
        fail "ROM end moved"
        endif
