; $09B7A0..$09B83F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B7A0
        fail "ROM start moved"
        endif

Episode1BackgroundProfile3 equ $09B7A0

        incbin "generated/data/09b7a0.bin"
        ifne *-$9B840
        fail "ROM end moved"
        endif
