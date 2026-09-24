; $07AEF0..$07AF03 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
; Five 16x12 portrait tilemaps; the menu skips the first row.
        ifne *-$7AEF0
        fail "ROM start moved"
        endif

CharacterMenuPortraitTilemapPointers equ $07AEF0

        incbin "generated/data/07aef0.bin"
        ifne *-$7AF04
        fail "ROM end moved"
        endif
