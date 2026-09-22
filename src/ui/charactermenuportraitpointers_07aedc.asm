; $07AEDC..$07AEEF | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7AEDC
        fail "ROM start moved"
        endif

CharacterMenuPortraitPointers equ $07AEDC

        incbin "generated/data/07aedc.bin"
        ifne *-$7AEF0
        fail "ROM end moved"
        endif
