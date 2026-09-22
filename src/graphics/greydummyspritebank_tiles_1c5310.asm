; $1C5310..$1E190F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1C5310
        fail "ROM start moved"
        endif

GreyDummySpriteBank_Tiles equ $1C5310

        incbin "generated/data/1c5310.bin"
        ifne *-$1E1910
        fail "ROM end moved"
        endif
