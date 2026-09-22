; $1A4176..$1C4575 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1A4176
        fail "ROM start moved"
        endif

GunnerSpriteBank_Tiles equ $1A4176

        incbin "generated/data/1a4176.bin"
        ifne *-$1C4576
        fail "ROM end moved"
        endif
