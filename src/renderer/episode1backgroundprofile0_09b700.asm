; $09B700..$09B79F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B700
        fail "ROM start moved"
        endif

Episode1BackgroundProfile0 equ $09B700

        incbin "generated/data/09b700.bin"
        ifne *-$9B7A0
        fail "ROM end moved"
        endif
