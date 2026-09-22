; $1855A4..$1A35A3 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1855A4
        fail "ROM start moved"
        endif

StananSpriteBank_Tiles equ $1855A4

        incbin "generated/data/1855a4.bin"
        ifne *-$1A35A4
        fail "ROM end moved"
        endif
