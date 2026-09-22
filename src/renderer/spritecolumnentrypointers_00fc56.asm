; $00FC56..$00FD99 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$FC56
        fail "ROM start moved"
        endif

SpriteColumnEntryPointers equ $00FC56

        incbin "generated/data/00fc56.bin"
        ifne *-$FD9A
        fail "ROM end moved"
        endif
