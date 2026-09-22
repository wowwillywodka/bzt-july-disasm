; $09B840..$09B8DF | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B840
        fail "ROM start moved"
        endif

Episode1BackgroundProfile4 equ $09B840

        incbin "generated/data/09b840.bin"
        ifne *-$9B8E0
        fail "ROM end moved"
        endif
