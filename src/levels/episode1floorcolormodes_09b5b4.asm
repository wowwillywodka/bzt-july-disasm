; $09B5B4..$09B5BF | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B5B4
        fail "ROM start moved"
        endif

Episode1FloorColorModes equ $09B5B4

        incbin "generated/data/09b5b4.bin"
        ifne *-$9B5C0
        fail "ROM end moved"
        endif
