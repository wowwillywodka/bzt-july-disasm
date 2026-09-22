; $002BA8..$002BBB | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2BA8
        fail "ROM start moved"
        endif

CharacterPortraitPalettePointers equ $002BA8

        incbin "generated/data/002ba8.bin"
        ifne *-$2BBC
        fail "ROM end moved"
        endif
