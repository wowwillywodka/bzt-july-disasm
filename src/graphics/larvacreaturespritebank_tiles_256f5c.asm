; $256F5C..$27D95B | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$256F5C
        fail "ROM start moved"
        endif

LarvaCreatureSpriteBank_Tiles equ $256F5C

        incbin "generated/data/256f5c.bin"
        ifne *-$27D95C
        fail "ROM end moved"
        endif
