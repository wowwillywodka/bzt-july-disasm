; $1654E2..$1848E1 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1654E2
        fail "ROM start moved"
        endif

BloodBodySpriteBank_Tiles equ $1654E2

        incbin "generated/data/1654e2.bin"
        ifne *-$1848E2
        fail "ROM end moved"
        endif
