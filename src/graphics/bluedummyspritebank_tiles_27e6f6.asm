; $27E6F6..$29ACF5 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$27E6F6
        fail "ROM start moved"
        endif

BlueDummySpriteBank_Tiles equ $27E6F6

        incbin "generated/data/27e6f6.bin"
        ifne *-$29ACF6
        fail "ROM end moved"
        endif
