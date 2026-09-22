; $07AEF0..$07AF03 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7AEF0
        fail "ROM start moved"
        endif

CharacterMenuPortraitPalettePointers equ $07AEF0

        incbin "generated/data/07aef0.bin"
        ifne *-$7AF04
        fail "ROM end moved"
        endif
