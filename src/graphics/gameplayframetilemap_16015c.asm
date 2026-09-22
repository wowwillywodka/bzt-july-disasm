; $16015C..$160A1B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$16015C
        fail "ROM start moved"
        endif

GameplayFrameTilemap equ $16015C

        incbin "generated/data/16015c.bin"
        ifne *-$160A1C
        fail "ROM end moved"
        endif
