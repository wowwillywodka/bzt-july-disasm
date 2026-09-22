; $002B94..$002BA7 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B94
        fail "ROM start moved"
        endif

CharacterPortraitGraphicsPointers equ $002B94

        incbin "generated/data/002b94.bin"
        ifne *-$2BA8
        fail "ROM end moved"
        endif
