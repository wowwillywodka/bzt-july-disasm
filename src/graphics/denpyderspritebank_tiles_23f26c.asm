; $23F26C..$25626B | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23F26C
        fail "ROM start moved"
        endif

DenpyderSpriteBank_Tiles equ $23F26C

        incbin "generated/data/23f26c.bin"
        ifne *-$25626C
        fail "ROM end moved"
        endif
